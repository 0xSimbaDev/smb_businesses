local QBCore = exports['qb-core']:GetCoreObject()
local playersInZone = {}

RegisterServerEvent('smb_businesses:server:EnterBusinessZone')
AddEventHandler('smb_businesses:server:EnterBusinessZone', function()
    local src = source
    playersInZone[src] = true
    print(playersInZone)
end)

RegisterServerEvent('smb_businesses:server:ExitBusinessZone')
AddEventHandler('smb_businesses:server:ExitBusinessZone', function()
    local src = source
    playersInZone[src] = nil
    print(playersInZone)
end)
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end
RegisterServerEvent('smb_businesses:server:PerformWorkAction')
AddEventHandler('smb_businesses:server:PerformWorkAction', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local product = data.product
    local materials = data.materials
    local yield = 1

    if data.yield then
        yield = data.yield
    end
    print(dump(data))
    print(product)
    print(materials)
    print(yield)
    if not product or not materials or #materials == 0 then
        return
    end

    for _, material in ipairs(materials) do
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[material.Item], "remove")
        Player.Functions.RemoveItem(material.Item, material.Amount)
    end

    TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[product], "add")
    Player.Functions.AddItem(product, data.yield)
end)

RegisterServerEvent('smb_businesses:server:SendInvoice')
AddEventHandler('smb_businesses:server:SendInvoice', function(id, amount, reason)
    local src = source
    local biller = QBCore.Functions.GetPlayer(src)
    local billed = QBCore.Functions.GetPlayer(tonumber(id))
    local amount = tonumber(amount)

    if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
        if amount and amount > 0 then
            MySQL.insert(
                'INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',
                {billed.PlayerData.citizenid, amount, biller.PlayerData.job.name, biller.PlayerData.charinfo.firstname, biller.PlayerData.citizenid})
            TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
            TriggerClientEvent('QBCore:Notify', src, 'Invoice Successfully Sent', 'success')
            TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
        else
            TriggerClientEvent('QBCore:Notify', src, 'Must Be A Valid Amount Above 0', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You cannot send an invoice to yourself.', 'error')
    end
end)

RegisterServerEvent('smb_businesses:server:SendBill')
AddEventHandler('smb_businesses:server:SendBill', function(id, amount, reason)
    local src = source
    local biller = QBCore.Functions.GetPlayer(src)
    local billed = QBCore.Functions.GetPlayer(tonumber(id))
    local amount = tonumber(amount)

    if not playersInZone[src] then
        TriggerClientEvent('QBCore:Notify', src, 'You can only send a bill when you are inside the business zone.', 'error')
        return
    end

    if not playersInZone[billed.PlayerData.source] then
        TriggerClientEvent('QBCore:Notify', src, 'The target player must be within the business zone to send a bill.', 'error')
        return
    end

    if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
        if amount and amount > 0 then
            local timestamp = os.date('%Y-%m-%d %H:%M:%S')
            MySQL.Async.insert(
                'INSERT INTO smb_billing (citizenid, amount, society, sender, sendercitizenid, reason, timestamp) VALUES (?, ?, ?, ?, ?, ?, ?)',
                {billed.PlayerData.citizenid, amount, biller.PlayerData.job.name, biller.PlayerData.charinfo.firstname, biller.PlayerData.citizenid, reason, timestamp},
                function(insertId)
                    if insertId then
                        TriggerClientEvent('QBCore:Notify', src, 'Bill successfully sent!', 'success')
                        TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New bill received')
                    else
                        TriggerClientEvent('QBCore:Notify', src, 'Failed to send bill', 'error')
                    end
                end
            )
        else
            TriggerClientEvent('QBCore:Notify', src, 'Amount must be a valid number greater than 0', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You cannot bill yourself', 'error')
    end
end)

QBCore.Functions.CreateCallback('smb_businesses:server:GetBills', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        local citizenId = player.PlayerData.citizenid

        MySQL.Async.fetchAll('SELECT * FROM smb_billing WHERE citizenid = @citizenid AND status = "pending"', {
            ['@citizenid'] = citizenId
        }, function(result)
            if result then
                cb(result)
            else
                cb(nil)
            end
        end)
    else
        cb(nil)
    end
end)

RegisterServerEvent('smb_businesses:server:PayBill')
AddEventHandler('smb_businesses:server:PayBill', function(billID)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if player then
        MySQL.Async.fetchAll('SELECT * FROM smb_billing WHERE id = @billID', {
            ['@billID'] = billID
        }, function(result)
            if result and #result > 0 then
                local bill = result[1]
                local society = bill.society
                local billAmount = bill.amount

                if player.Functions.RemoveMoney('cash', billAmount) then
                    exports['qb-management']:AddMoney(society, billAmount) 

                    MySQL.Async.execute('UPDATE smb_billing SET status = @status WHERE id = @billID', {
                        ['@status'] = 'Paid',
                        ['@billID'] = billID
                    }, function(rowsAffected)
                        if rowsAffected > 0 then
                            TriggerClientEvent('QBCore:Notify', src, 'Bill paid successfully!', 'success')
                        else
                            TriggerClientEvent('QBCore:Notify', src, 'Error occurred while processing the payment.', 'error')
                        end
                    end)
                else
                    TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money to pay the bill.', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', src, 'Invalid bill ID.', 'error')
            end
        end)
    end
end)


