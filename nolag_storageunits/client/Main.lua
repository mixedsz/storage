local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
L0_1 = lib
L0_1 = L0_1.load
L1_1 = "config.client"
L0_1 = L0_1(L1_1)
L1_1 = lib
L1_1 = L1_1.load
L2_1 = "config.shared"
L1_1 = L1_1(L2_1)
L2_1 = lib
L2_1 = L2_1.class
L3_1 = "Storage"
L2_1 = L2_1(L3_1)
Storage = L2_1
L2_1 = Storage
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2
  A0_2.id = A1_2
  L3_2 = A2_2.coords
  A0_2.coords = L3_2
  L3_2 = A2_2.owner
  A0_2.owner = L3_2
  L3_2 = A2_2.label
  A0_2.label = L3_2
  L3_2 = A2_2.first_rented_date
  A0_2.first_rented_date = L3_2
  L3_2 = A2_2.expiring_date
  A0_2.expiring_date = L3_2
  L3_2 = A2_2.expired
  if not L3_2 then
    L3_2 = false
  end
  A0_2.expired = L3_2
  L3_2 = A2_2.failed_payments
  A0_2.failed_payments = L3_2
  L3_2 = A2_2.next_payment_attempt
  A0_2.next_payment_attempt = L3_2
  L3_2 = A2_2.rental_days
  A0_2.rental_days = L3_2
  L3_2 = A2_2.price
  A0_2.price = L3_2
  L3_2 = {}
  L4_2 = A2_2.blip
  if not L4_2 then
    L4_2 = false
  end
  L3_2.enabled = L4_2
  L3_2.handle = nil
  A0_2.blip = L3_2
  L3_2 = A2_2.inventory
  A0_2.inventory = L3_2
  L3_2 = A2_2.forever
  A0_2.forever = L3_2
  A0_2.zone = nil
  L4_2 = A0_2
  L3_2 = A0_2.createZones
  L3_2(L4_2)
  L3_2 = A2_2.blip
  if L3_2 then
    L4_2 = A0_2
    L3_2 = A0_2.createBlip
    L3_2(L4_2)
  end
end
L2_1.constructor = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = lib
  L1_2 = L1_2.print
  L1_2 = L1_2.debug
  L2_2 = "Creating zones for storage"
  L3_2 = A0_2.id
  L1_2(L2_2, L3_2)
  L1_2 = L0_1.targetEnabled
  if L1_2 then
    L1_2 = exports
    L1_2 = L1_2.ox_target
    L2_2 = L1_2
    L1_2 = L1_2.addSphereZone
    L3_2 = {}
    L4_2 = A0_2.coords
    L3_2.coords = L4_2
    L3_2.radius = 1.25
    L4_2 = L1_1.debug
    L3_2.debug = L4_2
    L4_2 = {}
    L5_2 = {}
    L6_2 = "Storage_%s"
    L7_2 = L6_2
    L6_2 = L6_2.format
    L8_2 = A0_2.id
    L6_2 = L6_2(L7_2, L8_2)
    L5_2.name = L6_2
    L5_2.icon = "fas fa-box"
    L6_2 = locale
    L7_2 = "open_storage"
    L6_2 = L6_2(L7_2)
    L5_2.label = L6_2
    L6_2 = L0_1.storageInteractDistance
    L5_2.distance = L6_2
    function L6_2()
      local L0_3, L1_3
      L0_3 = A0_2
      L1_3 = L0_3
      L0_3 = L0_3.manage
      L0_3(L1_3)
    end
    L5_2.onSelect = L6_2
    L4_2[1] = L5_2
    L3_2.options = L4_2
    L1_2 = L1_2(L2_2, L3_2)
    A0_2.zone = L1_2
  else
    L1_2 = lib
    L1_2 = L1_2.zones
    L1_2 = L1_2.sphere
    L2_2 = {}
    L3_2 = A0_2.coords
    L2_2.coords = L3_2
    L3_2 = L0_1.storageInteractDistance
    L2_2.radius = L3_2
    L3_2 = L1_1.debug
    L2_2.debug = L3_2
    function L3_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3
      L0_3 = PrimaryKeybind
      L1_3 = L0_3
      L0_3 = L0_3.getCurrentKey
      L0_3 = L0_3(L1_3)
      L1_3 = Utils
      L1_3 = L1_3.AddInteraction
      L2_3 = locale
      L3_3 = "keybind_open"
      L4_3 = L0_3
      L2_3 = L2_3(L3_3, L4_3)
      function L3_3()
        local L0_4, L1_4
        L0_4 = A0_2
        L1_4 = L0_4
        L0_4 = L0_4.manage
        L0_4(L1_4)
      end
      L1_3(L2_3, L3_3)
    end
    L2_2.onEnter = L3_2
    function L3_2()
      local L0_3, L1_3
      L0_3 = Utils
      L0_3 = L0_3.RemoveInteraction
      L0_3()
    end
    L2_2.onExit = L3_2
    L1_2 = L1_2(L2_2)
    A0_2.zone = L1_2
  end
end
L2_1.createZones = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = A0_2
  L1_2 = A0_2.shouldShowBlip
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    return
  end
  L1_2 = lib
  L1_2 = L1_2.print
  L1_2 = L1_2.debug
  L2_2 = "Creating blip for storage"
  L3_2 = A0_2.id
  L1_2(L2_2, L3_2)
  L2_2 = A0_2
  L1_2 = A0_2.getBlipType
  L1_2 = L1_2(L2_2)
  L2_2 = L0_1.blipData
  L2_2 = L2_2[L1_2]
  if L2_2 then
    L3_2 = A0_2.blip
    L4_2 = AddBlip
    L5_2 = A0_2.coords
    L6_2 = L2_2
    L7_2 = A0_2.label
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    L3_2.handle = L4_2
  end
end
L2_1.createBlip = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = lib
  L1_2 = L1_2.print
  L1_2 = L1_2.debug
  L2_2 = "Deleting storage"
  L3_2 = A0_2.id
  L1_2(L2_2, L3_2)
  L1_2 = type
  L2_2 = A0_2.zone
  L1_2 = L1_2(L2_2)
  if "number" == L1_2 then
    L1_2 = exports
    L1_2 = L1_2.ox_target
    L2_2 = L1_2
    L1_2 = L1_2.removeZone
    L3_2 = A0_2.zone
    L1_2(L2_2, L3_2)
  else
    L1_2 = A0_2.zone
    if L1_2 then
      L1_2 = A0_2.zone
      L1_2 = L1_2.remove
      if L1_2 then
        L1_2 = A0_2.zone
        L2_2 = L1_2
        L1_2 = L1_2.remove
        L1_2(L2_2)
      end
    end
  end
  L1_2 = A0_2.blip
  L1_2 = L1_2.handle
  if L1_2 then
    L2_2 = A0_2
    L1_2 = A0_2.deleteBlip
    L1_2(L2_2)
  end
  A0_2 = nil
end
L2_1.delete = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = A0_2.blip
  L1_2 = L1_2.handle
  if not L1_2 then
    return
  end
  L1_2 = lib
  L1_2 = L1_2.print
  L1_2 = L1_2.debug
  L2_2 = "Deleting blip for storage"
  L3_2 = A0_2.id
  L1_2(L2_2, L3_2)
  L1_2 = RemoveBlip
  L2_2 = A0_2.blip
  L2_2 = L2_2.handle
  L1_2(L2_2)
  L1_2 = A0_2.blip
  L1_2.handle = nil
