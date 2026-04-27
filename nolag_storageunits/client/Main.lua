local clientConfig = lib.load("config.client")
local sharedConfig = lib.load("config.shared")

Storage = lib.class("Storage")

function Storage:constructor(id, data)
    self.id = id
    self.coords = data.coords
    self.owner = data.owner
    self.label = data.label
    self.first_rented_date = data.first_rented_date
    self.expiring_date = data.expiring_date
    self.expired = data.expired or false
    self.failed_payments = data.failed_payments
    self.next_payment_attempt = data.next_payment_attempt
    self.rental_days = data.rental_days
    self.price = data.price
    self.blip = {
        enabled = data.blip or false,
        handle = nil
    }
    self.inventory = data.inventory
    self.forever = data.forever
    self.zone = nil
    self:createZones()
    if data.blip then
        self:createBlip()
    end
end

function Storage:createZones()
    lib.print.debug("Creating zones for storage", self.id)
    if clientConfig.targetEnabled then
        local zoneId = exports.ox_target:addSphereZone({
            coords = self.coords,
            radius = 1.25,
            debug = sharedConfig.debug,
            options = {
                {
                    name = string.format("Storage_%s", self.id),
                    icon = "fas fa-box",
                    label = locale("open_storage"),
                    distance = clientConfig.storageInteractDistance,
                    onSelect = function()
                        self:manage()
                    end
                }
            }
        })
        self.zone = zoneId
    else
        self.zone = lib.zones.sphere({
            coords = self.coords,
            radius = clientConfig.storageInteractDistance,
            debug = sharedConfig.debug,
            onEnter = function()
                Utils.AddInteraction(locale("keybind_open", clientConfig.keybinds.interact), function()
                    self:manage()
                end)
            end,
            onExit = function()
                Utils.RemoveInteraction()
            end
        })
    end
end

function Storage:createBlip()
    if not self:shouldShowBlip() then return end
    lib.print.debug("Creating blip for storage", self.id)
    local blipType = self:getBlipType()
    local blipConfig = clientConfig.blipData[blipType]
    if blipConfig then
        self.blip.handle = AddBlip(self.coords, blipConfig, self.label)
    end
end

function Storage:delete()
    lib.print.debug("Deleting storage", self.id)
    if type(self.zone) == "number" then
        exports.ox_target:removeZone(self.zone)
    else
        if self.zone then
            if self.zone.remove then
                self.zone:remove()
            end
        end
    end
    if self.blip.handle then
        self:deleteBlip()
    end
    self = nil
end

function Storage:deleteBlip()
    if not self.blip.handle then return end
    lib.print.debug("Deleting blip for storage", self.id)
    RemoveBlip(self.blip.handle)
    self.blip.handle = nil
end

function Storage:isExpired()
    return self.expired
end

function Storage:isOwner()
    return self.owner == PlayerData.identifier
end

function Storage:isOwned()
    return self.owner ~= nil
end

function Storage:isForever()
    return self.forever == true
end

function Storage:isRented()
    return self.first_rented_date ~= nil
end

function Storage:shouldShowBlip()
    if not self.blip.enabled then
        return false
    end
    local blipType = self:getBlipType()
    local blipConfig = clientConfig.blipData[blipType]
    local result = blipConfig
    if blipConfig then
        result = blipConfig.enabled == true
    end
    return result
end

function Storage:getBlipType()
    if self:isExpired() then
        return "expired"
    elseif self:isOwner() then
        return "owner"
    elseif self:isOwned() then
        return "owned"
    else
        return "unowned"
    end
end

function Storage:getOwnerNames()
    return lib.callback.await("nolag_storageunits:server:getPlayerNames", false, self.owner)
end

function Storage:getInventoryData()
    local slots = sharedConfig.defaultSlots
    local weight = sharedConfig.defaultWeight
    if self.inventory and self.inventory.slots and self.inventory.weight then
        slots = self.inventory.slots
        weight = self.inventory.weight
    end
    return slots, weight
