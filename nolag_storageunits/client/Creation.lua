local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
L0_1 = lib
L0_1 = L0_1.load
L1_1 = "config.shared"
L0_1 = L0_1(L1_1)
L1_1 = math
L1_1 = L1_1.abs
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  function L1_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3
    L2_3 = A0_2
    L2_3 = L2_3[A0_3]
    L2_3 = L2_3.x
    L3_3 = A0_2
    L3_3 = L3_3[A1_3]
    L3_3 = L3_3.y
    L2_3 = L2_3 * L3_3
    L3_3 = A0_2
    L3_3 = L3_3[A1_3]
    L3_3 = L3_3.x
    L4_3 = A0_2
    L4_3 = L4_3[A0_3]
    L4_3 = L4_3.y
    L3_3 = L3_3 * L4_3
    L2_3 = L2_3 - L3_3
    return L2_3
  end
  L2_2 = #A0_2
  if L2_2 > 2 then
    L2_2 = L1_2
    L3_2 = #A0_2
    L4_2 = 1
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      goto lbl_12
    end
  end
  L2_2 = 0
  ::lbl_12::
  L3_2 = 1
  L4_2 = #A0_2
  L4_2 = L4_2 - 1
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = L1_2
    L8_2 = L6_2
    L9_2 = L6_2 + 1
    L7_2 = L7_2(L8_2, L9_2)
    L2_2 = L2_2 + L7_2
  end
  L3_2 = L1_1
  L4_2 = 0.5 * L2_2
  return L3_2(L4_2)
end
CalculatePolygonArea = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2
  L1_2 = GetGameplayCamCoord
  L1_2 = L1_2()
  L2_2 = GetGameplayCamRot
  L2_2 = L2_2()
  L3_2 = {}
  L3_2.camera = L1_2
  L3_2.rotation = L2_2
  L4_2 = RayCastGamePlayCamera
  L5_2 = 5000.0
  L6_2 = L3_2
  L4_2, L5_2, L6_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L7_2 = GetEntityCoords
    L8_2 = PlayerPedId
    L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2 = L8_2()
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)
    L8_2 = DrawLine
    L9_2 = L7_2.x
    L10_2 = L7_2.y
    L11_2 = L7_2.z
    L12_2 = L5_2.x
    L13_2 = L5_2.y
    L14_2 = L5_2.z
    L15_2 = A0_2.r
    L16_2 = A0_2.g
    L17_2 = A0_2.b
    L18_2 = A0_2.a
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L8_2 = DrawMarker
    L9_2 = 28
    L10_2 = L5_2.x
    L11_2 = L5_2.y
    L12_2 = L5_2.z
    L13_2 = 0.0
    L14_2 = 0.0
    L15_2 = 0.0
    L16_2 = 0.0
    L17_2 = 180.0
    L18_2 = 0.0
    L19_2 = 0.1
    L20_2 = 0.1
    L21_2 = 0.1
    L22_2 = A0_2.r
    L23_2 = A0_2.g
    L24_2 = A0_2.b
    L25_2 = A0_2.a
    L26_2 = false
    L27_2 = true
    L28_2 = 2
    L29_2 = nil
    L30_2 = nil
    L31_2 = false
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2)
  end
  L7_2 = L4_2
  L8_2 = L5_2
  return L7_2, L8_2
end
DrawLaser = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = {}
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.x
  L2_2 = L2_2 * L3_2
  L1_2.x = L2_2
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.y
  L2_2 = L2_2 * L3_2
  L1_2.y = L2_2
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.z
  L2_2 = L2_2 * L3_2
  L1_2.z = L2_2
  L2_2 = {}
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2.z
  L3_2 = L3_2(L4_2)
  L3_2 = -L3_2
  L4_2 = math
  L4_2 = L4_2.abs
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = L1_2.x
  L5_2, L6_2 = L5_2(L6_2)
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 * L4_2
  L2_2.x = L3_2
  L3_2 = math
  L3_2 = L3_2.cos
  L4_2 = L1_2.z
  L3_2 = L3_2(L4_2)
  L4_2 = math
  L4_2 = L4_2.abs
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = L1_2.x
  L5_2, L6_2 = L5_2(L6_2)
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 * L4_2
  L2_2.y = L3_2
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2.x
  L3_2 = L3_2(L4_2)
  L2_2.z = L3_2
  return L2_2
