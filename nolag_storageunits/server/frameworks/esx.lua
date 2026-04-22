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

local adminGroups = (function()
    local t = {}
    for _, g in ipairs(sharedConfig.adminGroups or { 'superadmin', 'admin', 'mod' }) do
        t[g] = true
    end
    return t
end)()

function ServerFramework.isPlayerAuthorizedToManage(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    -- ESX group check (any group listed in config.shared adminGroups)
    if adminGroups[xPlayer.getGroup()] then return true end
    -- ACE permission check
    if IsPlayerAceAllowed(tostring(source), 'nolag_storageunits.manage') then return true end
    -- Job-based check via config
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

-- Sync group to client on player load so client-side admin check stays accurate
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    TriggerClientEvent('nolag_storageunits:client:setGroup', playerId, xPlayer.getGroup())
end)
