local sharedConfig = require 'config.shared'
if sharedConfig.textui ~= 'ps-ui' then return end

function ShowTextUI(text)
    exports['ps-ui']:DisplayText(text, "primary")
end

function HideTextUI()
    exports['ps-ui']:HideText()
end
