return {
    debug = false,

    --[[
        * ox_inventory (Recommended - don't use the other shit ones)
        * qb-inventory
        * qs-inventory
        * chezza
    --]]
    inventory = 'ox_inventory',

    --[[
        * ox_lib
        * jg-textui
        * okokTextUI
        * ps-ui
        * qb-DrawText
    --]]
    textui = 'ox_lib',

    --[[
        * ox_lib
        * okokNotify
        * esx
        * qb
    --]]
    notifications = 'ox_lib',

    --[[
        * ox_lib
        * discord (you need to setup the webhook in custom/logs/discord.lua)
    --]]
    logs = 'discord',

    --[[
        * tgg-banking
        * Renewed-Banking
        * snipe-banking
        * okokBanking
        * fd_banking
        * default (qb-banking or qb-management; esx_addonaccount)
    ]]
    banking = "snipe-banking",

    realEstateJobs = {
        ['realestate'] = 0,
    },

    policeRaid = {
        jobs = {
            ['police'] = 2,
        },
    },

    defaultSlots = 20,
    defaultWeight = 1500000,

    maxSlots = 40,
    maxWeight = 2500000
}