end
L2_1.deleteBlip = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2
  L1_2 = A0_2.expired
  return L1_2
end
L2_1.isExpired = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.owner
  L2_2 = PlayerData
  L2_2 = L2_2.identifier
  L1_2 = L1_2 == L2_2
  return L1_2
end
L2_1.isOwner = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2
  L1_2 = A0_2.owner
  L1_2 = nil ~= L1_2
  return L1_2
end
L2_1.isOwned = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2
  L1_2 = A0_2.forever
  L1_2 = true == L1_2
  return L1_2
end
L2_1.isForever = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2
  L1_2 = A0_2.first_rented_date
  L1_2 = nil ~= L1_2
  return L1_2
end
L2_1.isRented = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = A0_2.blip
  L1_2 = L1_2.enabled
  if not L1_2 then
    L1_2 = false
    return L1_2
  end
  L2_2 = A0_2
  L1_2 = A0_2.getBlipType
  L1_2 = L1_2(L2_2)
  L2_2 = L0_1.blipData
  L2_2 = L2_2[L1_2]
  L3_2 = L2_2 or L3_2
  if L2_2 then
    L3_2 = L2_2.enabled
    L3_2 = true == L3_2
  end
  return L3_2
end
L2_1.shouldShowBlip = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2, L2_2
  L2_2 = A0_2
  L1_2 = A0_2.isExpired
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = "expired"
    return L1_2
  else
    L2_2 = A0_2
    L1_2 = A0_2.isOwner
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = "owner"
      return L1_2
    else
      L2_2 = A0_2
      L1_2 = A0_2.isOwned
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = "owned"
        return L1_2
      else
        L1_2 = "unowned"
        return L1_2
      end
    end
  end
end
L2_1.getBlipType = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = lib
  L1_2 = L1_2.callback
  L1_2 = L1_2.await
  L2_2 = "nolag_storageunits:server:getPlayerNames"
  L3_2 = false
  L4_2 = A0_2.owner
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  return L1_2
end
L2_1.getOwnerNames = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = L1_1.defaultSlots
  L2_2 = L1_1.defaultWeight
  L3_2 = A0_2.inventory
  if L3_2 then
    L3_2 = A0_2.inventory
    L3_2 = L3_2.slots
    if L3_2 then
      L3_2 = A0_2.inventory
      L3_2 = L3_2.weight
      if L3_2 then
        L3_2 = A0_2.inventory
        L1_2 = L3_2.slots
        L3_2 = A0_2.inventory
        L2_2 = L3_2.weight
      end
    end
  end
  L3_2 = L1_2
  L4_2 = L2_2
  return L3_2, L4_2
end
L2_1.getInventoryData = L3_1
L2_1 = Storage
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  if not A1_2 then
    return
  end
  L2_2 = A1_2.owner
  A0_2.owner = L2_2
  L2_2 = A1_2.label
  A0_2.label = L2_2
  L2_2 = A1_2.first_rented_date
  A0_2.first_rented_date = L2_2
  L2_2 = A1_2.expiring_date
  A0_2.expiring_date = L2_2
  L2_2 = A1_2.expired
  if not L2_2 then
    L2_2 = false
  end
  A0_2.expired = L2_2
  L2_2 = A1_2.failed_payments
  A0_2.failed_payments = L2_2
  L2_2 = A1_2.next_payment_attempt
  A0_2.next_payment_attempt = L2_2
  L2_2 = A1_2.rental_days
  A0_2.rental_days = L2_2
  L2_2 = A1_2.price
  A0_2.price = L2_2
  L2_2 = A1_2.inventory
  A0_2.inventory = L2_2
  L2_2 = A1_2.forever
  A0_2.forever = L2_2
  L3_2 = A0_2
  L2_2 = A0_2.shouldShowBlip
  L2_2 = L2_2(L3_2)
  L3_2 = A1_2.blip
  if false == L3_2 then
    L3_2 = A0_2.blip
    L3_2 = L3_2.handle
    if L3_2 then
      L4_2 = A0_2
      L3_2 = A0_2.deleteBlip
      L3_2(L4_2)
  end
  else
    L3_2 = A1_2.blip
    if true == L3_2 then
      L3_2 = A0_2.blip
      L3_2 = L3_2.handle
      if L3_2 and not L2_2 then
        L4_2 = A0_2
        L3_2 = A0_2.deleteBlip
        L3_2(L4_2)
      else
        L3_2 = A0_2.blip
        L3_2 = L3_2.handle
        if not L3_2 and L2_2 then
          L4_2 = A0_2
          L3_2 = A0_2.createBlip
          L3_2(L4_2)
        else
          L3_2 = A0_2.blip
          L3_2 = L3_2.handle
          if L3_2 and L2_2 then
            L4_2 = A0_2
            L3_2 = A0_2.deleteBlip
            L3_2(L4_2)
            L4_2 = A0_2
            L3_2 = A0_2.createBlip
            L3_2(L4_2)
          end
        end
      end
    end
  end
  L3_2 = A0_2.blip
  L4_2 = A1_2.blip
  L3_2.enabled = L4_2