end

function Storage:updateData(data)
    if not data then return end
    self.owner = data.owner
    self.label = data.label
    self.first_rented_date = data.first_rented_date
    self.expiring_date = data.expiring_date
    self.expired = data.expired or false
    self.failed_payments = data.failed_payments
    self.next_payment_attempt = data.next_payment_attempt
    self.rental_days = data.rental_days
    self.price = data.price
    self.inventory = data.inventory
    self.forever = data.forever

    self.blip.enabled = data.blip

    local shouldShow = self:shouldShowBlip()

    if data.blip == false then
        if self.blip.handle then
            self:deleteBlip()
        end
    elseif data.blip == true then
        if self.blip.handle and not shouldShow then
            self:deleteBlip()
        elseif not self.blip.handle and shouldShow then
            self:createBlip()
        elseif self.blip.handle and shouldShow then
            self:deleteBlip()
            self:createBlip()
        end
    end
end

function Storage:manage()
    local options = {}

    if self:isOwned() then
        options[#options + 1] = Utils.CreateMenuOption("locale_open_storage", nil, "fas fa-box", function()
            self:open()
        end)

        if not self:isExpired() then
            if self:isOwner() then
                options[#options + 1] = Utils.CreateMenuOption("locale_change_password", nil, "fas fa-key", function()
                    self:changePassword()
                end)
                options[#options + 1] = Utils.CreateMenuOption("locale_transfer_storage", nil, "fas fa-exchange-alt", function()
                    self:transferStorage()
                end)
                if not self:isForever() then
                    options[#options + 1] = Utils.CreateMenuOption("locale_cancel_subscription", nil, "fas fa-ban", function()
                        self:cancelSubscription()
                    end)
                end
            end
        else
            if self:isOwner() then
                if sharedConfig.enableManualPaymentRetry then
                    options[#options + 1] = Utils.CreateMenuOption("locale_retry_payment", nil, "fas fa-credit-card", function()
                        self:retryPayment()
                    end)
                end
            end
        end

        if Framework.isPlayerAuthorizedToRaid() then
            options[#options + 1] = Utils.CreateMenuOption("locale_raid_storage", nil, "fas fa-bomb", function()
                self:raid()
            end)
        end
    end

    if #options > 0 then
        lib.registerContext({
            id = "storageunits_manage",
            title = self.label,
            options = options
        })
        lib.showContext("storageunits_manage")
    else
        self:open()
    end
end

function Storage:open()
    if self:isOwned() then
        if self:isExpired() then
            Utils.Notify("expired_storage", "error", 5000)
            return
        end

        local input = lib.inputDialog(locale("storage"), {
            { type = "input", label = locale("enter_password"), password = true, icon = "lock" }
        })
        if not input then return end

        local valid = lib.callback.await("nolag_storageunits:server:validatePassword", false, self.id, input[1])
        if valid then
            OpenInventory(self)
        else
            Utils.Notify("wrong_password", "error", 5000)
        end
    else
        if self:isForever() then
            local confirm = lib.alertDialog({
                header = locale("buy_storage"),
                content = locale("buy_storage_description", self.price, self.inventory.slots, self.inventory.weight / 1000),
                centered = true,
                cancel = true,
                size = "lg"
            })
            if confirm ~= "confirm" then return end

            local input = lib.inputDialog(locale("options"), {
                { type = "input", label = locale("enter_password"), password = true, icon = "lock" }
            })
            if not input then return end

            local password = tostring(input[1])
            local success = lib.callback.await("nolag_storageunits:server:buyStorage", false, tonumber(self.id), password)
            if success then
                Utils.Notify("storage_bought", "success", 5000)
                -- Auto-open the storage right after purchase using the password just set
                Wait(300)
                local valid = lib.callback.await("nolag_storageunits:server:validatePassword", false, self.id, password)
                if valid then
                    OpenInventory(self)
                end
            else
                Utils.Notify("something_went_wrong", "error", 5000)
            end
        else
            local confirm = lib.alertDialog({
                header = locale("rent_storage"),
                content = locale("rent_storage_description", self.price, self.rental_days, self.inventory.slots, self.inventory.weight / 1000),
                centered = true,
                cancel = true,
                size = "lg"
            })
            if confirm ~= "confirm" then return end

            local input = lib.inputDialog(locale("options"), {
                { type = "input", label = locale("enter_password"), password = true, icon = "lock" }
            })
            if not input then return end

            local password = tostring(input[1])
            local success = lib.callback.await("nolag_storageunits:server:rentStorage", false, tonumber(self.id), password)
            if success then
                local dayText
                if self.rental_days == 1 then
                    dayText = locale("day_singular")
                else
                    dayText = string.format(locale("day_plural"), self.rental_days)
                end
                Utils.Notify(string.format(locale("rented_storage"), dayText), "success", 5000)
                -- Auto-open the storage right after renting using the password just set
                Wait(300)
                local valid = lib.callback.await("nolag_storageunits:server:validatePassword", false, self.id, password)
                if valid then
                    OpenInventory(self)
                end
            end
        end
    end
