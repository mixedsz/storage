local sharedConfig = lib.load('config.shared')
if sharedConfig.logs ~= 'discord' then return end

local webhookUrl = '' -- Paste your Discord webhook URL here

local colors = {
    info    = 3447003,
    success = 3066993,
    error   = 15158332,
    warning = 16776960,
}

function SendLog(title, description, color)
    if webhookUrl == '' then return end
    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({
        username = 'NoLag Storage Units',
        avatar_url = '',
        embeds = {
            {
                title = title,
                description = description,
                color = colors[color] or colors.info,
                footer = { text = os.date('%Y-%m-%d %H:%M:%S') }
            }
        }
    }), { ['Content-Type'] = 'application/json' })
end
