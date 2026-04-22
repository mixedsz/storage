local sharedConfig = require 'config.shared'
if sharedConfig.textui ~= 'qb-DrawText' then return end

function ShowTextUI(text)
    exports["qb-core"]:DrawText(text)
end

function HideTextUI()
    exports["qb-core"]:HideText()
end
