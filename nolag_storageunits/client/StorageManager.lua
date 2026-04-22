if not lib then return end

local StorageManagerClass = lib.class("StorageManager")

function StorageManagerClass:constructor()
    self.haveLoadedStorages = false
    self.storages = {}
end

function StorageManagerClass:loadStoragesFromDatabase()
    lib.print.debug("Loading storages from database " .. tostring(self.haveLoadedStorages))
    if self.haveLoadedStorages then return end
    self.haveLoadedStorages = true

    local storages = lib.callback.await("nolag_storageunits:server:getStorages", false)
    for id, data in pairs(storages) do
        self:createStorage(id, data)
    end
end

function StorageManagerClass:deleteAllStorages()
    lib.print.debug("Deleting all storages")
    for id, storage in pairs(self.storages) do
        if storage and storage.id then
            storage:delete()
        end
    end
    self.storages = {}
    self.haveLoadedStorages = false
end

function StorageManagerClass:createStorage(id, data)
    lib.print.debug("Creating property: " .. id)
    if self.storages[id] then
        lib.print.debug("Storage with id: " .. id .. " already exists")
        return self.storages[id]
    end

    local storage = Storage:new(id, data)
    self.storages[id] = storage
    return storage
end

function StorageManagerClass:getStorages()
    return self.storages
end

function StorageManagerClass:hasLoaded()
    return self.haveLoadedStorages
end

function StorageManagerClass:getStorageById(id)
    return self.storages[id]
end

function StorageManagerClass:deleteStorageById(id)
    local storage = self.storages[id]
    storage:delete()
    self.storages[id] = nil
end

StorageManager = StorageManagerClass:new()
