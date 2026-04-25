MySQL.ready(function()
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `nolag_storages` (
            `id`                   INT            NOT NULL AUTO_INCREMENT,
            `coords`               TEXT           NOT NULL,
            `owner`                VARCHAR(255)   NULL DEFAULT NULL,
            `label`                VARCHAR(255)   NOT NULL DEFAULT 'Storage',
            `password`             VARCHAR(255)   NULL DEFAULT NULL,
            `first_rented_date`    BIGINT         NULL DEFAULT NULL,
            `expiring_date`        BIGINT         NULL DEFAULT NULL,
            `expired`              TINYINT(1)     NOT NULL DEFAULT 0,
            `failed_payments`      INT            NOT NULL DEFAULT 0,
            `next_payment_attempt` BIGINT         NULL DEFAULT NULL,
            `rental_days`          INT            NOT NULL DEFAULT 7,
            `price`                INT            NOT NULL DEFAULT 0,
            `blip`                 TINYINT(1)     NOT NULL DEFAULT 0,
            `inventory`            TEXT           NULL DEFAULT NULL,
            `forever`              TINYINT(1)     NOT NULL DEFAULT 0,
            PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]])
end)

function DB_GetAllStorages()
    local rows = MySQL.query.await('SELECT * FROM nolag_storages')
    local result = {}
    for _, row in ipairs(rows) do
        local coords = json.decode(row.coords)
        local inventory = row.inventory and json.decode(row.inventory) or nil
        result[row.id] = {
            id           = row.id,
            coords       = coords,
            owner        = row.owner,
            label        = row.label,
            first_rented_date    = row.first_rented_date,
            expiring_date        = row.expiring_date,
            expired              = row.expired == true or row.expired == 1,
            failed_payments      = row.failed_payments,
            next_payment_attempt = row.next_payment_attempt,
            rental_days  = row.rental_days,
            price        = row.price,
            blip         = row.blip == true or row.blip == 1,
            inventory    = inventory,
            forever      = row.forever == true or row.forever == 1,
        }
    end
    return result
end

function DB_GetStorageById(id)
    local row = MySQL.single.await('SELECT * FROM nolag_storages WHERE id = ?', { id })
    if not row then return nil end
    local coords = json.decode(row.coords)
    local inventory = row.inventory and json.decode(row.inventory) or nil
    return {
        id           = row.id,
        coords       = coords,
        owner        = row.owner,
        label        = row.label,
        password     = row.password,
        first_rented_date    = row.first_rented_date,
        expiring_date        = row.expiring_date,
        expired              = row.expired == true or row.expired == 1,
        failed_payments      = row.failed_payments,
        next_payment_attempt = row.next_payment_attempt,
        rental_days  = row.rental_days,
        price        = row.price,
        blip         = row.blip == true or row.blip == 1,
        inventory    = inventory,
        forever      = row.forever == true or row.forever == 1,
    }
end

function DB_CreateStorage(data)
    local coordsJson = json.encode(data.coords)
    local inventoryJson = data.inventory and json.encode(data.inventory) or nil
    local id = MySQL.insert.await([[
        INSERT INTO nolag_storages (coords, label, price, blip, rental_days, inventory, forever)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    ]], {
        coordsJson,
        data.label,
        data.price or 0,
        data.blip and 1 or 0,
        data.rental_days or 7,
        inventoryJson,
        data.forever and 1 or 0,
    })
    return id
end

function DB_RentStorage(id, owner, password, rentalDays)
    local now = os.time()
    local expiring = now + (rentalDays * 86400)
    MySQL.update.await([[
        UPDATE nolag_storages
        SET owner = ?, password = ?, first_rented_date = ?, expiring_date = ?, expired = 0, failed_payments = 0
        WHERE id = ?
    ]], { owner, password, now, expiring, id })
    return now, expiring
end

function DB_BuyStorage(id, owner, password)
    MySQL.update.await([[
        UPDATE nolag_storages
        SET owner = ?, password = ?, first_rented_date = ?, forever = 1, expired = 0
        WHERE id = ?
    ]], { owner, password, os.time(), id })
end

function DB_ValidatePassword(id, password)
    local row = MySQL.single.await('SELECT password FROM nolag_storages WHERE id = ?', { id })
    if not row then return false end
    return row.password == password
end

function DB_ChangePassword(id, newPassword)
    MySQL.update.await('UPDATE nolag_storages SET password = ? WHERE id = ?', { newPassword, id })
end

function DB_CancelSubscription(id)
    MySQL.update.await([[
        UPDATE nolag_storages
        SET owner = NULL, password = NULL, first_rented_date = NULL, expiring_date = NULL,
            expired = 0, failed_payments = 0, next_payment_attempt = NULL
        WHERE id = ?
    ]], { id })
end

function DB_TransferStorage(id, newOwner)
    MySQL.update.await('UPDATE nolag_storages SET owner = ? WHERE id = ?', { newOwner, id })
end

function DB_RemoveRenter(id)
    MySQL.update.await([[
        UPDATE nolag_storages
        SET owner = NULL, password = NULL, first_rented_date = NULL, expiring_date = NULL,
            expired = 0, failed_payments = 0, next_payment_attempt = NULL
        WHERE id = ?
    ]], { id })
end

function DB_ToggleLock(id, locked)
    MySQL.update.await('UPDATE nolag_storages SET expired = ? WHERE id = ?', { locked and 1 or 0, id })
end

function DB_EditStorage(id, data)
    local inventoryJson = data.inventory and json.encode(data.inventory) or nil
    MySQL.update.await([[
        UPDATE nolag_storages
        SET label = ?, price = ?, blip = ?, rental_days = ?, inventory = ?
        WHERE id = ?
    ]], {
        data.label,
        data.price,
        data.blip and 1 or 0,
        data.rental_days,
        inventoryJson,
        id
    })
end

function DB_DeleteStorage(id)
    MySQL.update.await('DELETE FROM nolag_storages WHERE id = ?', { id })
end

function DB_GetStoragesExpirationData(ids)
    if not ids or #ids == 0 then return {} end
    local placeholders = string.rep('?,', #ids):sub(1, -2)
    local rows = MySQL.query.await('SELECT id, expiring_date, failed_payments FROM nolag_storages WHERE id IN (' .. placeholders .. ')', ids)
    local result = {}
    for _, row in ipairs(rows) do
        result[row.id] = {
            expiring_date   = row.expiring_date,
            failed_payments = row.failed_payments
        }
    end
    return result
end

function DB_GetExpiredStorages()
    local now = os.time()
    return MySQL.query.await([[
        SELECT * FROM nolag_storages
        WHERE owner IS NOT NULL
          AND forever = 0
          AND expired = 0
          AND expiring_date IS NOT NULL
          AND expiring_date <= ?
    ]], { now })
end

function DB_SetExpired(id, failedPayments, nextAttempt)
    MySQL.update.await([[
        UPDATE nolag_storages
        SET expired = 1, failed_payments = ?, next_payment_attempt = ?
        WHERE id = ?
    ]], { failedPayments, nextAttempt, id })
end

function DB_SetPaymentSuccess(id, newExpiringDate)
    MySQL.update.await([[
        UPDATE nolag_storages
        SET expiring_date = ?, expired = 0, failed_payments = 0, next_payment_attempt = NULL
        WHERE id = ?
    ]], { newExpiringDate, id })
end