end
RotationToDirection = L2_1
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = GetGameplayCamRot
  L2_2 = L2_2()
  L3_2 = GetGameplayCamCoord
  L3_2 = L3_2()
  if A1_2 then
    L2_2 = A1_2.rotation
    L3_2 = A1_2.camera
  end
  L4_2 = RotationToDirection
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  L5_2 = {}
  L6_2 = L3_2.x
  L7_2 = L4_2.x
  L7_2 = L7_2 * A0_2
  L6_2 = L6_2 + L7_2
  L5_2.x = L6_2
  L6_2 = L3_2.y
  L7_2 = L4_2.y
  L7_2 = L7_2 * A0_2
  L6_2 = L6_2 + L7_2
  L5_2.y = L6_2
  L6_2 = L3_2.z
  L7_2 = L4_2.z
  L7_2 = L7_2 * A0_2
  L6_2 = L6_2 + L7_2
  L5_2.z = L6_2
  L6_2 = GetShapeTestResult
  L7_2 = StartShapeTestRay
  L8_2 = L3_2.x
  L9_2 = L3_2.y
  L10_2 = L3_2.z
  L11_2 = L5_2.x
  L12_2 = L5_2.y
  L13_2 = L5_2.z
  L14_2 = -1
  L15_2 = PlayerPedId
  L15_2 = L15_2()
  L16_2 = 0
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L6_2, L7_2, L8_2, L9_2, L10_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L11_2 = L7_2
  L12_2 = L8_2
  L13_2 = L10_2
  return L11_2, L12_2, L13_2
end
RayCastGamePlayCamera = L2_1
L2_1 = lib
L2_1 = L2_1.disableControls
L3_1 = L2_1
L2_1 = L2_1.Add
L4_1 = {}
L5_1 = 24
L6_1 = 25
L4_1[1] = L5_1
L4_1[2] = L6_1
L2_1(L3_1, L4_1)
L2_1 = false
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = Wait
  L1_2 = 500
  L0_2(L1_2)
  L0_2 = true
  L2_1 = L0_2
  L0_2 = lib
  L0_2 = L0_2.showTextUI
  L1_2 = locale
  L2_2 = "point_help"
  L1_2 = L1_2(L2_2)
  L2_2 = {}
  L2_2.icon = "fas fa-mouse-pointer"
  L0_2(L1_2, L2_2)
  L0_2 = DrawLaser
  L1_2 = {}
  L1_2.r = 108
  L1_2.g = 0
  L1_2.b = 135
  L1_2.a = 200
  L0_2, L1_2 = L0_2(L1_2)
  while true do
    L2_2 = L2_1
    if not L2_2 then
      break
    end
    L2_2 = Wait
    L3_2 = 1
    L2_2(L3_2)
    L2_2 = lib
    L2_2 = L2_2.disableControls
    L2_2()
    L2_2 = DrawLaser
    L3_2 = {}
    L3_2.r = 108
    L3_2.g = 0
    L3_2.b = 135
    L3_2.a = 200
    L2_2, L3_2 = L2_2(L3_2)
    L1_2 = L3_2
    L0_2 = L2_2
    L2_2 = IsDisabledControlJustPressed
    L3_2 = 0
    L4_2 = 24
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 and L0_2 then
      L2_2 = false
      L2_1 = L2_2
      L2_2 = lib
      L2_2 = L2_2.hideTextUI
      L2_2()
      return L1_2
    end
  end