end

function Storage:changePassword()
    local input = lib.inputDialog(locale("options"), {
        { type = "input", label = locale("enter_password"), password = true, icon = "lock" },
        { type = "input", label = locale("new_password"), password = true, icon = "lock" }
    })
    if not input then return end

    local oldPassword = tostring(input[1])
    local newPassword = tostring(input[2])

    if oldPassword == newPassword then
        Utils.Notify("samePassword", "error", 5000)
        return
    end

    local success = lib.callback.await("nolag_storageunits:server:validateAndChangePassword", false, self.id, oldPassword, newPassword)
    if success then
        Utils.Notify("changed_password", "success", 5000)
        self:open()
    else
        Utils.Notify("wrong_password", "error", 5000)
    end
end

function Storage:cancelSubscription()
    local confirm = lib.alertDialog({
        header = locale("cancel_subscription"),
        content = locale("cancel_description"),
        centered = true,
        cancel = true
    })
    if confirm ~= "confirm" then return end

    local success = lib.callback.await("nolag_storageunits:server:cancelSubscription", false, self.id)
    if success then
        Utils.Notify("rent_canceled", "success", 5000)
    end
end

function Storage:retryPayment()
    local confirm = lib.alertDialog({
        header = locale("retry_payment"),
        content = locale("retry_payment_description", self.label, self.price),
        centered = true,
        cancel = true
    })
    if confirm ~= "confirm" then return end

    local success, message = lib.callback.await("nolag_storageunits:server:manualPaymentRetry", false, self.id)
    if success then
        Utils.Notify(message, "success", 5000)
        Wait(1000)
        self:open()
    else
        Utils.Notify(message, "error", 5000)
    end
end

function Storage:transferStorage()
    local nearbyPlayers = lib.getNearbyPlayers(GetEntityCoords(cache.ped), 10, false)
    if #nearbyPlayers == 0 then
        Utils.Notify("no_players_nearby", "error", 5000)
        return
    end

    local playerOptions = {}
    for _, player in ipairs(nearbyPlayers) do
        local serverId = GetPlayerServerId(player.id)
        local name = lib.callback.await("nolag_storageunits:server:getPlayerNames", false, serverId)
        playerOptions[#playerOptions + 1] = {
            label = name .. " - " .. serverId,
            value = serverId
        }
    end

    local input = lib.inputDialog(locale("transfer_storage"), {
        { type = "select", label = locale("select_player"), options = playerOptions },
        { type = "input", label = locale("enter_password"), password = true, icon = "lock" }
    })
    if not input then return end

    local targetId = tonumber(input[1])
    local password = tostring(input[2])
    local success, newOwner = lib.callback.await("nolag_storageunits:server:validateAndTransferStorage", false, self.id, password, targetId)
    if success then
        self.owner = newOwner
    else
        Utils.Notify("wrong_password", "error", 5000)
    end
