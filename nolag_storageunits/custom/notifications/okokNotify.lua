local sharedConfig = require 'config.shared'
if sharedConfig.notifications ~= 'okokNotify' then return end

function Notify(data)
    if IsDuplicityVersion() then
        TriggerClientEvent('okokNotify:Alert', data.source, 'Storages', data.message, data.time, data.type, true)
    else
        exports['okokNotify']:Alert('Storages', data.message, data.time, data.type, true)
    end
end
