--[[
    Provided below is the stash configuration, allowing you to make
    adjustments or create your own. If your inventory is not included,
    you have the option to request the creator to generate a file based
    on this example and include it.
]]

local sharedConfig = require 'config.shared'
if sharedConfig.inventory ~= "ox_inventory" then
    return
end

if IsDuplicityVersion() then
    function RegisterStash(name, label, maxSlots, maxWeight, coords)
        exports.ox_inventory:RegisterStash(name, label, maxSlots, maxWeight)
    end

    function DeleteInventory(storageId)
        exports.ox_inventory:ClearInventory('Storage_' .. storageId)
    end

    function ForceOpenInventory(playerId, storageId)
        exports.ox_inventory:forceOpenInventory(playerId, 'stash', "Storage_" .. storageId)
    end
else
    -- Server force-opens the stash via ForceOpenInventory after password validation.
    -- Client-side openInventory is not needed for ox_inventory.
    function OpenInventory(storage) end
end
