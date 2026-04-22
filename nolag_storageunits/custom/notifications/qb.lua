local sharedConfig = require 'config.shared'
if sharedConfig.notifications ~= 'qb' then return end

function Notify(data)
    if IsDuplicityVersion() then
        TriggerClientEvent('QBCore:Notify', data.source, data.message, data.type, data.time, 'Storages')
    else
        TriggerEvent('QBCore:Notify', data.message, data.type, data.time, 'Storages')
    end
end