end

lib.callback.register("nolag_storageunits:client:transferStorage", function(senderName)
    local confirm = lib.alertDialog({
        header = locale("transfer_storage"),
        content = locale("transfer_storage_description", senderName),
        centered = true,
        cancel = true
    })
    return confirm == "confirm"
end)

function Storage:adminManage()
    local options = {}

    options[#options + 1] = Utils.CreateMenuOption("locale_open_storage", nil, "fas fa-box", function()
        local success = lib.callback.await("nolag_storageunits:server:forceOpenInventory", false, self.id)
        if not success then
            Utils.Notify("not_authorized", "error", 5000)
        end
    end)

    options[#options + 1] = Utils.CreateMenuOption("locale_edit_storage", nil, "fas fa-edit", function()
        self:edit()
    end)

    options[#options + 1] = Utils.CreateMenuOption("locale_set_waypoint", nil, "fas fa-map-marker-alt", function()
        SetNewWaypoint(self.coords.x, self.coords.y)
        Utils.Notify("waypoint_set", "success", 5000)
    end)

    if self:isOwned() then
        options[#options + 1] = Utils.CreateMenuOption("locale_remove_renter", nil, "fas fa-user-slash", function()
            local success = lib.callback.await("nolag_storageunits:server:removeRenter", false, self.id)
            if success then
                Utils.Notify("renter_removed", "success", 5000)
            else
                Utils.Notify("something_went_wrong", "error", 5000)
            end
        end)

        if self:isExpired() then
            options[#options + 1] = Utils.CreateMenuOption("locale_unlock_storage", nil, "fas fa-lock-open", function()
                local success = lib.callback.await("nolag_storageunits:server:toggleLock", false, self.id, false)
                if success then
                    Utils.Notify("storage_unlocked", "success", 5000)
                    self.expired = false
                    if self.blip.handle then
                        self:deleteBlip()
                        self:createBlip()
                    end
                else
                    Utils.Notify("something_went_wrong", "error", 5000)
                end
                self:adminManage()
            end)
        else
            options[#options + 1] = Utils.CreateMenuOption("locale_lock_storage", nil, "fas fa-lock", function()
                local success = lib.callback.await("nolag_storageunits:server:toggleLock", false, self.id, true)
                if success then
                    Utils.Notify("storage_locked", "success", 5000)
                    self.expired = true
                    if self.blip.handle then
                        self:deleteBlip()
                        self:createBlip()
                    end
                else
                    Utils.Notify("something_went_wrong", "error", 5000)
                end
                self:adminManage()
            end)
        end
    end

    options[#options + 1] = Utils.CreateMenuOption("locale_delete_storage", nil, "fas fa-trash", function()
        self:destroy()
    end)

    lib.registerContext({
        id = "storageunits_manage",
        title = self.label,
        menu = "storages_manage",
        options = options
    })
    lib.showContext("storageunits_manage")
end

