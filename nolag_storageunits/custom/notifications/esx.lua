local sharedConfig = require 'config.shared'
if sharedConfig.notifications ~= 'esx' then return end

function Notify(data)
    if IsDuplicityVersion() then
        TriggerClientEvent('esx:showNotification', data.source, data.message, data.type, data.time)
    else
        TriggerEvent('esx:showNotification', data.message, data.time, data.type)
    end
end
