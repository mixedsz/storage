local sharedConfig = require 'config.shared'
if sharedConfig.banking ~= 'default' or (GetResourceState('qbx_core') == 'started' or GetResourceState('qb-core') ~= 'started') then return end

local oldQb = false

CreateThread(function()
    oldQb, _ = GetResourceState('qb-management'):find('start') and pcall(function() -- we are checking if you are using an old version of qb-management!
        return MySQL.query.await('SELECT * FROM management_funds LIMIT 1')
    end) or false, nil
end)

---@param society string The society that the money will be added to
---@param price number The amount of money that will be added
---@param playerIdentifier string The identifier of the player that executes the action
function AddMoneyToSociety(society, price, playerIdentifier)
    if oldQb then
        return exports['qb-management']:AddMoney(society, price, 'Test') -- if this export doesn't exist, please look at the documentation
    else
        return exports['qb-banking']:AddMoney(society, price, 'Test')
    end
end
