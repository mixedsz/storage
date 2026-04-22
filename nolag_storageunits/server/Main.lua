local sharedConfig = lib.load('config.shared')

local storageStateBagKey = "storage.%s"

local function getStorageStateBag(storageId)
    return string.format(storageStateBagKey, storageId)
end

local function broadcastStorageUpdate(storageId, data)
    local bagKey = getStorageStateBag(storageId)
    GlobalState[bagKey] = data
end

local function broadcastStorageDelete(storageId)
    local bagKey = getStorageStateBag(storageId)
    GlobalState[bagKey] = nil
end

local function buildStorageStateData(storage)
    return {
        id             = storage.id,
        coords         = storage.coords,
        owner          = storage.owner,
        label          = storage.label,
        first_rented_date    = storage.first_rented_date,
        expiring_date        = storage.expiring_date,
        expired              = storage.expired,
        failed_payments      = storage.failed_payments,
        next_payment_attempt = storage.next_payment_attempt,
        rental_days    = storage.rental_days,
        price          = storage.price,
        blip           = storage.blip,
        inventory      = storage.inventory,
        forever        = storage.forever,
    }
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    Wait(500)
    local storages = DB_GetAllStorages()
    for id, storage in pairs(storages) do
        broadcastStorageUpdate(id, buildStorageStateData(storage))
        if storage.inventory then
            RegisterStash(
                "Storage_" .. id,
                storage.label,
                storage.inventory.slots or sharedConfig.defaultSlots,
                storage.inventory.weight or sharedConfig.defaultWeight,
                storage.coords
            )
        end
    end
end)

lib.callback.register('nolag_storageunits:server:getStorages', function(source)
    local storages = DB_GetAllStorages()
    local result = {}
    for id, storage in pairs(storages) do
        result[id] = buildStorageStateData(storage)
    end
    return result
end)

lib.callback.register('nolag_storageunits:server:createStorage', function(source, data)
    if not ServerFramework.isPlayerAuthorizedToManage(source) then return false end

    if not data or not data.coords or not data.label then return false end

    local id = DB_CreateStorage(data)
    if not id then return false end

    local storage = DB_GetStorageById(id)
    if not storage then return false end

    if storage.inventory then
        RegisterStash(
            "Storage_" .. id,
            storage.label,
            storage.inventory.slots or sharedConfig.defaultSlots,
            storage.inventory.weight or sharedConfig.defaultWeight,
            storage.coords
        )
    end

    broadcastStorageUpdate(id, buildStorageStateData(storage))

    local identifier = ServerFramework.getPlayerIdentifier(source)
    local name = ServerFramework.getPlayerName(source)
    SendLog(
        locale('logs_created_storage'),
        string.format(locale('logs_created_storage'), name, id, storage.label, storage.price),
        'info'
    )

    return true
end)

lib.callback.register('nolag_storageunits:server:getPlayerNames', function(source, targetSource)
    if not targetSource then return 'Unknown' end
    local targetNum = tonumber(targetSource)
    if targetNum then
        return ServerFramework.getPlayerName(targetNum)
    end
    return ServerFramework.getPlayerNameByIdentifier(tostring(targetSource))
end)

lib.callback.register('nolag_storageunits:server:getStoragesExpirationData', function(source, ids)
    if not ids or #ids == 0 then return {} end
    return DB_GetStoragesExpirationData(ids)
end)

lib.callback.register('nolag_storageunits:server:validatePassword', function(source, storageId, password)
    if not storageId or not password then return false end
    return DB_ValidatePassword(tonumber(storageId), tostring(password))
end)

lib.callback.register('nolag_storageunits:server:rentStorage', function(source, storageId, password)
    if not storageId or not password then return false end
    storageId = tonumber(storageId)

    local storage = DB_GetStorageById(storageId)
    if not storage then return false end
    if storage.owner then return false end
    if storage.forever then return false end

    local identifier = ServerFramework.getPlayerIdentifier(source)
    if not identifier then return false end

    local success = ServerFramework.removeBankMoney(source, storage.price)
    if not success then
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'error',
            description = locale('not_enough_money')
        })
        return false
    end

    local now, expiring = DB_RentStorage(storageId, identifier, tostring(password), storage.rental_days)

    local updatedStorage = DB_GetStorageById(storageId)
    if updatedStorage then
        if updatedStorage.inventory then
            RegisterStash(
                "Storage_" .. storageId,
                updatedStorage.label,
                updatedStorage.inventory.slots or sharedConfig.defaultSlots,
                updatedStorage.inventory.weight or sharedConfig.defaultWeight,
                updatedStorage.coords
            )
        end
        broadcastStorageUpdate(storageId, buildStorageStateData(updatedStorage))
    end

    local name = ServerFramework.getPlayerName(source)
    SendLog(
        'Storage Rented',
        string.format(locale('logs_rented_storage'), name, storageId, storage.label, storage.rental_days, storage.price),
        'success'
    )

    return true
