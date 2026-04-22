local sharedConfig = require 'config.shared'
if sharedConfig.notifications ~= 'ox_lib' then return end

function Notify(data)
    if IsDuplicityVersion() then
        TriggerClientEvent('ox_lib:notify', data.source,
            {
                type = data.type,
                description = data.message,
                position = 'top-right',
                icon = 'box',
                duration = data.time,
            }
        )
    else
        lib.notify({
            title = 'Storages',
            description = data.message,
            position = 'top-right',
            icon = 'box',
            duration = data.time,
            type = data.type,
        })
    end
end
