local sharedConfig = require 'config.shared'
if sharedConfig.banking ~= 'okokBanking' then return end

---@param society string The society that the money will be added to
---@param price number The amount of money that will be added
---@param playerIdentifier string The identifier of the player that executes the action
function AddMoneyToSociety(society, price, playerIdentifier)
    return exports.okokBanking:AddMoney(society, price, 'Test') -- if this export doesn't exist, please look at the documentation
end