end
L2_1.updateData = L3_1
L2_1 = Storage
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L3_2 = A0_2
  L2_2 = A0_2.isOwned
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = #L1_2
    L2_2 = L2_2 + 1
    L3_2 = Utils
    L3_2 = L3_2.CreateMenuOption
    L4_2 = "locale_open_storage"
    L5_2 = nil
    L6_2 = "fas fa-box"
    function L7_2()
      local L0_3, L1_3
      L0_3 = A0_2
      L1_3 = L0_3
      L0_3 = L0_3.open
      L0_3(L1_3)
    end
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    L1_2[L2_2] = L3_2
    L3_2 = A0_2
    L2_2 = A0_2.isExpired
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      L3_2 = A0_2
      L2_2 = A0_2.isOwner
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L2_2 = #L1_2
        L2_2 = L2_2 + 1
        L3_2 = Utils
        L3_2 = L3_2.CreateMenuOption
        L4_2 = "locale_change_password"
        L5_2 = nil
        L6_2 = "fas fa-key"
        function L7_2()
          local L0_3, L1_3
          L0_3 = A0_2
          L1_3 = L0_3
          L0_3 = L0_3.changePassword
          L0_3(L1_3)
        end
        L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
        L1_2[L2_2] = L3_2
        L2_2 = #L1_2
        L2_2 = L2_2 + 1
        L3_2 = Utils
        L3_2 = L3_2.CreateMenuOption
        L4_2 = "locale_transfer_storage"
        L5_2 = nil
        L6_2 = "fas fa-exchange-alt"
        function L7_2()
          local L0_3, L1_3
          L0_3 = A0_2
          L1_3 = L0_3
          L0_3 = L0_3.transferStorage
          L0_3(L1_3)
        end
        L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
        L1_2[L2_2] = L3_2
        L3_2 = A0_2
        L2_2 = A0_2.isForever
        L2_2 = L2_2(L3_2)
        if not L2_2 then
          L2_2 = #L1_2
          L2_2 = L2_2 + 1
          L3_2 = Utils
          L3_2 = L3_2.CreateMenuOption
          L4_2 = "locale_cancel_subscription"
          L5_2 = nil
          L6_2 = "fas fa-ban"
          function L7_2()
            local L0_3, L1_3
            L0_3 = A0_2
            L1_3 = L0_3
            L0_3 = L0_3.cancelSubscription
            L0_3(L1_3)
          end
          L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
          L1_2[L2_2] = L3_2
        end
    end
    else
      L3_2 = A0_2
      L2_2 = A0_2.isExpired
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L3_2 = A0_2
        L2_2 = A0_2.isOwner
        L2_2 = L2_2(L3_2)
        if L2_2 then
          L2_2 = L1_1.enableManualPaymentRetry
          if L2_2 then
            L2_2 = #L1_2
            L2_2 = L2_2 + 1
            L3_2 = Utils
            L3_2 = L3_2.CreateMenuOption
            L4_2 = "locale_retry_payment"
            L5_2 = nil
            L6_2 = "fas fa-credit-card"
            function L7_2()
              local L0_3, L1_3
              L0_3 = A0_2
              L1_3 = L0_3
              L0_3 = L0_3.retryPayment
              L0_3(L1_3)
            end
            L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
            L1_2[L2_2] = L3_2
          end
        end
      end
    end
    L2_2 = Framework
    L2_2 = L2_2.isPlayerAuthorizedToRaid
    L2_2 = L2_2()
    if L2_2 then
      L2_2 = #L1_2
      L2_2 = L2_2 + 1
      L3_2 = Utils
      L3_2 = L3_2.CreateMenuOption
      L4_2 = "locale_raid_storage"
      L5_2 = nil
      L6_2 = "fas fa-bomb"
      function L7_2()
        local L0_3, L1_3
        L0_3 = A0_2
        L1_3 = L0_3
        L0_3 = L0_3.raid
        L0_3(L1_3)
      end
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
      L1_2[L2_2] = L3_2
    end
  end
  L2_2 = #L1_2
  if L2_2 > 0 then
    L2_2 = lib
    L2_2 = L2_2.registerContext
    L3_2 = {}
    L3_2.id = "storageunits_manage"
    L4_2 = A0_2.label
    L3_2.title = L4_2
    L3_2.options = L1_2
    L2_2(L3_2)
    L2_2 = lib
    L2_2 = L2_2.showContext
    L3_2 = "storageunits_manage"
    L2_2(L3_2)
  else
    L3_2 = A0_2
    L2_2 = A0_2.open
    L2_2(L3_2)
  end
end
L2_1.manage = L3_1
function L2_1()
  local L0_2, L1_2
  L0_2 = StorageManager
  L1_2 = L0_2
  L0_2 = L0_2.loadStoragesFromDatabase
  L0_2(L1_2)
end
LoadStorages = L2_1
function L2_1()
  local L0_2, L1_2
  L0_2 = PlayerData
  L0_2 = L0_2.firstSpawn
  if not L0_2 then
    L0_2 = PlayerData
    L0_2.firstSpawn = true
    L0_2 = LoadStorages
    L0_2()
  end
end
L3_1 = RegisterNetEvent
L4_1 = OnPlayerLoadedEvent
function L5_1()
  local L0_2, L1_2
  L0_2 = PlayerData
  L0_2.loaded = true
  L0_2 = L2_1
  L0_2()
end
L3_1(L4_1, L5_1)
L3_1 = AddEventHandler
L4_1 = "onResourceStart"
function L5_1(A0_2)
  local L1_2, L2_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 ~= L1_2 then
    return
  end
  L1_2 = Wait
  L2_2 = 2000
  L1_2(L2_2)
  L1_2 = PlayerData
  L1_2.loaded = true
  L1_2 = L2_1
  L1_2()