end
GetPointCoords = L3_1
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = GetEntityCoords
  L1_2 = cache
  L1_2 = L1_2.ped
  L0_2 = L0_2(L1_2)
  L1_2 = Citizen
  L1_2 = L1_2.InvokeNative
  L2_2 = 3365332906397525184
  L3_2 = L0_2.x
  L4_2 = L0_2.y
  L5_2 = L0_2.z
  L6_2 = Citizen
  L6_2 = L6_2.PointerValueInt
  L6_2 = L6_2()
  L7_2 = Citizen
  L7_2 = L7_2.PointerValueInt
  L7_2 = L7_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = GetStreetNameFromHashKey
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  return L2_2
end
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = L3_1
  L0_2 = L0_2()
  L1_2 = lib
  L1_2 = L1_2.inputDialog
  L2_2 = locale
  L3_2 = "create_storage"
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = {}
  L4_2.type = "input"
  L5_2 = locale
  L6_2 = "label"
  L5_2 = L5_2(L6_2)
  L4_2.label = L5_2
  L5_2 = locale
  L6_2 = "label_description"
  L5_2 = L5_2(L6_2)
  L4_2.description = L5_2
  L4_2.required = true
  L4_2.min = 2
  L4_2.max = 30
  L4_2.default = L0_2
  L5_2 = {}
  L5_2.type = "number"
  L6_2 = locale
  L7_2 = "price"
  L6_2 = L6_2(L7_2)
  L5_2.label = L6_2
  L6_2 = locale
  L7_2 = "price_description"
  L6_2 = L6_2(L7_2)
  L5_2.description = L6_2
  L5_2.required = true
  L5_2.icon = "dollar-sign"
  L6_2 = {}
  L6_2.type = "checkbox"
  L7_2 = locale
  L8_2 = "can_buy_forever"
  L7_2 = L7_2(L8_2)
  L6_2.label = L7_2
  L6_2.required = false
  L7_2 = {}
  L7_2.type = "checkbox"
  L8_2 = locale
  L9_2 = "blip"
  L8_2 = L8_2(L9_2)
  L7_2.label = L8_2
  L7_2.required = false
  L8_2 = {}
  L8_2.type = "slider"
  L9_2 = locale
  L10_2 = "rental_days"
  L9_2 = L9_2(L10_2)
  L8_2.label = L9_2
  L8_2.required = true
  L8_2.min = 1
  L8_2.max = 30
  L8_2.default = 7
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
  L10_2 = L0_1.defaultSlots
  L9_2.default = L10_2
  L10_2 = L0_1.maxSlots
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
  L11_2 = L0_1.defaultWeight
  L10_2.default = L11_2
  L11_2 = L0_1.maxWeight
  L10_2.max = L11_2
  L10_2.icon = "fa-weight-hanging"
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L3_2[4] = L7_2
  L3_2[5] = L8_2
  L3_2[6] = L9_2
  L3_2[7] = L10_2
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    return
  end
  L2_2 = GetPointCoords
  L2_2 = L2_2()
  L3_2 = {}
  L4_2 = L1_2[1]
  L3_2.label = L4_2
  L4_2 = L1_2[2]
  L3_2.price = L4_2
  L4_2 = L1_2[3]
  L3_2.forever = L4_2
  L4_2 = L1_2[4]
  L3_2.blip = L4_2
  L4_2 = L1_2[5]
  L3_2.rental_days = L4_2
  L3_2.coords = L2_2
  L4_2 = {}
  L5_2 = L1_2[6]
  L4_2.slots = L5_2
  L5_2 = L1_2[7]
  L4_2.weight = L5_2
  L3_2.inventory = L4_2
  L4_2 = lib
  L4_2 = L4_2.callback
  L4_2 = L4_2.await
  L5_2 = "nolag_storageunits:server:createStorage"
  L6_2 = 200
  L7_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  if L4_2 then
    L5_2 = Utils
    L5_2 = L5_2.Notify
    L6_2 = "storage_created_title"
    L7_2 = "storage_created_description"
    L8_2 = 5000
    L5_2(L6_2, L7_2, L8_2)
  else
    L5_2 = Utils
    L5_2 = L5_2.Notify
    L6_2 = "storage_created_error_title"
    L7_2 = "storage_created_error_description"
    L8_2 = 5000
    L5_2(L6_2, L7_2, L8_2)
  end
end
L5_1 = exports
L6_1 = "createStorage"
L7_1 = L4_1
L5_1(L6_1, L7_1)
