local sharedConfig = require 'config.shared'
if sharedConfig.textui ~= 'okokTextUI' then return end

function ShowTextUI(text)
    exports['okokTextUI']:Open(text, 'lightblue', 'left')
end

function HideTextUI()
    exports['okokTextUI']:Close()
end