end
L3_1(L4_1, L5_1)
L3_1 = AddStateBagChangeHandler
L4_1 = ""
L5_1 = "global"
function L6_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L5_2 = PlayerData
  L5_2 = L5_2.loaded
  if not L5_2 then
    return
  end
  L5_2 = tonumber
  L7_2 = A1_2
  L6_2 = A1_2.match
  L8_2 = "storage%.([%w_]+)"
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L6_2(L7_2, L8_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = A2_2
  if L5_2 then
    if nil == L6_2 then
      L7_2 = StorageManager
      L8_2 = L7_2
      L7_2 = L7_2.deleteStorageById
      L9_2 = L5_2
      L7_2(L8_2, L9_2)
    else
      L7_2 = StorageManager
      L8_2 = L7_2
      L7_2 = L7_2.getStorageById
      L9_2 = L5_2
      L7_2 = L7_2(L8_2, L9_2)
      if L7_2 then
        L9_2 = L7_2
        L8_2 = L7_2.updateData
        L10_2 = L6_2
        L8_2(L9_2, L10_2)
      else
        L8_2 = StorageManager
        L9_2 = L8_2
        L8_2 = L8_2.createStorage
        L10_2 = L5_2
        L11_2 = L6_2
        L8_2 = L8_2(L9_2, L10_2, L11_2)
        L7_2 = L8_2
      end
    end
  end
end
L3_1(L4_1, L5_1, L6_1)
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = {}
  L4_2 = A0_2
  L3_2 = A0_2.isRented
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L4_2 = A0_2
    L3_2 = A0_2.isForever
    L3_2 = L3_2(L4_2)
    if not L3_2 then
      L3_2 = #L2_2
      L3_2 = L3_2 + 1
      L4_2 = {}
      L5_2 = locale
      L6_2 = "rented"
      L5_2 = L5_2(L6_2)
      L4_2.label = L5_2
      L6_2 = A0_2
      L5_2 = A0_2.isOwned
      L5_2 = L5_2(L6_2)
      if L5_2 then
        L5_2 = "\226\156\133"
        if L5_2 then
          goto lbl_28
        end
      end
      L5_2 = "\226\157\140"
      ::lbl_28::
      L4_2.value = L5_2
      L2_2[L3_2] = L4_2
      L3_2 = "N/A"
      if A1_2 then
        L4_2 = A1_2.expiring_date
        if L4_2 then
          L3_2 = A1_2.expiring_date
      end
      else
        L4_2 = A0_2.expiring_date
        if L4_2 then
          L3_2 = A0_2.expiring_date
        end
      end
      L4_2 = Utils
      L4_2 = L4_2.FormatDateTime
      L5_2 = L3_2
      L4_2 = L4_2(L5_2)
      L5_2 = #L2_2
      L5_2 = L5_2 + 1
      L6_2 = {}
      L7_2 = locale
      L8_2 = "rented_until"
      L7_2 = L7_2(L8_2)
      L6_2.label = L7_2
      L6_2.value = L4_2
      L2_2[L5_2] = L6_2
      L5_2 = #L2_2
      L5_2 = L5_2 + 1
      L6_2 = {}
      L7_2 = locale
      L8_2 = "expired"
      L7_2 = L7_2(L8_2)
      L6_2.label = L7_2
      L8_2 = A0_2
      L7_2 = A0_2.isExpired
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L7_2 = "\226\156\133"
        if L7_2 then
          goto lbl_74
        end
      end
      L7_2 = "\226\157\140"
      ::lbl_74::
      L6_2.value = L7_2
      L2_2[L5_2] = L6_2
      L5_2 = #L2_2
      L5_2 = L5_2 + 1
      L6_2 = {}
      L7_2 = locale
      L8_2 = "rental_days"
      L7_2 = L7_2(L8_2)
      L6_2.label = L7_2
      L7_2 = A0_2.rental_days
      L6_2.value = L7_2
      L2_2[L5_2] = L6_2
  end
  else
    L4_2 = A0_2
    L3_2 = A0_2.isForever
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = #L2_2
      L3_2 = L3_2 + 1
      L4_2 = {}
      L5_2 = locale
      L6_2 = "bought"
      L5_2 = L5_2(L6_2)
      L4_2.label = L5_2
      L6_2 = A0_2
      L5_2 = A0_2.isForever
      L5_2 = L5_2(L6_2)
      if L5_2 then
        L5_2 = "\226\156\133"
        if L5_2 then
          goto lbl_110
        end
      end
      L5_2 = "\226\157\140"
      ::lbl_110::
      L4_2.value = L5_2
      L2_2[L3_2] = L4_2
    end
  end
  L4_2 = A0_2
  L3_2 = A0_2.isOwned
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = #L2_2
    L3_2 = L3_2 + 1
    L4_2 = {}
    L5_2 = locale
    L6_2 = "renter"
    L5_2 = L5_2(L6_2)
    L4_2.label = L5_2
    L6_2 = A0_2
    L5_2 = A0_2.getOwnerNames
    L5_2 = L5_2(L6_2)
    L4_2.value = L5_2
    L2_2[L3_2] = L4_2
  end
  L3_2 = #L2_2
  L3_2 = L3_2 + 1
  L4_2 = {}
  L5_2 = locale
  L6_2 = "price"
  L5_2 = L5_2(L6_2)
  L4_2.label = L5_2
  L5_2 = A0_2.price
  L4_2.value = L5_2
  L2_2[L3_2] = L4_2
  return L2_2
end
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = Framework
  L0_2 = L0_2.isPlayerAuthorizedToManageStorages
  L0_2 = L0_2()
  if not L0_2 then
    L0_2 = Utils
    L0_2 = L0_2.Notify
    L1_2 = "not_authorized"
    L2_2 = "error"
    L3_2 = 5000
    L0_2(L1_2, L2_2, L3_2)
    return
  end
  L0_2 = StorageManager
  L1_2 = L0_2
  L0_2 = L0_2.hasLoaded
  L0_2 = L0_2(L1_2)
  if not L0_2 then
    L0_2 = Utils
    L0_2 = L0_2.Notify
    L1_2 = "storages_not_loaded"
    L2_2 = "error"
    L3_2 = 5000
    L0_2(L1_2, L2_2, L3_2)
    return
  end
  L0_2 = StorageManager
  L1_2 = L0_2
  L0_2 = L0_2.getStorages
  L0_2 = L0_2(L1_2)
  L1_2 = {}
  L2_2 = pairs
  L3_2 = L0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L9_2 = L7_2
    L8_2 = L7_2.isRented
    L8_2 = L8_2(L9_2)
    if L8_2 then
      L9_2 = L7_2
      L8_2 = L7_2.isForever
      L8_2 = L8_2(L9_2)
      if not L8_2 then
        L8_2 = #L1_2
        L8_2 = L8_2 + 1
        L9_2 = L7_2.id
        L1_2[L8_2] = L9_2
      end
    end
  end
  L2_2 = {}
  L3_2 = #L1_2
  if L3_2 > 0 then
    L3_2 = lib
    L3_2 = L3_2.callback
    L3_2 = L3_2.await
    L4_2 = "nolag_storageunits:server:getStoragesExpirationData"
    L5_2 = false
    L6_2 = L1_2
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    L2_2 = L3_2
  end
  L3_2 = {}
  L4_2 = pairs
  L5_2 = L0_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L3_1
    L11_2 = L9_2
    L12_2 = L9_2.id
    L12_2 = L2_2[L12_2]
    L10_2 = L10_2(L11_2, L12_2)
    L11_2 = #L3_2
    L11_2 = L11_2 + 1
    L12_2 = Utils
    L12_2 = L12_2.CreateMenuOption
    L13_2 = L9_2.label
    L14_2 = nil
    L15_2 = "fas fa-box"
    function L16_2()
      local L0_3, L1_3
      L0_3 = L9_2
      L1_3 = L0_3
      L0_3 = L0_3.adminManage
      L0_3(L1_3)
    end
    L17_2 = L10_2
    L18_2 = true
    L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2[L11_2] = L12_2
  end
  L4_2 = #L3_2
  L4_2 = L4_2 + 1
  L5_2 = Utils
  L5_2 = L5_2.CreateMenuOption
  L6_2 = "locale_create_storage"
  L7_2 = nil
  L8_2 = "fas fa-plus"
  function L9_2()
    local L0_3, L1_3
    L0_3 = exports
    L0_3 = L0_3.nolag_storageunits
    L1_3 = L0_3
    L0_3 = L0_3.createStorage
    L0_3(L1_3)
  end
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L3_2[L4_2] = L5_2
  L4_2 = lib
  L4_2 = L4_2.registerContext
  L5_2 = {}
  L5_2.id = "storages_manage"
  L6_2 = locale
  L7_2 = "storages"
  L6_2 = L6_2(L7_2)
  L5_2.title = L6_2
  L5_2.options = L3_2
  L4_2(L5_2)
  L4_2 = lib
  L4_2 = L4_2.showContext
  L5_2 = "storages_manage"
  L4_2(L5_2)
end
L5_1 = exports
L6_1 = "manageStorages"
L7_1 = L4_1
L5_1(L6_1, L7_1)
L5_1 = Storage
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = A0_2
  L1_2 = A0_2.isOwned
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L2_2 = A0_2
    L1_2 = A0_2.isExpired
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = Utils
      L1_2 = L1_2.Notify
      L2_2 = "expired_storage"
      L3_2 = "error"
      L4_2 = 5000
      L1_2(L2_2, L3_2, L4_2)
      return
    end
    L1_2 = lib
    L1_2 = L1_2.inputDialog
    L2_2 = locale
    L3_2 = "storage"
    L2_2 = L2_2(L3_2)
    L3_2 = {}
    L4_2 = {}
    L4_2.type = "input"
    L5_2 = locale
    L6_2 = "enter_password"
    L5_2 = L5_2(L6_2)
    L4_2.label = L5_2
    L4_2.password = true
    L4_2.icon = "lock"
    L3_2[1] = L4_2
    L1_2 = L1_2(L2_2, L3_2)
    if not L1_2 then
      return
    end
    L2_2 = lib
    L2_2 = L2_2.callback
    L2_2 = L2_2.await
    L3_2 = "nolag_storageunits:server:validatePassword"
    L4_2 = false
    L5_2 = A0_2.id
    L6_2 = L1_2[1]
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
    if L2_2 then
      L3_2 = OpenInventory
      L4_2 = A0_2
      L3_2(L4_2)
    else
      L3_2 = Utils
      L3_2 = L3_2.Notify
      L4_2 = "wrong_password"
      L5_2 = "error"
      L6_2 = 5000
      L3_2(L4_2, L5_2, L6_2)
    end
  else
    L2_2 = A0_2
    L1_2 = A0_2.isForever
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = lib
      L1_2 = L1_2.alertDialog
      L2_2 = {}
      L3_2 = locale
      L4_2 = "buy_storage"
      L3_2 = L3_2(L4_2)
      L2_2.header = L3_2
      L3_2 = locale
      L4_2 = "buy_storage_description"
      L5_2 = A0_2.price
      L6_2 = A0_2.inventory
      L6_2 = L6_2.slots
      L7_2 = A0_2.inventory
      L7_2 = L7_2.weight
      L7_2 = L7_2 / 1000
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
      L2_2.content = L3_2
      L2_2.centered = true
      L2_2.cancel = true
      L2_2.size = "lg"
      L1_2 = L1_2(L2_2)
      if "confirm" ~= L1_2 then
        return
      end
      L2_2 = lib
      L2_2 = L2_2.inputDialog
      L3_2 = locale
      L4_2 = "options"
      L3_2 = L3_2(L4_2)
      L4_2 = {}
      L5_2 = {}
      L5_2.type = "input"
      L6_2 = locale
      L7_2 = "enter_password"
      L6_2 = L6_2(L7_2)
      L5_2.label = L6_2
      L5_2.password = true
      L5_2.icon = "lock"
      L4_2[1] = L5_2
      L2_2 = L2_2(L3_2, L4_2)
      if not L2_2 then
        return
      end
      L3_2 = tostring
      L4_2 = L2_2[1]
      L3_2 = L3_2(L4_2)
      L4_2 = lib
      L4_2 = L4_2.callback
      L4_2 = L4_2.await
      L5_2 = "nolag_storageunits:server:buyStorage"
      L6_2 = false
      L7_2 = tonumber
      L8_2 = A0_2.id
      L7_2 = L7_2(L8_2)
      L8_2 = L3_2
      L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
      if L4_2 then
        L5_2 = Utils
        L5_2 = L5_2.Notify
        L6_2 = "storage_bought"
        L7_2 = "success"
        L8_2 = 5000
        L5_2(L6_2, L7_2, L8_2)
      else
        L5_2 = Utils
        L5_2 = L5_2.Notify
        L6_2 = "something_went_wrong"
        L7_2 = "error"
        L8_2 = 5000
        L5_2(L6_2, L7_2, L8_2)
      end
    else
      L1_2 = lib
      L1_2 = L1_2.alertDialog
      L2_2 = {}
      L3_2 = locale
      L4_2 = "rent_storage"
      L3_2 = L3_2(L4_2)
      L2_2.header = L3_2
      L3_2 = locale
      L4_2 = "rent_storage_description"
      L5_2 = A0_2.price
      L6_2 = A0_2.rental_days
      L7_2 = A0_2.inventory
      L7_2 = L7_2.slots
      L8_2 = A0_2.inventory
      L8_2 = L8_2.weight
      L8_2 = L8_2 / 1000
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
      L2_2.content = L3_2
      L2_2.centered = true
      L2_2.cancel = true
      L2_2.size = "lg"
      L1_2 = L1_2(L2_2)
      if "confirm" ~= L1_2 then
        return
      end
      L2_2 = lib
      L2_2 = L2_2.inputDialog
      L3_2 = locale
      L4_2 = "options"
      L3_2 = L3_2(L4_2)
      L4_2 = {}
      L5_2 = {}
      L5_2.type = "input"
      L6_2 = locale
      L7_2 = "enter_password"
      L6_2 = L6_2(L7_2)
      L5_2.label = L6_2
      L5_2.password = true
      L5_2.icon = "lock"
      L4_2[1] = L5_2
      L2_2 = L2_2(L3_2, L4_2)
      if not L2_2 then
        return
      end
      L3_2 = tostring
      L4_2 = L2_2[1]
      L3_2 = L3_2(L4_2)
      L4_2 = lib
      L4_2 = L4_2.callback
      L4_2 = L4_2.await
      L5_2 = "nolag_storageunits:server:rentStorage"
      L6_2 = false
      L7_2 = tonumber
      L8_2 = A0_2.id
      L7_2 = L7_2(L8_2)
      L8_2 = L3_2
      L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
      if L4_2 then
        L5_2 = nil
        L6_2 = A0_2.rental_days
        if 1 == L6_2 then
          L6_2 = locale
          L7_2 = "day_singular"
          L6_2 = L6_2(L7_2)
          L5_2 = L6_2
        else
          L6_2 = string
          L6_2 = L6_2.format
          L7_2 = locale
          L8_2 = "day_plural"
          L7_2 = L7_2(L8_2)
          L8_2 = A0_2.rental_days
          L6_2 = L6_2(L7_2, L8_2)
          L5_2 = L6_2
        end
        L6_2 = string
        L6_2 = L6_2.format
        L7_2 = locale
        L8_2 = "rented_storage"
        L7_2 = L7_2(L8_2)
        L8_2 = L5_2
        L6_2 = L6_2(L7_2, L8_2)
        L7_2 = Utils
        L7_2 = L7_2.Notify
        L8_2 = L6_2
        L9_2 = "success"
        L10_2 = 5000
        L7_2(L8_2, L9_2, L10_2)
      end
    end
  end
end
L5_1.open = L6_1
L5_1 = Storage
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = lib
  L1_2 = L1_2.inputDialog
  L2_2 = locale
  L3_2 = "options"
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = {}
  L4_2.type = "input"
  L5_2 = locale
  L6_2 = "enter_password"
  L5_2 = L5_2(L6_2)
  L4_2.label = L5_2
  L4_2.password = true
  L4_2.icon = "lock"
  L5_2 = {}
  L5_2.type = "input"
  L6_2 = locale
  L7_2 = "new_password"
  L6_2 = L6_2(L7_2)
  L5_2.label = L6_2
  L5_2.password = true
  L5_2.icon = "lock"
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    return
  end
  L2_2 = tostring
  L3_2 = L1_2[1]
  L2_2 = L2_2(L3_2)
  L3_2 = tostring
  L4_2 = L1_2[2]
  L3_2 = L3_2(L4_2)
  if L2_2 == L3_2 then
    L4_2 = Utils
    L4_2 = L4_2.Notify
    L5_2 = "samePassword"
    L6_2 = "error"
    L7_2 = 5000
    L4_2(L5_2, L6_2, L7_2)
    return
  end
  L4_2 = lib
  L4_2 = L4_2.callback
  L4_2 = L4_2.await
  L5_2 = "nolag_storageunits:server:validateAndChangePassword"
  L6_2 = false
  L7_2 = A0_2.id
  L8_2 = L2_2
  L9_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  if L4_2 then
    L5_2 = Utils
    L5_2 = L5_2.Notify
    L6_2 = "changed_password"
    L7_2 = "success"
    L8_2 = 5000
    L5_2(L6_2, L7_2, L8_2)
    L6_2 = A0_2
    L5_2 = A0_2.open
    L5_2(L6_2)
  else
    L5_2 = Utils
    L5_2 = L5_2.Notify
    L6_2 = "wrong_password"
    L7_2 = "error"
    L8_2 = 5000
    L5_2(L6_2, L7_2, L8_2)
  end
end
L5_1.changePassword = L6_1
L5_1 = Storage
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = lib
  L1_2 = L1_2.alertDialog
  L2_2 = {}
  L3_2 = locale
  L4_2 = "cancel_subscription"
  L3_2 = L3_2(L4_2)
  L2_2.header = L3_2
  L3_2 = locale
  L4_2 = "cancel_description"
  L3_2 = L3_2(L4_2)
  L2_2.content = L3_2
  L2_2.centered = true
  L2_2.cancel = true
  L1_2 = L1_2(L2_2)
  if "confirm" ~= L1_2 then
    return
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "nolag_storageunits:server:cancelSubscription"
  L4_2 = false
  L5_2 = A0_2.id
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if L2_2 then
    L3_2 = Utils
    L3_2 = L3_2.Notify
    L4_2 = "rent_canceled"
    L5_2 = "success"
    L6_2 = 5000
    L3_2(L4_2, L5_2, L6_2)
  end
end
L5_1.cancelSubscription = L6_1
L5_1 = Storage
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = lib
  L1_2 = L1_2.alertDialog
  L2_2 = {}
  L3_2 = locale
  L4_2 = "retry_payment"
  L3_2 = L3_2(L4_2)
  L2_2.header = L3_2
  L3_2 = locale
  L4_2 = "retry_payment_description"
  L5_2 = A0_2.label
  L6_2 = A0_2.price
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L2_2.content = L3_2
  L2_2.centered = true
  L2_2.cancel = true
  L1_2 = L1_2(L2_2)
  if "confirm" ~= L1_2 then
    return
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "nolag_storageunits:server:manualPaymentRetry"
  L4_2 = false
  L5_2 = A0_2.id
  L2_2, L3_2 = L2_2(L3_2, L4_2, L5_2)
  if L2_2 then
    L4_2 = Utils
    L4_2 = L4_2.Notify
    L5_2 = L3_2
    L6_2 = "success"
    L7_2 = 5000
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = Wait
    L5_2 = 1000
    L4_2(L5_2)
    L5_2 = A0_2
    L4_2 = A0_2.open
    L4_2(L5_2)
  else
    L4_2 = Utils
    L4_2 = L4_2.Notify
    L5_2 = L3_2
    L6_2 = "error"
    L7_2 = 5000
    L4_2(L5_2, L6_2, L7_2)
  end
end
L5_1.retryPayment = L6_1
L5_1 = Storage
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = lib
  L1_2 = L1_2.getNearbyPlayers
  L2_2 = GetEntityCoords
  L3_2 = cache
  L3_2 = L3_2.ped
  L2_2 = L2_2(L3_2)
  L3_2 = 10
  L4_2 = false
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = #L1_2
  if 0 == L2_2 then
    L2_2 = Utils
    L2_2 = L2_2.Notify
    L3_2 = "no_players_nearby"
    L4_2 = "error"
    L5_2 = 5000
    L2_2(L3_2, L4_2, L5_2)
    return
  end
  L2_2 = {}
  L3_2 = ipairs
  L4_2 = L1_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = GetPlayerServerId
    L10_2 = L8_2.id
    L9_2 = L9_2(L10_2)
    L10_2 = lib
    L10_2 = L10_2.callback
    L10_2 = L10_2.await
    L11_2 = "nolag_storageunits:server:getPlayerNames"
    L12_2 = false
    L13_2 = L9_2
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L11_2 = #L2_2
    L11_2 = L11_2 + 1
    L12_2 = {}
    L13_2 = L10_2
    L14_2 = " - "
    L15_2 = L9_2
    L13_2 = L13_2 .. L14_2 .. L15_2
    L12_2.label = L13_2
    L12_2.value = L9_2
    L2_2[L11_2] = L12_2
  end
  L3_2 = lib
  L3_2 = L3_2.inputDialog
  L4_2 = locale
  L5_2 = "transfer_storage"
  L4_2 = L4_2(L5_2)
  L5_2 = {}
  L6_2 = {}
  L6_2.type = "select"
  L7_2 = locale
  L8_2 = "select_player"
  L7_2 = L7_2(L8_2)
  L6_2.label = L7_2
  L6_2.options = L2_2
  L7_2 = {}
  L7_2.type = "input"
  L8_2 = locale
  L9_2 = "enter_password"
  L8_2 = L8_2(L9_2)
  L7_2.label = L8_2
  L7_2.password = true
  L7_2.icon = "lock"
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    return
  end
  L4_2 = tonumber
  L5_2 = L3_2[1]
  L4_2 = L4_2(L5_2)
  L5_2 = tostring
  L6_2 = L3_2[2]
  L5_2 = L5_2(L6_2)
  L6_2 = lib
  L6_2 = L6_2.callback
  L6_2 = L6_2.await
  L7_2 = "nolag_storageunits:server:validateAndTransferStorage"
  L8_2 = false
  L9_2 = A0_2.id
  L10_2 = L5_2
  L11_2 = L4_2
  L6_2, L7_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  if L6_2 then
    A0_2.owner = L7_2
  else
    L8_2 = Utils
    L8_2 = L8_2.Notify
    L9_2 = "wrong_password"
    L10_2 = "error"
    L11_2 = 5000
    L8_2(L9_2, L10_2, L11_2)
  end
end
L5_1.transferStorage = L6_1
L5_1 = lib
L5_1 = L5_1.callback
L5_1 = L5_1.register
L6_1 = "nolag_storageunits:client:transferStorage"
function L7_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = lib
  L1_2 = L1_2.alertDialog
  L2_2 = {}
  L3_2 = locale
  L4_2 = "transfer_storage"
  L3_2 = L3_2(L4_2)
  L2_2.header = L3_2
  L3_2 = locale
  L4_2 = "transfer_storage_description"
  L5_2 = A0_2
  L3_2 = L3_2(L4_2, L5_2)
  L2_2.content = L3_2
  L2_2.centered = true
  L2_2.cancel = true
  L1_2 = L1_2(L2_2)
  L2_2 = "confirm" == L1_2
  return L2_2
end
L5_1(L6_1, L7_1)
L5_1 = Storage
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = #L1_2
  L2_2 = L2_2 + 1
  L3_2 = Utils
  L3_2 = L3_2.CreateMenuOption
  L4_2 = "locale_open_storage"
  L5_2 = nil
  L6_2 = "fas fa-box"
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = lib
    L0_3 = L0_3.callback
    L0_3 = L0_3.await
    L1_3 = "nolag_storageunits:server:forceOpenInventory"
    L2_3 = false
    L3_3 = A0_2.id
    L0_3 = L0_3(L1_3, L2_3, L3_3)
    if not L0_3 then
      L1_3 = Utils
      L1_3 = L1_3.Notify
      L2_3 = "not_authorized"
      L3_3 = "error"
      L4_3 = 5000
      L1_3(L2_3, L3_3, L4_3)
    end
  end
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L1_2[L2_2] = L3_2
  L2_2 = #L1_2
  L2_2 = L2_2 + 1
  L3_2 = Utils
  L3_2 = L3_2.CreateMenuOption
  L4_2 = "locale_edit_storage"
  L5_2 = nil
  L6_2 = "fas fa-edit"
  function L7_2()
    local L0_3, L1_3
    L0_3 = A0_2
    L1_3 = L0_3
    L0_3 = L0_3.edit
    L0_3(L1_3)
  end
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L1_2[L2_2] = L3_2
  L2_2 = #L1_2
  L2_2 = L2_2 + 1
  L3_2 = Utils
  L3_2 = L3_2.CreateMenuOption
  L4_2 = "locale_set_waypoint"
  L5_2 = nil
  L6_2 = "fas fa-map-marker-alt"
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = SetNewWaypoint
    L1_3 = A0_2.coords
    L1_3 = L1_3.x
    L2_3 = A0_2.coords
    L2_3 = L2_3.y
    L0_3(L1_3, L2_3)
    L0_3 = Utils
    L0_3 = L0_3.Notify
    L1_3 = "waypoint_set"
    L2_3 = "success"
    L3_3 = 5000
    L0_3(L1_3, L2_3, L3_3)
  end
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L1_2[L2_2] = L3_2
  L3_2 = A0_2
  L2_2 = A0_2.isOwned
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = #L1_2
    L2_2 = L2_2 + 1
    L3_2 = Utils
    L3_2 = L3_2.CreateMenuOption
    L4_2 = "locale_remove_renter"
    L5_2 = nil
    L6_2 = "fas fa-user-slash"
    function L7_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3
      L0_3 = lib
      L0_3 = L0_3.callback
      L0_3 = L0_3.await
      L1_3 = "nolag_storageunits:server:removeRenter"
      L2_3 = false
      L3_3 = A0_2.id
      L0_3 = L0_3(L1_3, L2_3, L3_3)
      if L0_3 then
        L1_3 = Utils
        L1_3 = L1_3.Notify
        L2_3 = "renter_removed"
        L3_3 = "success"
        L4_3 = 5000
        L1_3(L2_3, L3_3, L4_3)
      else
        L1_3 = Utils
        L1_3 = L1_3.Notify
        L2_3 = "something_went_wrong"
        L3_3 = "error"
        L4_3 = 5000
        L1_3(L2_3, L3_3, L4_3)
      end
    end
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    L1_2[L2_2] = L3_2
    L3_2 = A0_2
    L2_2 = A0_2.isExpired
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = #L1_2
      L2_2 = L2_2 + 1
      L3_2 = Utils
      L3_2 = L3_2.CreateMenuOption
      L4_2 = "locale_unlock_storage"
      L5_2 = nil
      L6_2 = "fas fa-lock-open"
      function L7_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3
        L0_3 = lib
        L0_3 = L0_3.callback
        L0_3 = L0_3.await
        L1_3 = "nolag_storageunits:server:toggleLock"
        L2_3 = false
        L3_3 = A0_2.id
        L4_3 = false
        L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3)
        if L0_3 then
          L1_3 = Utils
          L1_3 = L1_3.Notify
          L2_3 = "storage_unlocked"
          L3_3 = "success"
          L4_3 = 5000
          L1_3(L2_3, L3_3, L4_3)
          A0_2.expired = false
          L1_3 = A0_2.blip
          L1_3 = L1_3.handle
          if L1_3 then
            L1_3 = A0_2
            L2_3 = L1_3
            L1_3 = L1_3.deleteBlip
            L1_3(L2_3)
            L1_3 = A0_2
            L2_3 = L1_3
            L1_3 = L1_3.createBlip
            L1_3(L2_3)
          end
        else
          L1_3 = Utils
          L1_3 = L1_3.Notify
          L2_3 = "something_went_wrong"
          L3_3 = "error"
          L4_3 = 5000
          L1_3(L2_3, L3_3, L4_3)
        end
        L1_3 = A0_2
        L2_3 = L1_3
        L1_3 = L1_3.adminManage
        L1_3(L2_3)
      end
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
      L1_2[L2_2] = L3_2
    else
      L2_2 = #L1_2
      L2_2 = L2_2 + 1
      L3_2 = Utils
      L3_2 = L3_2.CreateMenuOption
      L4_2 = "locale_lock_storage"
      L5_2 = nil
      L6_2 = "fas fa-lock"
      function L7_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3
        L0_3 = lib
        L0_3 = L0_3.callback
        L0_3 = L0_3.await
        L1_3 = "nolag_storageunits:server:toggleLock"
        L2_3 = false
        L3_3 = A0_2.id
        L4_3 = true
        L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3)
        if L0_3 then
          L1_3 = Utils
          L1_3 = L1_3.Notify
          L2_3 = "storage_locked"
          L3_3 = "success"
          L4_3 = 5000
          L1_3(L2_3, L3_3, L4_3)
          A0_2.expired = true
          L1_3 = A0_2.blip
          L1_3 = L1_3.handle
          if L1_3 then
            L1_3 = A0_2
            L2_3 = L1_3
            L1_3 = L1_3.deleteBlip
            L1_3(L2_3)
            L1_3 = A0_2
            L2_3 = L1_3
            L1_3 = L1_3.createBlip
            L1_3(L2_3)
          end
        else
          L1_3 = Utils
          L1_3 = L1_3.Notify
          L2_3 = "something_went_wrong"
          L3_3 = "error"
          L4_3 = 5000
          L1_3(L2_3, L3_3, L4_3)
        end
        L1_3 = A0_2
        L2_3 = L1_3
        L1_3 = L1_3.adminManage
        L1_3(L2_3)
      end
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
      L1_2[L2_2] = L3_2
    end
  end
  L2_2 = Framework
  L2_2 = L2_2.isPlayerAuthorizedToDeleteStorage
  L2_2 = L2_2()
  if L2_2 then
    L2_2 = #L1_2
    L2_2 = L2_2 + 1
    L3_2 = Utils
    L3_2 = L3_2.CreateMenuOption
    L4_2 = "locale_delete_storage"
    L5_2 = nil
    L6_2 = "fas fa-trash"
    function L7_2()
      local L0_3, L1_3
      L0_3 = A0_2
      L1_3 = L0_3
      L0_3 = L0_3.destroy
      L0_3(L1_3)
    end
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    L1_2[L2_2] = L3_2
  end
  L2_2 = lib
  L2_2 = L2_2.registerContext
  L3_2 = {}
  L3_2.id = "storageunits_manage"
  L4_2 = A0_2.label
  L3_2.title = L4_2
  L3_2.menu = "storages_manage"
  L3_2.options = L1_2
  L2_2(L3_2)
  L2_2 = lib
  L2_2 = L2_2.showContext
  L3_2 = "storageunits_manage"
  L2_2(L3_2)
