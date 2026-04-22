if GetResourceState('es_extended') ~= 'started' then return end

local sharedConfig = lib.load('config.shared')
local ESX = exports['es_extended']:getSharedObject()

ServerFramework = {}

function ServerFramework.getPlayerIdentifier(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return nil end
    return xPlayer.identifier
end

function ServerFramework.getPlayerName(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return 'Unknown' end
    return xPlayer.getName()
end

function ServerFramework.getPlayerNameByIdentifier(identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if not xPlayer then return identifier end
    return xPlayer.getName()
end

function ServerFramework.getPlayerSourceByIdentifier(identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if not xPlayer then return nil end
    return xPlayer.source
end

function ServerFramework.isPlayerAuthorizedToManage(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    for jobName, grade in pairs(sharedConfig.realEstateJobs) do
        if xPlayer.job.name == jobName and xPlayer.job.grade >= grade then
            return true
        end
    end
    return false
end

function ServerFramework.isPlayerAuthorizedToRaid(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    for jobName, grade in pairs(sharedConfig.policeRaid.jobs) do
        if xPlayer.job.name == jobName and xPlayer.job.grade >= grade then
            return true
        end
    end
    return false
end

function ServerFramework.removeBankMoney(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    local bankMoney = xPlayer.getAccount('bank').money
    if bankMoney < amount then return false end
    xPlayer.removeAccountMoney('bank', amount)
    return true
end
