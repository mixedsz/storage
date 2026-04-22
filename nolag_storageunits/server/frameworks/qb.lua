if GetResourceState('qbx_core') == 'started' or GetResourceState('qb-core') ~= 'started' then return end

local sharedConfig = lib.load('config.shared')
local QBCore = exports['qb-core']:GetCoreObject()

ServerFramework = {}

function ServerFramework.getPlayerIdentifier(source)
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return nil end
    return player.PlayerData.citizenid
end

function ServerFramework.getPlayerName(source)
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return 'Unknown' end
    return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
end

function ServerFramework.getPlayerNameByIdentifier(identifier)
    local players = QBCore.Functions.GetQBPlayers()
    for _, player in pairs(players) do
        if player.PlayerData.citizenid == identifier then
            return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
        end
    end
    return identifier
end

function ServerFramework.getPlayerSourceByIdentifier(identifier)
    local players = QBCore.Functions.GetQBPlayers()
    for _, player in pairs(players) do
        if player.PlayerData.citizenid == identifier then
            return player.PlayerData.source
        end
    end
    return nil
end

function ServerFramework.isPlayerAuthorizedToManage(source)
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return false end
    for jobName, grade in pairs(sharedConfig.realEstateJobs) do
        if player.PlayerData.job.name == jobName and player.PlayerData.job.grade.level >= grade then
            return true
        end
    end
    return false
end

function ServerFramework.isPlayerAuthorizedToRaid(source)
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return false end
    for jobName, grade in pairs(sharedConfig.policeRaid.jobs) do
        if player.PlayerData.job.name == jobName and player.PlayerData.job.grade.level >= grade then
            return true
        end
    end
    return false
end

function ServerFramework.removeBankMoney(source, amount)
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return false end
    return player.Functions.RemoveMoney('bank', amount, 'storage-payment')
end