end)

lib.callback.register('nolag_storageunits:server:buyStorage', function(source, storageId, password)
    if not storageId or not password then return false end
    storageId = tonumber(storageId)

    local storage = DB_GetStorageById(storageId)
    if not storage then return false end
    if storage.owner then return false end
    if not storage.forever then return false end

    local identifier = ServerFramework.getPlayerIdentifier(source)
    if not identifier then return false end

    local success = ServerFramework.removeBankMoney(source, storage.price)
    if not success then
        TriggerClientEvent('ox_lib:notify', source, {
            type = 'error',
            description = locale('not_enough_money')
        })
        return false
    end

    DB_BuyStorage(storageId, identifier, tostring(password))

    local updatedStorage = DB_GetStorageById(storageId)
    if updatedStorage then
        if updatedStorage.inventory then
            RegisterStash(
                "Storage_" .. storageId,
                updatedStorage.label,
                updatedStorage.inventory.slots or sharedConfig.defaultSlots,
                updatedStorage.inventory.weight or sharedConfig.defaultWeight,
                updatedStorage.coords
            )
        end
        broadcastStorageUpdate(storageId, buildStorageStateData(updatedStorage))
    end

    local name = ServerFramework.getPlayerName(source)
    SendLog(
        'Storage Bought',
        string.format(locale('logs_bought_storage'), name, storageId, storage.label, storage.price),
        'success'
    )

    return true
end)

lib.callback.register('nolag_storageunits:server:validateAndChangePassword', function(source, storageId, oldPassword, newPassword)
    if not storageId or not oldPassword or not newPassword then return false end
    storageId = tonumber(storageId)

    local valid = DB_ValidatePassword(storageId, tostring(oldPassword))
    if not valid then return false end

    local identifier = ServerFramework.getPlayerIdentifier(source)
    local storage = DB_GetStorageById(storageId)
    if storage and storage.owner ~= identifier then return false end

    DB_ChangePassword(storageId, tostring(newPassword))

    local name = ServerFramework.getPlayerName(source)
    SendLog(
        'Password Changed',
        string.format(locale('logs_changed_password'), name, storageId, storage and storage.label or ''),
        'info'
    )

    return true
end)

lib.callback.register('nolag_storageunits:server:cancelSubscription', function(source, storageId)
    if not storageId then return false end
    storageId = tonumber(storageId)

    local identifier = ServerFramework.getPlayerIdentifier(source)
    local storage = DB_GetStorageById(storageId)
    if not storage then return false end
    if storage.owner ~= identifier then return false end

    DeleteInventory(storageId)
    DB_CancelSubscription(storageId)

    local updatedStorage = DB_GetStorageById(storageId)
    if updatedStorage then
        broadcastStorageUpdate(storageId, buildStorageStateData(updatedStorage))
    end

    local name = ServerFramework.getPlayerName(source)
    SendLog(
        'Subscription Canceled',
        string.format(locale('logs_canceled_subscription'), name, storageId, storage.label),
        'warning'
    )

    return true
end)

lib.callback.register('nolag_storageunits:server:manualPaymentRetry', function(source, storageId)
    if not storageId then return false, locale('something_went_wrong') end
    storageId = tonumber(storageId)

    local identifier = ServerFramework.getPlayerIdentifier(source)
    local storage = DB_GetStorageById(storageId)
    if not storage then return false, locale('something_went_wrong') end
    if storage.owner ~= identifier then return false, locale('not_authorized') end
    if not storage.expired then return false, locale('something_went_wrong') end

    local success = ServerFramework.removeBankMoney(source, storage.price)
    if not success then
        return false, locale('not_enough_money')
    end

    local newExpiring = os.time() + (storage.rental_days * 86400)
    DB_SetPaymentSuccess(storageId, newExpiring)

    local updatedStorage = DB_GetStorageById(storageId)
    if updatedStorage then
        broadcastStorageUpdate(storageId, buildStorageStateData(updatedStorage))
    end

    local name = ServerFramework.getPlayerName(source)
    SendLog(
        'Manual Payment Retry',
        string.format(locale('logs_manual_payment_retry'), name, storageId, storage.label, storage.price, 'success'),
        'success'
    )

    return true, locale('storage_unlocked')
end)

