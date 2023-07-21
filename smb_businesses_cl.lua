QBCore = exports['qb-core']:GetCoreObject()
local businessZones = {}
local isInsideZone = false
local playerJob = nil
local isOnDuty = nil

local DrawText3Ds = function(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function LoadAnimationDictionary(animation)
	while not HasAnimDictLoaded(animation) do
		RequestAnimDict(animation)
        Citizen.Wait(10)
	end
end

local function ToggleDuty()

    if playerJob == 'burgershot' then 
        if isInsideZone == false and isOnDuty then
            TriggerServerEvent('QBCore:ToggleDuty')
        elseif isInsideZone == true then
            isOnDuty = not isOnDuty
            TriggerServerEvent('QBCore:ToggleDuty')
        else
            return
        end
    end
end

local function PerformWorkAction(workArea)
    local products = workArea.Products

    if workArea.IsStash then
        TriggerEvent('smb_businesses:client:OpenStash', workArea.StashName, workArea.StashNumber)
    elseif workArea.IsStorage then
        if isOnDuty then
            TriggerEvent('smb_businesses:client:OpenStash', workArea.StorageName, workArea.StorageNumber)
        else
            QBCore.Functions.Notify("You must be on duty to perform this action.", "error")
        end
    elseif workArea.IsCashier then
        if playerJob == "burgershot" and isOnDuty then
            TriggerEvent('smb_businesses:client:GenerateBill')
        else
            TriggerEvent('smb_businesses:client:MakePayment')
        end
    elseif workArea.IsClockingIn then
        ToggleDuty()
    else
        if not isOnDuty then
            QBCore.Functions.Notify("You must be on duty to perform this action.", "error")
            return
        end

        local menuData = {
            {
                header = 'Select Product',
                isMenuHeader = true,
            }
        }

        for product, productData in pairs(products) do
            local button = {
                header = productData.Name,
                txt = 'Make ' .. productData.Name,
                icon = 'fas fa-code-merge',
                params = {
                    event = 'smb_businesses:client:MakeProduct',
                    args = {
                        product = {
                            product = product,
                            name = productData.Name,
                            materials = productData.Materials,
                            animationLib = productData.AnimationLib,
                            animationName = productData.AnimationName,
                            animationDesc = productData.AnimationDesc
                        },
                        workArea = workArea.Name,
                    }
                }
            }
            table.insert(menuData, button)
        end

        TriggerEvent('qb-menu:client:openMenu', menuData)
    end
end

RegisterNetEvent('smb_businesses:client:MakeProduct')
AddEventHandler('smb_businesses:client:MakeProduct', function(data)
    local product = data.product
    local workArea = data.workArea
    local hasMaterials = true

    for _, material in ipairs(product.materials) do
        if not QBCore.Functions.HasItem(material.Item, material.Amount) then
            hasMaterials = false
            QBCore.Functions.Notify("You don't have the required " .. material.Item .. " to make " .. product.name, "error")
            break
        end
    end

    if hasMaterials then
        TriggerEvent('qb-inventory:client:set:busy', true)
        LoadAnimationDictionary(product.animationLib)
        TaskPlayAnim(PlayerPedId(), product.animationLib, product.animationName, 3.0, 3.0, -1, 8, 0, false, false, false)
        QBCore.Functions.Progressbar("Making", product.animationDesc, 7500, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
            TriggerServerEvent("smb_businesses:server:PerformWorkAction", product.product, product.materials)
            TriggerEvent('qb-inventory:client:set:busy', false)
            StopAnimTask(PlayerPedId(), product.animationLib, workArea.animationName, 1.0)
        end, function()
            TriggerEvent('qb-inventory:client:set:busy', false)
            QBCore.Functions.Notify("Canceled..", "error")
            StopAnimTask(PlayerPedId(), product.animationLib, workArea.animationName, 1.0)
        end)
    end
end)

local function StartWorkLoops()
    Citizen.CreateThread(function()
        while isInsideZone do
            Citizen.Wait(1)
            local playerCoords = GetEntityCoords(PlayerPedId())

            for _, business in ipairs(Config.Businesses) do
                local workAreas = business.WorkAreas

                for _, workArea in ipairs(workAreas) do
                    local workAreaCoords = workArea.Coords
                    local distance = #(playerCoords - vector3(workAreaCoords.X, workAreaCoords.Y, workAreaCoords.Z))

                    if distance <= 2.0 then
                        if (workArea.IsCashier or workArea.IsStash) and distance <= 1 then
                            DrawText3Ds(workAreaCoords.X, workAreaCoords.Y, workAreaCoords.Z, workArea.Name .. ' ~y~[E]~w~')
                            if IsControlJustPressed(0, 38) then
                                PerformWorkAction(workArea)
                            end
                        elseif workArea.IsClockingIn and playerJob == 'burgershot' then
                            DrawText3Ds(workAreaCoords.X, workAreaCoords.Y, workAreaCoords.Z, workArea.Name .. ' ~y~[E]~w~')
                            if IsControlJustPressed(0, 38) then
                                PerformWorkAction(workArea)
                            end
                        elseif playerJob == 'burgershot' and distance <= 1 then
                            DrawText3Ds(workAreaCoords.X, workAreaCoords.Y, workAreaCoords.Z, workArea.Name .. ' ~y~[E]~w~')
                            if IsControlJustPressed(0, 38) then
                                PerformWorkAction(workArea)
                            end
                        end
                    end
                end
            end
        end
    end)
end

CreateThread(function()
    for _, business in ipairs(Config.Businesses) do
        if business.Open then
            local zone = PolyZone:Create(business.PolyZone.points, {
                name = business.Name,
                debugPoly = Config.Debug,
                minZ = business.PolyZone.minZ - 10,
                maxZ = business.PolyZone.maxZ + 8
            })

            businessZones[business.Name] = zone

            zone:onPlayerInOut(function(isPointInside)
                if isPointInside then
                    isInsideZone = true
                    TriggerServerEvent('smb_businesses:server:EnterBusinessZone')
                    playerJob = QBCore.Functions.GetPlayerData().job.name
                    isOnDuty = QBCore.Functions.GetPlayerData().job.onduty
                    StartWorkLoops(business)
                else
                    isInsideZone = false
                    TriggerServerEvent('smb_businesses:server:ExitBusinessZone')
                    ToggleDuty()
                end
            end)
        end
    end
end)

RegisterNetEvent('smb_businesses:client:GenerateBill')
AddEventHandler('smb_businesses:client:GenerateBill', function()
    local data = exports['qb-input']:ShowInput({
        header = "Generate Bill",
        submitText = "Send Bill",
        inputs = {
            {
                text = "Recipient ID",
                name = "id",
                type = "number",
                isRequired = true
            },
            {
                text = "Amount",
                name = "amount",
                type = "number",
                isRequired = true
            },
            {
                text = "Reason",
                name = "reason",
                type = "text",
                isRequired = true
            },
            {
                text = "Payment Method",
                name = "paymentMethod",
                type = "radio",
                isRequired = true,
                options = {
                    {text = "Bill Invoice", value = "invoice"},
                    {text = "Cash", value = "cash"}
                }
            }
        }
    })

    if data ~= nil then
        local id = tonumber(data.id)
        local amount = tonumber(data.amount)
        local reason = data.reason
        local paymentMethod = data.paymentMethod

        if id and amount and amount > 0 and reason then
            if paymentMethod == "invoice" then
                TriggerServerEvent('smb_businesses:server:SendInvoice', id, amount, reason)
            elseif paymentMethod == "cash" then
                TriggerServerEvent('smb_businesses:server:SendBill', id, amount, reason)
            end
        else
            QBCore.Functions.Notify("Invalid input. Please provide valid recipient ID, amount, and reason.", "error")
        end
    end
end)

RegisterNetEvent('smb_businesses:client:MakePayment')
AddEventHandler('smb_businesses:client:MakePayment', function()
    QBCore.Functions.TriggerCallback('smb_businesses:server:GetBills', function(bills)
        if bills and #bills > 0 then
            local billOptions = {}
            for _, bill in ipairs(bills) do
                local option = {
                    value = bill.id,
                    text = "Amount: $" .. bill.amount .. " | Society: " .. bill.society .. " | Sender: " .. bill.sender .. " | Reason: " .. bill.reason
                }
                table.insert(billOptions, option)
            end

            local data = exports['qb-input']:ShowInput({
                header = "Make Payment",
                inputs = {
                    {
                        text = "Select Bill",
                        name = "billID",
                        type = "select",
                        isRequired = true,
                        options = billOptions
                    },
                    {
                        text = "Payment Action",
                        name = "paymentAction",
                        type = "select",
                        isRequired = true,
                        options = {
                            { value = "pay", text = "Pay" },
                            { value = "decline", text = "Decline" }
                        }
                    }
                },
                submitText = "Submit"
            })

            if data ~= nil then
                local billID = tonumber(data.billID)
                local paymentAction = data.paymentAction

                if billID then
                    if paymentAction == "pay" then
                        TriggerServerEvent('smb_businesses:server:PayBill', billID)
                    elseif paymentAction == "decline" then
                        print("Decline")
                    else
                        QBCore.Functions.Notify("Invalid payment action selected.", "error")
                    end
                else
                    QBCore.Functions.Notify("Invalid bill selection.", "error")
                end
            end
        else
            QBCore.Functions.Notify("No bills available to process.", "error")
        end
    end)
end)


RegisterNetEvent('smb_businesses:client:OpenStash', function(stashName, stashNumber)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName.. stashNumber)
    TriggerEvent("inventory:client:SetCurrentStash", stashName.. stashNumber)
end)

  