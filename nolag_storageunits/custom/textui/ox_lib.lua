local sharedConfig = require 'config.shared'
if sharedConfig.textui ~= 'ox_lib' then return end

function ShowTextUI(text)
    lib.showTextUI(text)
end

function HideTextUI()
    lib.hideTextUI()
end
