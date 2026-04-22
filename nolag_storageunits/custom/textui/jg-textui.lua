local sharedConfig = require 'config.shared'
if sharedConfig.textui ~= 'jg-textui' then return end

function ShowTextUI(text)
    exports['jg-textui']:DrawText(text)
end

function HideTextUI()
    exports['jg-textui']:HideText()
end
