if GetResourceState('qbx_core') ~= 'started' then return end

local sharedConfig = lib.load('config.shared')

ServerFramework = {}

function ServerFramework.getPlayerIdentifier(source)
    local player = exports.qbx_core:GetPlayer(source)
    if not player then return nil end
    return player.PlayerData.citizenid
end

function ServerFramework.getPlayerName(source)
    local player = exports.qbx_core:GetPlayer(source)
    if not player then return 'Unknown' end
    return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
end

function ServerFramework.getPlayerNameByIdentifier(identifier)
    local players = exports.qbx_core:GetQBPlayers()
    for _, player in pairs(players) do
        if player.PlayerData.citizenid == identifier then
            return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
        end
    end
    return identifier
end

function ServerFramework.getPlayerSourceByIdentifier(identifier)
    local players = exports.qbx_core:GetQBPlayers()
    for _, player in pairs(players) do
        if player.PlayerData.citizenid == identifier then
            return player.PlayerData.source
        end
    end
    return nil
end

function ServerFramework.isPlayerAuthorizedToManage(source)
    local player = exports.qbx_core:GetPlayer(source)
    if not player then return false end
    for jobName, grade in pairs(sharedConfig.realEstateJobs) do
        if player.PlayerData.job.name == jobName and player.PlayerData.job.grade.level >= grade then
            return true
        end
    end
    return false
end

function ServerFramework.isPlayerAuthorizedToRaid(source)
    local player = exports.qbx_core:GetPlayer(source)
    if not player then return false end
    for jobName, grade in pairs(sharedConfig.policeRaid.jobs) do
        if player.PlayerData.job.name == jobName and player.PlayerData.job.grade.level >= grade then
            return true
        end
    end
    return false
end

function ServerFramework.removeBankMoney(source, amount)
    local player = exports.qbx_core:GetPlayer(source)
    if not player then return false end
    return player.Functions.RemoveMoney('bank', amount, 'storage-payment')
end