lib.callback.register('nolag_storageunits:server:validateAndTransferStorage', function(source, storageId, password, targetSource)
    if not storageId or not password or not targetSource then return false, nil end
    storageId = tonumber(storageId)
    targetSource = tonumber(targetSource)

    local identifier = ServerFramework.getPlayerIdentifier(source)
    local storage = DB_GetStorageById(storageId)
    if not storage then return false, nil end
    if storage.owner ~= identifier then return false, nil end

    local valid = DB_ValidatePassword(storageId, tostring(password))
    if not valid then return false, nil end

    local targetIdentifier = ServerFramework.getPlayerIdentifier(targetSource)
    if not targetIdentifier then return false, nil end

    local targetName = ServerFramework.getPlayerName(targetSource)
    local senderName = ServerFramework.getPlayerName(source)

    local confirmed = lib.callback.await('nolag_storageunits:client:transferStorage', targetSource, senderName)
    if not confirmed then
        return false, nil
    end

    DB_TransferStorage(storageId, targetIdentifier)

    local updatedStorage = DB_GetStorageById(storageId)
    if updatedStorage then
        broadcastStorageUpdate(storageId, buildStorageStateData(updatedStorage))
    end

    SendLog(
        'Storage Transferred',
        string.format(locale('logs_transferred_storage'), senderName, targetName, storageId, storage.label),
        'info'
    )

    return true, targetIdentifier
end)

lib.callback.register('nolag_storageunits:server:forceOpenInventory', function(source, storageId)
    if not storageId then return false end
    if not ServerFramework.isPlayerAuthorizedToManage(source) then return false end
    storageId = tonumber(storageId)

    ForceOpenInventory(source, storageId)
    return true
end)

lib.callback.register('nolag_storageunits:server:removeRenter', function(source, storageId)
    if not storageId then return false end
    if not ServerFramework.isPlayerAuthorizedToManage(source) then return false end
    storageId = tonumber(storageId)

    local storage = DB_GetStorageById(storageId)
    if not storage then return false end

    DeleteInventory(storageId)
    DB_RemoveRenter(storageId)

    local updatedStorage = DB_GetStorageById(storageId)
    if updatedStorage then
        broadcastStorageUpdate(storageId, buildStorageStateData(updatedStorage))
    end

    return true
end)

lib.callback.register('nolag_storageunits:server:toggleLock', function(source, storageId, locked)
    if not storageId then return false end
    if not ServerFramework.isPlayerAuthorizedToManage(source) then return false end
    storageId = tonumber(storageId)

    DB_ToggleLock(storageId, locked)

    local updatedStorage = DB_GetStorageById(storageId)
    if updatedStorage then
        broadcastStorageUpdate(storageId, buildStorageStateData(updatedStorage))
    end

    return true
end)

lib.callback.register('nolag_storageunits:server:editStorage', function(source, storageId, data)
    if not storageId or not data then return false end
    if not ServerFramework.isPlayerAuthorizedToManage(source) then return false end
    storageId = tonumber(storageId)

    DB_EditStorage(storageId, data)

    local updatedStorage = DB_GetStorageById(storageId)
    if updatedStorage then
        if updatedStorage.inventory then
            RegisterStash(
                "Storage_" .. storageId,
                updatedStorage.label,
                updatedStorage.inventory.slots or sharedConfig.defaultSlots,
                updatedStorage.inventory.weight or sharedConfig.defaultWeight,
                updatedStorage.coords
            )
        end
        broadcastStorageUpdate(storageId, buildStorageStateData(updatedStorage))
    end

    local name = ServerFramework.getPlayerName(source)
    SendLog(
        'Storage Edited',
        string.format(locale('logs_created_storage'), name, storageId, data.label or '', data.price or ''),
        'info'
    )

    return true
end)

lib.callback.register('nolag_storageunits:server:raidStorage', function(source, storageId)
    if not storageId then return false end
    if not ServerFramework.isPlayerAuthorizedToRaid(source) then return false end
    storageId = tonumber(storageId)

    local storage = DB_GetStorageById(storageId)
    if not storage then return false end
    if not storage.owner then return false end
    if storage.expired then return false end

    local name = ServerFramework.getPlayerName(source)
    SendLog(
        'Storage Raided',
        string.format(locale('logs_raided_storage'), name, storageId, storage.label),
        'warning'
    )

    return true
end)

lib.callback.register('nolag_storageunits:server:deleteStorage', function(source, storageId)
    if not storageId then return false end
    if not ServerFramework.isPlayerAuthorizedToManage(source) then return false end
    storageId = tonumber(storageId)

    local storage = DB_GetStorageById(storageId)
    if not storage then return false end

    DeleteInventory(storageId)
    DB_DeleteStorage(storageId)
    broadcastStorageDelete(storageId)

    local name = ServerFramework.getPlayerName(source)
    SendLog(
        'Storage Deleted',
        string.format(locale('logs_deleted_storage'), name, storageId, storage.label),
        'warning'
    )

    return true
end)
