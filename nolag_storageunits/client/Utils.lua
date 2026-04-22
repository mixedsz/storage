local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1
L0_1 = lib
L0_1 = L0_1.load
L1_1 = "config.client"
L0_1 = L0_1(L1_1)
L1_1 = {}
Utils = L1_1
L1_1 = nil
L2_1 = lib
L2_1 = L2_1.addKeybind
L3_1 = {}
L3_1.name = "+storage_interact"
L4_1 = locale
L5_1 = "keybind_description"
L4_1 = L4_1(L5_1)
L3_1.description = L4_1
L4_1 = L0_1.keybinds
L4_1 = L4_1.interact
L3_1.defaultKey = L4_1
function L4_1(A0_2)
  local L1_2
  L1_2 = L1_1
  if L1_2 then
    L1_2 = L1_1
    L1_2()
  end
end
L3_1.onPressed = L4_1
L2_1 = L2_1(L3_1)
PrimaryKeybind = L2_1
L2_1 = Utils
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = Notify
  L4_2 = {}
  L5_2 = locale
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L4_2.message = L5_2
  L4_2.type = A1_2
  L4_2.time = A2_2
  L3_2(L4_2)
end
L2_1.Notify = L3_1
L2_1 = Utils
function L3_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2
  L6_2 = string
  L6_2 = L6_2.sub
  L7_2 = A0_2
  L8_2 = 1
  L9_2 = 7
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  if "locale_" == L6_2 then
    L6_2 = locale
    L7_2 = string
    L7_2 = L7_2.sub
    L8_2 = A0_2
    L9_2 = 8
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2, L9_2)
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
    if L6_2 then
      goto lbl_19
    end
  end
  L6_2 = A0_2
  ::lbl_19::
  if A1_2 then
    L7_2 = string
    L7_2 = L7_2.sub
    L8_2 = A1_2
    L9_2 = 1
    L10_2 = 7
    L7_2 = L7_2(L8_2, L9_2, L10_2)
    if "locale_" == L7_2 then
      L7_2 = locale
      L8_2 = string
      L8_2 = L8_2.sub
      L9_2 = A1_2
      L10_2 = 8
      L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2)
      L7_2 = L7_2(L8_2, L9_2, L10_2)
      if L7_2 then
        goto lbl_39
      end
    end
  end
  L7_2 = A1_2
  ::lbl_39::
  L8_2 = {}
  L8_2.title = L6_2
  L8_2.description = L7_2
  L8_2.icon = A2_2
  L8_2.onSelect = A3_2
  L8_2.metadata = A4_2
  L8_2.arrow = A5_2
  return L8_2
end
L2_1.CreateMenuOption = L3_1
L2_1 = Utils
function L3_1(A0_2, A1_2)
  local L2_2, L3_2
  L1_1 = A1_2
  L2_2 = ShowTextUI
  L3_2 = A0_2
  L2_2(L3_2)
end
L2_1.AddInteraction = L3_1
L2_1 = Utils
function L3_1()
  local L0_2, L1_2
  L0_2 = nil
  L1_1 = L0_2
  L0_2 = HideTextUI
  L0_2()
