if GetResourceState('es_extended') ~= 'started' then
    return
end

local sharedConfig = require 'config.shared'

local esx_name = "es_extended"
OnPlayerLoadedEvent = "esx:playerLoaded"
OnPlayerUnloadedEvent = "esx:onPlayerLogout"
OnJobUpdateEvent = "esx:setJob"

Framework = {}
local ESX = exports[esx_name]:getSharedObject()
local ESXPlayerData = ESX.GetPlayerData()

PlayerData = {
    identifier = ESXPlayerData.identifier,
    job = ESXPlayerData.job or { name = 'unemployed', grade = 0 },
    group = ESXPlayerData.group or 'user',
}

local function isAdminGroup()
    local group = PlayerData.group or 'user'
    return group == 'admin' or group == 'superadmin' or group == 'mod'
end

Framework = {
    isPlayerAuthorized = function()
        if isAdminGroup() then return true end
        for jobName, grade in pairs(sharedConfig.realEstateJobs) do
            if jobName == PlayerData.job.name and PlayerData.job.grade >= grade then
                return true
            end
        end
        return false
    end,
    isPlayerAuthorizedToRaid = function()
        for jobName, grade in pairs(sharedConfig.policeRaid.jobs) do
            if jobName == PlayerData.job.name and PlayerData.job.grade >= grade then
                return true
            end
        end
        return false
    end,
    isPlayerAuthorizedToDeleteStorage = function()
        return Framework.isPlayerAuthorized()
    end,
    isPlayerAuthorizedToLockdown = function()
        return Framework.isPlayerAuthorizedToRaid()
    end,
    isPlayerAuthorizedToManageStorages = function()
        return Framework.isPlayerAuthorized()
    end,
}

RegisterNetEvent(OnPlayerLoadedEvent, function(xPlayer)
    ESXPlayerData = xPlayer
    PlayerData.identifier = ESXPlayerData.identifier
    PlayerData.job = ESXPlayerData.job or { name = 'unemployed', grade = 0 }
    PlayerData.group = ESXPlayerData.group or 'user'
end)

RegisterNetEvent(OnPlayerUnloadedEvent, function()
    PlayerData.identifier = nil
    PlayerData.job = { name = 'unemployed', grade = 0 }
    PlayerData.group = 'user'
end)

RegisterNetEvent(OnJobUpdateEvent, function(PlayerJob)
    PlayerData.job = PlayerJob
end)

-- Sync group changes (for when admin status is granted/revoked at runtime)
RegisterNetEvent('nolag_storageunits:client:setGroup', function(group)
    PlayerData.group = group
end)

local function checkAuthorizedToManage(cb)
    -- Ask server for authoritative answer, avoids relying on client-side group/job state alone
    lib.callback('nolag_storageunits:server:isAuthorizedToManage', false, function(authorized)
        cb(authorized)
    end)
end

RegisterCommand('createstorage', function(source, args, raw)
    checkAuthorizedToManage(function(authorized)
        if not authorized then
            lib.notify({ type = 'error', description = locale('not_authorized'), duration = 4000 })
            return
        end
        exports.nolag_storageunits:createStorage()
    end)
end, false)

RegisterCommand('storages', function(source, args, raw)
    checkAuthorizedToManage(function(authorized)
        if not authorized then
            lib.notify({ type = 'error', description = locale('not_authorized'), duration = 4000 })
            return
        end
        exports.nolag_storageunits:manageStorages()
    end)
end, false)
