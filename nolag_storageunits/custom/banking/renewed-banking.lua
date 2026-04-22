local sharedConfig = require 'config.shared'
if (sharedConfig.banking ~= 'default' or GetResourceState('qbx_core') ~= 'started') and sharedConfig.banking ~= 'Renewed-Banking' then return end


---@param society string The society that the money will be added to
---@param price number The amount of money that will be added
---@param playerIdentifier string The identifier of the player that executes the action
function AddMoneyToSociety(society, price, playerIdentifier)
    return exports['Renewed-Banking']:addAccountMoney(society, price)
end
