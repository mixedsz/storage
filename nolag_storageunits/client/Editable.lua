RegisterNetEvent(OnPlayerLoadedEvent, function()
    AddTextEntry('BLIP_CAT_56', locale("blip_category_owned"))   -- Owned Storages
    AddTextEntry('BLIP_CAT_57', locale("blip_category_owner"))   -- Your Storages
    AddTextEntry('BLIP_CAT_58', locale("blip_category_unowned")) -- Available Storages
    AddTextEntry('BLIP_CAT_59', locale("blip_category_expired")) -- Expired Storages
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= cache.resource then return end

    AddTextEntry('BLIP_CAT_56', locale("blip_category_owned"))   -- Owned Storages
    AddTextEntry('BLIP_CAT_57', locale("blip_category_owner"))   -- Your Storages
    AddTextEntry('BLIP_CAT_58', locale("blip_category_unowned")) -- Available Storages
    AddTextEntry('BLIP_CAT_59', locale("blip_category_expired")) -- Expired Storages
end)

-- A Utility Function to Add a Blip
---@param coords table
---@param blipConfig table - Contains sprite, color, scale, display, category
---@param label string
function AddBlip(coords, blipConfig, label)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, blipConfig.sprite)
    SetBlipDisplay(blip, blipConfig.display)
    SetBlipScale(blip, blipConfig.scale)
    SetBlipColour(blip, blipConfig.color)
    SetBlipAsShortRange(blip, true)

    -- Set blip category if specified
    if blipConfig.category then
        SetBlipCategory(blip, blipConfig.category)
    end

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(label)
    EndTextCommandSetBlipName(blip)
    return blip
end
