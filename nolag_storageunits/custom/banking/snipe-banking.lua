local sharedConfig = require 'config.shared'
if sharedConfig.banking ~= 'snipe-banking' then return end


---@param society string The society that the money will be added to
---@param price number The amount of money that will be added
---@param playerIdentifier string The identifier of the player that executes the action
function AddMoneyToSociety(society, price, playerIdentifier)
    return exports['snipe-banking']:AddMoneyToAccount(society, price)
end