end
L2_1.RemoveInteraction = L3_1
L2_1 = Utils
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  if not A0_2 then
    L1_2 = "N/A"
    return L1_2
  end
  function L1_2(A0_3)
    local L1_3
    L1_3 = A0_3 % 4
    if 0 == L1_3 then
      L1_3 = A0_3 % 100
    end
    L1_3 = 0 ~= L1_3
    return L1_3
  end
  function L2_2(A0_3)
    local L1_3, L2_3
    L1_3 = L1_2
    L2_3 = A0_3
    L1_3 = L1_3(L2_3)
    if L1_3 then
      L1_3 = 366
      if L1_3 then
        goto lbl_10
      end
    end
    L1_3 = 365
    ::lbl_10::
    return L1_3
  end
  L3_2 = {}
  L4_2 = 31
  L5_2 = 28
  L6_2 = 31
  L7_2 = 30
  L8_2 = 31
  L9_2 = 30
  L10_2 = 31
  L11_2 = 31
  L12_2 = 30
  L13_2 = 31
  L14_2 = 30
  L15_2 = 31
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L3_2[4] = L7_2
  L3_2[5] = L8_2
  L3_2[6] = L9_2
  L3_2[7] = L10_2
  L3_2[8] = L11_2
  L3_2[9] = L12_2
  L3_2[10] = L13_2
  L3_2[11] = L14_2
  L3_2[12] = L15_2
  function L4_2(A0_3, A1_3)
    local L2_3, L3_3
    if 2 == A1_3 then
      L2_3 = L1_2
      L3_3 = A0_3
      L2_3 = L2_3(L3_3)
      if L2_3 then
        L2_3 = 29
        return L2_3
      end
    end
    L2_3 = L3_2
    L2_3 = L2_3[A1_3]
    return L2_3
  end
  function L5_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L1_3 = math
    L1_3 = L1_3.floor
    L2_3 = tonumber
    L3_3 = A0_3
    L2_3 = L2_3(L3_3)
    if not L2_3 then
      L2_3 = 0
    end
    L1_3 = L1_3(L2_3)
    A0_3 = L1_3
    if A0_3 < 0 then
      A0_3 = 0
    end
    L1_3 = math
    L1_3 = L1_3.floor
    L2_3 = A0_3 / 86400
    L1_3 = L1_3(L2_3)
    L2_3 = A0_3 % 86400
    L3_3 = 1970
    while true do
      L4_3 = L2_2
      L5_3 = L3_3
      L4_3 = L4_3(L5_3)
      if L1_3 >= L4_3 then
        L1_3 = L1_3 - L4_3
        L3_3 = L3_3 + 1
      else
        break
      end
    end
    L4_3 = 1
    while true do
      L5_3 = L4_2
      L6_3 = L3_3
      L7_3 = L4_3
      L5_3 = L5_3(L6_3, L7_3)
      if L1_3 >= L5_3 then
        L1_3 = L1_3 - L5_3
        L4_3 = L4_3 + 1
      else
        break
      end
    end
    L5_3 = L1_3 + 1
    L6_3 = math
    L6_3 = L6_3.floor
    L7_3 = L2_3 / 3600
    L6_3 = L6_3(L7_3)
    L2_3 = L2_3 % 3600
    L7_3 = math
    L7_3 = L7_3.floor
    L8_3 = L2_3 / 60
    L7_3 = L7_3(L8_3)
    L8_3 = L2_3 % 60
    L9_3 = string
    L9_3 = L9_3.format
    L10_3 = "%04d-%02d-%02d %02d:%02d:%02d"
    L11_3 = L3_3
    L12_3 = L4_3
    L13_3 = L5_3
    L14_3 = L6_3
    L15_3 = L7_3
    L16_3 = L8_3
    return L9_3(L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3)
  end
  L6_2 = type
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  if "string" == L6_2 then
    L8_2 = A0_2
    L7_2 = A0_2.match
    L9_2 = "^%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d$"
    L7_2 = L7_2(L8_2, L9_2)
    if L7_2 then
      return A0_2
    end
    L7_2 = tonumber
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    if L7_2 then
      L8_2 = #A0_2
      if L8_2 >= 13 then
        L8_2 = L5_2
        L9_2 = math
        L9_2 = L9_2.floor
        L10_2 = L7_2 / 1000
        L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L9_2(L10_2)
        return L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      else
        L8_2 = L5_2
        L9_2 = L7_2
        return L8_2(L9_2)
      end
    end
    return A0_2
  elseif "number" == L6_2 then
    L7_2 = 100000000000
    if A0_2 > L7_2 then
      L7_2 = L5_2
      L8_2 = math
      L8_2 = L8_2.floor
      L9_2 = A0_2 / 1000
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L8_2(L9_2)
      return L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    else
      L7_2 = L5_2
      L8_2 = A0_2
      return L7_2(L8_2)
    end
  end
  L7_2 = tostring
  L8_2 = A0_2
  return L7_2(L8_2)
end
L2_1.FormatDateTime = L3_1
L2_1 = AddEventHandler
L3_1 = "onResourceStop"
function L4_1(A0_2)
  local L1_2
  L1_2 = cache
  L1_2 = L1_2.resource
  if A0_2 ~= L1_2 then
    return
  end
  L1_2 = L1_1
  if L1_2 then
    L1_2 = HideTextUI
    L1_2()
  end
end
L2_1(L3_1, L4_1)
