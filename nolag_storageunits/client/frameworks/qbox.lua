if GetResourceState('qbx_core') ~= 'started' then
    return
end

local sharedConfig = require 'config.shared'

lib.print.debug('Loading QBox Framework')

OnPlayerLoadedEvent = "QBCore:Client:OnPlayerLoaded"
OnPlayerUnloadedEvent = "qbx_core:client:playerLoggedOut"
OnJobUpdateEvent = "QBCore:Client:OnJobUpdate"

Framework = {}
local QBPlayerData = exports.qbx_core:GetPlayerData() or {}

PlayerData = {
    identifier = QBPlayerData.citizenid,
    job = QBPlayerData.job,
}

Framework = {
    isPlayerAuthorized = function()
        for jobName, grade in pairs(sharedConfig.realEstateJobs) do
            if jobName == PlayerData.job.name and PlayerData.job.grade.level >= grade then
                return true
            end
        end
        return false
    end,
    isPlayerAuthorizedToRaid = function()
        for jobName, grade in pairs(sharedConfig.policeRaid.jobs) do
            if jobName == PlayerData.job.name and PlayerData.job.grade.level >= grade then
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

RegisterNetEvent(OnPlayerLoadedEvent, function()
    QBPlayerData = exports.qbx_core:GetPlayerData()
    PlayerData.identifier = QBPlayerData.citizenid
    PlayerData.job = QBPlayerData.job
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
