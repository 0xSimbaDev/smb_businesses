# smb_businesses

## Description
This project is a custom business script for FiveM servers. Players can interact with work areas, use materials, and make products.

## Features
- Multiple work areas with unique animations and materials.
- Progress bar system for making products.
- Integrated with qb-menu for interactive menus.
- Integrated with qb-input for user-friendly input handling.
- Configurable to add multiple businesses through the configuration file.
- **Multiple billing options for customer payments: cash and invoice.** When a player interacts with a cashier work area, the script will check if the player is on duty and part of the designated job (e.g., "burgershot"). If the conditions are met, the script will generate a bill for the customer to pay through the invoice system. Otherwise, it will use the default cash payment method.

## Author

This project was created by [0xSimbaDev](https://github.com/0xSimbaDev). 

## Configuration

You can configure the businesses, work areas, products, and materials in the `config.lua` file.

### Adding a New Business

To add a new business, follow these steps:

1. Add a new entry to the `Config.Businesses` table in `config.lua`.
2. Define the business name, whether it's open, its coordinates, and allowed jobs.
3. Define the work areas for the business, each with its own name, coordinates, prop, and other properties.
4. Specify the products that can be made at each work area, along with their animations, materials, and other details.
