local L0_1, L1_1, L2_1
L0_1 = lib
if not L0_1 then
  return
end
L0_1 = lib
L0_1 = L0_1.class
L1_1 = "StorageManager"
L0_1 = L0_1(L1_1)
function L1_1(A0_2)
  local L1_2
  A0_2.haveLoadedStorages = false
  L1_2 = {}
  A0_2.storages = L1_2
end
L0_1.constructor = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = lib
  L1_2 = L1_2.print
  L1_2 = L1_2.debug
  L2_2 = "Loading storages from database "
  L3_2 = tostring
  L4_2 = A0_2.haveLoadedStorages
  L3_2 = L3_2(L4_2)
  L2_2 = L2_2 .. L3_2
  L1_2(L2_2)
  L1_2 = A0_2.haveLoadedStorages
  if L1_2 then
    return
  end
  A0_2.haveLoadedStorages = true
  L1_2 = lib
  L1_2 = L1_2.callback
  L1_2 = L1_2.await
  L2_2 = "nolag_storageunits:server:getStorages"
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = pairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L9_2 = A0_2
    L8_2 = A0_2.createStorage
    L10_2 = L6_2
    L11_2 = L7_2
    L8_2(L9_2, L10_2, L11_2)
  end
end
L0_1.loadStoragesFromDatabase = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = lib
  L1_2 = L1_2.print
  L1_2 = L1_2.debug
  L2_2 = "Deleting all storages"
  L1_2(L2_2)
  L1_2 = pairs
  L2_2 = A0_2.storages
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if L6_2 then
      L7_2 = L6_2.id
      if L7_2 then
        L8_2 = L6_2
        L7_2 = L6_2.delete
        L7_2(L8_2)
        L6_2 = nil
      end
    end
  end
  L1_2 = {}
  A0_2.storages = L1_2
  A0_2.haveLoadedStorages = false
end
L0_1.deleteAllStorages = L1_1
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = lib
  L3_2 = L3_2.print
  L3_2 = L3_2.debug
  L4_2 = "Creating property: "
  L5_2 = A1_2
  L4_2 = L4_2 .. L5_2
  L3_2(L4_2)
  L3_2 = A0_2.storages
  L3_2 = L3_2[A1_2]
  if L3_2 then
    L3_2 = lib
    L3_2 = L3_2.print
    L3_2 = L3_2.debug
    L4_2 = "Storage with id: "
    L5_2 = A1_2
    L6_2 = " already exists"
    L4_2 = L4_2 .. L5_2 .. L6_2
    L3_2(L4_2)
    L3_2 = A0_2.storages
    L3_2 = L3_2[A1_2]
    return L3_2
  end
  L3_2 = Storage
  L4_2 = L3_2
  L3_2 = L3_2.new
  L5_2 = A1_2
  L6_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = A0_2.storages
  L4_2[A1_2] = L3_2
  return L3_2
end
L0_1.createStorage = L1_1
function L1_1(A0_2)
  local L1_2
  L1_2 = A0_2.storages
  return L1_2
end
L0_1.getStorages = L1_1
function L1_1(A0_2)
  local L1_2
  L1_2 = A0_2.haveLoadedStorages
  return L1_2
end
L0_1.hasLoaded = L1_1
function L1_1(A0_2, A1_2)
  local L2_2
  L2_2 = A0_2.storages
  L2_2 = L2_2[A1_2]
  return L2_2
end
L0_1.getStorageById = L1_1
function L1_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = A0_2.storages
  L2_2 = L2_2[A1_2]
  L3_2 = L2_2
  L2_2 = L2_2.delete
  L2_2(L3_2)
  L2_2 = A0_2.storages
  L2_2[A1_2] = nil
end
L0_1.deleteStorageById = L1_1
L2_1 = L0_1
L1_1 = L0_1.new
L1_1 = L1_1(L2_1)
StorageManager = L1_1
return L0_1
