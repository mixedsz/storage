--[[
    Provided below is the stash configuration, allowing you to make
    adjustments or create your own. If your inventory is not included,
    you have the option to request the creator to generate a file based
    on this example and include it.
]]

local sharedConfig = require 'config.shared'
if sharedConfig.inventory ~= "qs-inventory" then
    return
end

if IsDuplicityVersion() then
    function DeleteInventory(storageId)
        -- idk how this shit inventory stores the stashes so I'm just expecting to work like the qb-inventory as all of their scripts are just stolen qb resources
        MySQL.query('DELETE FROM stashitems WHERE stash = ?', { 'Storage_' .. storageId })
    end
else
    function OpenInventory(storage)
        local slots, weight = storage:getInventoryData()
        local others = {
            maxweight = weight,
            slots = slots
        }

        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Stash_"..storage.id, others)
        TriggerEvent("inventory:client:SetCurrentStash", "Stash_"..storage.id)
    end
end
