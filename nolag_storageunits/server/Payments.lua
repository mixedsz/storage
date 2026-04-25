local sharedConfig = lib.load('config.shared')

local function broadcastStorageUpdate(storageId, data)
    GlobalState[string.format("storage.%s", storageId)] = data
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

local function processExpiredStorages()
    local rows = DB_GetExpiredStorages()
    if not rows or #rows == 0 then return end

    for _, row in ipairs(rows) do
        local storageId = row.id
        local coords = json.decode(row.coords)
        local inventory = row.inventory and json.decode(row.inventory) or nil

        local storage = {
            id             = row.id,
            coords         = coords,
            owner          = row.owner,
            label          = row.label,
            first_rented_date    = row.first_rented_date,
            expiring_date        = row.expiring_date,
            expired              = row.expired == true or row.expired == 1,
            failed_payments      = row.failed_payments,
            next_payment_attempt = row.next_payment_attempt,
            rental_days    = row.rental_days,
            price          = row.price,
            blip           = row.blip == true or row.blip == 1,
            inventory      = inventory,
            forever        = row.forever == true or row.forever == 1,
        }

        local ownerSource = ServerFramework.getPlayerSourceByIdentifier(storage.owner)
        local paymentSuccess = false

        if ownerSource then
            paymentSuccess = ServerFramework.removeBankMoney(ownerSource, storage.price)
        elseif ServerFramework.removeOfflineBankMoney then
            -- Owner is offline — charge their bank account directly via DB
            paymentSuccess = ServerFramework.removeOfflineBankMoney(storage.owner, storage.price)
        end

        if paymentSuccess then
            local newExpiring = os.time() + (storage.rental_days * 86400)
            DB_SetPaymentSuccess(storageId, newExpiring)

            local updatedStorage = DB_GetStorageById(storageId)
            if updatedStorage then
                broadcastStorageUpdate(storageId, buildStorageStateData(updatedStorage))
            end

            local ownerName = ServerFramework.getPlayerName(ownerSource)
            SendLog(
                'Automatic Payment',
                string.format(locale('logs_handled_payment'), ownerName, storageId, 'bank', storage.price),
                'success'
            )
        else
            local failedPayments = (storage.failed_payments or 0) + 1
            local nextAttempt = os.time() + 3600

            DB_SetExpired(storageId, failedPayments, nextAttempt)

            local updatedStorage = DB_GetStorageById(storageId)
            if updatedStorage then
                broadcastStorageUpdate(storageId, buildStorageStateData(updatedStorage))
            end

            local ownerName = storage.owner
            if ownerSource then
                ownerName = ServerFramework.getPlayerName(ownerSource)
            end

            SendLog(
                'Payment Failed',
                string.format(locale('logs_failed_payment'), ownerName, storageId, 'bank', storage.price),
                'error'
            )

            SendLog(
                'Storage Expired',
                string.format(locale('logs_expired_storage'), storageId, storage.label),
                'warning'
            )
        end
    end
end

local checkInterval = (sharedConfig.paymentCheckInterval or 60) * 1000

CreateThread(function()
    while true do
        Wait(checkInterval)
        processExpiredStorages()
    end
end)
