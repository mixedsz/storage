return {
    debug = false,

    --[[
        * ox_inventory (Recommended)
        * qb-inventory
        * qs-inventory
        * chezza
    --]]
    inventory = 'ox_inventory',

    --[[
        * ox_lib
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
        * discord (configure the webhook in custom/logs/discord.lua)
    --]]
    logs = 'discord',

    --[[
        * default (qb-banking or qb-management; esx_addonaccount)
    ]]
    banking = "default",

    -- ESX groups that are allowed to manage storages (/storages, /createstorage, etc.)
    -- Add your custom admin groups here (e.g. 'owner', 'manager')
    adminGroups = { 'superadmin', 'admin', 'mod', 'owner' },

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
    maxWeight = 2500000,

    enableManualPaymentRetry = true,

    paymentCheckInterval = 60,
}