end
L5_1.adminManage = L6_1
L5_1 = Storage
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = A0_2.blip
  L1_2 = L1_2.enabled
  if L1_2 then
    L1_2 = true
    if L1_2 then
      goto lbl_9
    end
  end
  L1_2 = false
  ::lbl_9::
  L2_2 = lib
  L2_2 = L2_2.inputDialog
  L3_2 = locale
  L4_2 = "edit_storage"
  L3_2 = L3_2(L4_2)
  L4_2 = {}
  L5_2 = {}
  L5_2.type = "input"
  L6_2 = locale
  L7_2 = "label"
  L6_2 = L6_2(L7_2)
  L5_2.label = L6_2
  L6_2 = locale
  L7_2 = "label_description"
  L6_2 = L6_2(L7_2)
  L5_2.description = L6_2
  L5_2.required = true
  L5_2.min = 2
  L5_2.max = 16
  L6_2 = A0_2.label
  L5_2.default = L6_2
  L6_2 = {}
  L6_2.type = "number"
  L7_2 = locale
  L8_2 = "price"
  L7_2 = L7_2(L8_2)
  L6_2.label = L7_2
  L7_2 = locale
  L8_2 = "price_description"
  L7_2 = L7_2(L8_2)
  L6_2.description = L7_2
  L6_2.required = true
  L6_2.icon = "dollar-sign"
  L7_2 = A0_2.price
  L6_2.default = L7_2
  L7_2 = {}
  L7_2.type = "checkbox"
  L8_2 = locale
  L9_2 = "blip"
  L8_2 = L8_2(L9_2)
  L7_2.label = L8_2
  L8_2 = locale
  L9_2 = "blip_description"
  L8_2 = L8_2(L9_2)
  L7_2.description = L8_2
  L7_2.checked = L1_2
  L8_2 = {}
  L8_2.type = "slider"
  L9_2 = locale
  L10_2 = "rental_days"
  L9_2 = L9_2(L10_2)
  L8_2.label = L9_2
  L9_2 = locale
  L10_2 = "rental_days_description"
  L9_2 = L9_2(L10_2)
  L8_2.description = L9_2
  L8_2.min = 1
  L8_2.max = 30
  L9_2 = A0_2.rental_days
  L8_2.default = L9_2
  L8_2.icon = "fa-calendar"
  L9_2 = {}
  L9_2.type = "number"
  L10_2 = locale
  L11_2 = "inventory_slots"
  L10_2 = L10_2(L11_2)
  L9_2.label = L10_2
  L10_2 = locale
  L11_2 = "inventory_slots_description"
  L10_2 = L10_2(L11_2)
  L9_2.description = L10_2
  L9_2.required = true
  L9_2.min = 1
  L10_2 = A0_2.inventory
  L10_2 = L10_2.slots
  if not L10_2 then
    L10_2 = L1_1.defaultSlots
  end
  L9_2.default = L10_2
  L10_2 = L1_1.maxSlots
  L9_2.max = L10_2
  L9_2.icon = "fa-box-open"
  L10_2 = {}
  L10_2.type = "number"
  L11_2 = locale
  L12_2 = "inventory_weightlimit"
  L11_2 = L11_2(L12_2)
  L10_2.label = L11_2
  L11_2 = locale
  L12_2 = "inventory_weightlimit_description"
  L11_2 = L11_2(L12_2)
  L10_2.description = L11_2
  L10_2.required = true
  L10_2.min = 1
  L11_2 = A0_2.inventory
  L11_2 = L11_2.weight
  if not L11_2 then
    L11_2 = L1_1.defaultWeight
  end
  L10_2.default = L11_2
  L11_2 = L1_1.maxWeight
  L10_2.max = L11_2
  L10_2.icon = "fa-weight-hanging"
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L4_2[3] = L7_2
  L4_2[4] = L8_2
  L4_2[5] = L9_2
  L4_2[6] = L10_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    return
  end
  L3_2 = {}
  L4_2 = L2_2[1]
  L3_2.label = L4_2
  L4_2 = L2_2[2]
  L3_2.price = L4_2
  L4_2 = L2_2[3]
  L3_2.blip = L4_2
  L4_2 = L2_2[4]
  L3_2.rental_days = L4_2
  L4_2 = {}
  L5_2 = L2_2[5]
  L4_2.slots = L5_2
  L5_2 = L2_2[6]
  L4_2.weight = L5_2
  L3_2.inventory = L4_2
  L4_2 = lib
  L4_2 = L4_2.callback
  L4_2 = L4_2.await
  L5_2 = "nolag_storageunits:server:editStorage"
  L6_2 = false
  L7_2 = A0_2.id
  L8_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  if L4_2 then
    L5_2 = Utils
    L5_2 = L5_2.Notify
    L6_2 = "storage_edited"
    L7_2 = "success"
    L8_2 = 5000
    L5_2(L6_2, L7_2, L8_2)
  else
    L5_2 = Utils
    L5_2 = L5_2.Notify
    L6_2 = "storage_edit_failed"
    L7_2 = "error"
    L8_2 = 5000
    L5_2(L6_2, L7_2, L8_2)
  end
  L5_2 = Wait
  L6_2 = 500
  L5_2(L6_2)
  L5_2 = L4_1
  L5_2()