function Storage:edit()
    local blipEnabled = self.blip.enabled and true or false

    local input = lib.inputDialog(locale("edit_storage"), {
        {
            type = "input",
            label = locale("label"),
            description = locale("label_description"),
            required = true,
            min = 2,
            max = 16,
            default = self.label
        },
        {
            type = "number",
            label = locale("price"),
            description = locale("price_description"),
            required = true,
            icon = "dollar-sign",
            default = self.price
        },
        {
            type = "checkbox",
            label = locale("blip"),
            description = locale("blip_description"),
            checked = blipEnabled
        },
        {
            type = "slider",
            label = locale("rental_days"),
            description = locale("rental_days_description"),
            min = 1,
            max = 30,
            default = self.rental_days,
            icon = "fa-calendar"
        },
        {
            type = "number",
            label = locale("inventory_slots"),
            description = locale("inventory_slots_description"),
            required = true,
            min = 1,
            default = self.inventory.slots or sharedConfig.defaultSlots,
            max = sharedConfig.maxSlots,
            icon = "fa-box-open"
        },
        {
            type = "number",
            label = locale("inventory_weightlimit"),
            description = locale("inventory_weightlimit_description"),
            required = true,
            min = 1,
            default = self.inventory.weight or sharedConfig.defaultWeight,
            max = sharedConfig.maxWeight,
            icon = "fa-weight-hanging"
        }
    })
    if not input then return end

    local data = {
        label = input[1],
        price = input[2],
        blip = input[3],
        rental_days = input[4],
        inventory = {
            slots = input[5],
            weight = input[6]
        }
    }

    local success = lib.callback.await("nolag_storageunits:server:editStorage", false, self.id, data)
    if success then
        Utils.Notify("storage_edited", "success", 5000)
    else
        Utils.Notify("storage_edit_failed", "error", 5000)
    end

    Wait(500)
    manageStorages()
end

function Storage:raid()
    if not Framework.isPlayerAuthorizedToRaid() then
        Utils.Notify("not_authorized", "error", 5000)
        return
    end
    if not self:isOwned() then
        Utils.Notify("not_owned", "error", 5000)
        return
    end
    if self:isExpired() then
        Utils.Notify("expired_storage", "error", 5000)
        return
    end

    local success = clientConfig.RaidProperty()
    if success then
        Utils.Notify("storage_raid_success", "success", 5000)
        local opened = lib.callback.await("nolag_storageunits:server:raidStorage", false, self.id)
        if opened then
            OpenInventory(self)
        end
    else
        Utils.Notify("storage_raid_fail", "error", 5000)
    end
end

function Storage:destroy()
    local confirm = lib.alertDialog({
        header = locale("delete_storage"),
        content = locale("delete_storage_description"),
        centered = true,
        cancel = true
    })
    if confirm ~= "confirm" then return end

    local success = lib.callback.await("nolag_storageunits:server:deleteStorage", false, self.id)
    if success then
        Utils.Notify("storage_deleted", "success", 5000)
    end
end

function LoadStorages()
    StorageManager:loadStoragesFromDatabase()
end

local function handlePlayerLoaded()
    if not StorageManager:hasLoaded() then
        LoadStorages()
    end
end

RegisterNetEvent(OnPlayerLoadedEvent, function()
    PlayerData.loaded = true
    handlePlayerLoaded()
end)

RegisterNetEvent(OnPlayerUnloadedEvent, function()
    PlayerData.loaded = false
    StorageManager:deleteAllStorages()
end)

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    Wait(3000)
    -- After a restart the Lua state is fresh so PlayerData.loaded is nil.
    -- Set it here to handle players already in-game when the resource restarts.
    PlayerData.loaded = true
    handlePlayerLoaded()
end)

AddStateBagChangeHandler("", "global", function(bagName, key, value, reserved, replicated)
    if not PlayerData.loaded then return end
    local id = tonumber(key:match("storage%.([%w_]+)"))
    if id then
        if value == nil then
            StorageManager:deleteStorageById(id)
        else
            local storage = StorageManager:getStorageById(id)
            if storage then
                storage:updateData(value)
            else
                StorageManager:createStorage(id, value)
            end
        end
    end
end)

