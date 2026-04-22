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
    job = ESXPlayerData.job,
}

Framework = {
    isPlayerAuthorized = function()
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
    PlayerData.job = ESXPlayerData.job
end)

RegisterNetEvent(OnPlayerUnloadedEvent, function()
    PlayerData.identifier = nil
    PlayerData.job = nil
end)

RegisterNetEvent(OnJobUpdateEvent, function(PlayerJob)
    PlayerData.job = PlayerJob
end)

RegisterCommand('createstorage', function(source, args, raw)
    if not Framework.isPlayerAuthorizedToManageStorages() then
        return
    end
    exports.nolag_storageunits:createStorage()
end, false)

RegisterCommand('storages', function(source, args, raw)
    if not Framework.isPlayerAuthorizedToManageStorages() then
        return
    end
    exports.nolag_storageunits:manageStorages()
end)