end
L5_1.edit = L6_1
L5_1 = Storage
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = Framework
  L1_2 = L1_2.isPlayerAuthorizedToRaid
  L1_2 = L1_2()
  if not L1_2 then
    L1_2 = Utils
    L1_2 = L1_2.Notify
    L2_2 = "not_authorized"
    L3_2 = "error"
    L4_2 = 5000
    L1_2(L2_2, L3_2, L4_2)
    return
  end
  L2_2 = A0_2
  L1_2 = A0_2.isOwned
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = Utils
    L1_2 = L1_2.Notify
    L2_2 = "not_owned"
    L3_2 = "error"
    L4_2 = 5000
    L1_2(L2_2, L3_2, L4_2)
    return
  end
  L2_2 = A0_2
  L1_2 = A0_2.isExpired
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = Utils
    L1_2 = L1_2.Notify
    L2_2 = "expired_storage"
    L3_2 = "error"
    L4_2 = 5000
    L1_2(L2_2, L3_2, L4_2)
    return
  end
  L1_2 = L0_1.RaidProperty
  L1_2 = L1_2()
  if L1_2 then
    L2_2 = Utils
    L2_2 = L2_2.Notify
    L3_2 = "storage_raid_success"
    L4_2 = "success"
    L5_2 = 5000
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = lib
    L2_2 = L2_2.callback
    L2_2 = L2_2.await
    L3_2 = "nolag_storageunits:server:raidStorage"
    L4_2 = false
    L5_2 = A0_2.id
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    if L2_2 then
      L3_2 = OpenInventory
      L4_2 = A0_2
      L3_2(L4_2)
    end
  else
    L2_2 = Utils
    L2_2 = L2_2.Notify
    L3_2 = "storage_raid_failed"
    L4_2 = "error"
    L5_2 = 5000
    L2_2(L3_2, L4_2, L5_2)
  end
end
L5_1.raid = L6_1
L5_1 = Storage
function L6_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = lib
  L1_2 = L1_2.alertDialog
  L2_2 = {}
  L3_2 = locale
  L4_2 = "delete_storage"
  L3_2 = L3_2(L4_2)
  L2_2.header = L3_2
  L3_2 = locale
  L4_2 = "delete_storage_description"
  L3_2 = L3_2(L4_2)
  L2_2.content = L3_2
  L2_2.centered = true
  L2_2.cancel = true
  L1_2 = L1_2(L2_2)
  if "confirm" ~= L1_2 then
    return
  end
  L2_2 = lib
  L2_2 = L2_2.callback
  L2_2 = L2_2.await
  L3_2 = "nolag_storageunits:server:deleteStorage"
  L4_2 = false
  L5_2 = A0_2.id
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if L2_2 then
    L3_2 = Utils
    L3_2 = L3_2.Notify
    L4_2 = "storage_deleted"
    L5_2 = "success"
    L6_2 = 5000
    L3_2(L4_2, L5_2, L6_2)
  end
end
L5_1.destroy = L6_1