local function buildStorageMetadata(storage, expirationData, ownerName)
    local metadata = {}

    if storage:isRented() then
        if not storage:isForever() then
            metadata[#metadata + 1] = {
                label = locale("rented"),
                value = storage:isOwned() and "\226\156\133" or "\226\157\140"
            }

            local expiringDate = "N/A"
            if expirationData then
                if expirationData.expiring_date then
                    expiringDate = expirationData.expiring_date
                end
            else
                if storage.expiring_date then
                    expiringDate = storage.expiring_date
                end
            end

            metadata[#metadata + 1] = {
                label = locale("rented_until"),
                value = Utils.FormatDateTime(expiringDate)
            }

            metadata[#metadata + 1] = {
                label = locale("expired"),
                value = storage:isExpired() and "\226\156\133" or "\226\157\140"
            }

            metadata[#metadata + 1] = {
                label = locale("rental_days"),
                value = storage.rental_days
            }
        end
    else
        if storage:isForever() then
            metadata[#metadata + 1] = {
                label = locale("bought"),
                value = storage:isForever() and "\226\156\133" or "\226\157\140"
            }
        end
    end

    if storage:isOwned() then
        metadata[#metadata + 1] = {
            label = locale("renter"),
            value = ownerName or storage.owner
        }
    end

    metadata[#metadata + 1] = {
        label = locale("price"),
        value = storage.price
    }

    return metadata
end

function manageStorages()
    local authorized = lib.callback.await("nolag_storageunits:server:isAuthorizedToManage", false)
    if not authorized then
        Utils.Notify("not_authorized", "error", 5000)
        return
    end
    if not StorageManager:hasLoaded() then
        Utils.Notify("storages_not_loaded", "error", 5000)
        return
    end

    local storages = StorageManager:getStorages()
    local ownedStorageIds = {}

    for id, storage in pairs(storages) do
        if storage:isRented() and not storage:isForever() then
            ownedStorageIds[#ownedStorageIds + 1] = storage.id
        end
    end

    local expirationData = {}
    if #ownedStorageIds > 0 then
        expirationData = lib.callback.await("nolag_storageunits:server:getStoragesExpirationData", false, ownedStorageIds)
    end

    -- Pre-fetch owner names so we don't await inside the loop
    local ownerNames = {}
    for id, storage in pairs(storages) do
        if storage:isOwned() and storage.owner then
            ownerNames[storage.owner] = lib.callback.await("nolag_storageunits:server:getPlayerNames", false, storage.owner)
        end
    end

    local options = {}
    for id, storage in pairs(storages) do
        local metadata = buildStorageMetadata(storage, expirationData[storage.id], ownerNames[storage.owner])
        options[#options + 1] = Utils.CreateMenuOption(storage.label, nil, "fas fa-box", function()
            storage:adminManage()
        end, metadata, true)
    end

    options[#options + 1] = Utils.CreateMenuOption("locale_create_storage", nil, "fas fa-plus", function()
        exports.nolag_storageunits:createStorage()
    end)

    lib.registerContext({
        id = "storages_manage",
        title = locale("storages"),
        options = options
    })
    lib.showContext("storages_manage")
end

exports("manageStorages", manageStorages)

-- Single global thread that draws a marker at every storage within range
CreateThread(function()
    local cfg = clientConfig.markerConfig
    if not cfg or not cfg.enabled then return end
    while true do
        if PlayerData.loaded then
            local storages = StorageManager:getStorages()
            local playerCoords = GetEntityCoords(cache.ped)
            local anyNearby = false
            for _, storage in pairs(storages) do
                if storage and storage.coords then
                    local dist = #(playerCoords - vector3(storage.coords.x, storage.coords.y, storage.coords.z))
                    if dist <= cfg.renderDistance then
                        anyNearby = true
                        DrawMarker(
                            cfg.type,
                            storage.coords.x, storage.coords.y, storage.coords.z,
                            0.0, 0.0, 0.0,
                            0.0, 0.0, 0.0,
                            cfg.sizeX, cfg.sizeY, cfg.sizeZ,
                            cfg.r, cfg.g, cfg.b, cfg.a,
                            false, true, 2, nil, nil, false
                        )
                    end
                end
            end
            Wait(anyNearby and 0 or 300)
        else
            Wait(1000)
        end
    end
end)
