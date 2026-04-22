local sharedConfig = lib.load("config.shared")
local mathAbs = math.abs

function CalculatePolygonArea(points)
    local function cross(i, j)
        return points[i].x * points[j].y - points[j].x * points[i].y
    end

    local area = 0
    if #points > 2 then
        local wrap = cross(#points, 1)
        if wrap then
            area = wrap
        end
    else
        area = 0
    end

    for i = 1, #points - 1 do
        area = area + cross(i, i + 1)
    end

    return mathAbs(0.5 * area)
end

function DrawLaser(color)
    local camCoords = GetGameplayCamCoord()
    local camRot = GetGameplayCamRot()
    local cameraData = { camera = camCoords, rotation = camRot }

    local hit, hitCoords = RayCastGamePlayCamera(5000.0, cameraData)
    if hit then
        local pedCoords = GetEntityCoords(PlayerPedId())
        DrawLine(pedCoords.x, pedCoords.y, pedCoords.z, hitCoords.x, hitCoords.y, hitCoords.z, color.r, color.g, color.b, color.a)
        DrawMarker(28, hitCoords.x, hitCoords.y, hitCoords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)
    end

    return hit, hitCoords
end

function RotationToDirection(rotation)
    local rad = {
        x = math.pi / 180 * rotation.x,
        y = math.pi / 180 * rotation.y,
        z = math.pi / 180 * rotation.z
    }

    return {
        x = -math.sin(rad.z) * math.abs(math.cos(rad.x)),
        y = math.cos(rad.z) * math.abs(math.cos(rad.x)),
        z = math.sin(rad.x)
    }
end

function RayCastGamePlayCamera(distance, cameraData)
    local camRot = GetGameplayCamRot()
    local camCoords = GetGameplayCamCoord()

    if cameraData then
        camRot = cameraData.rotation
        camCoords = cameraData.camera
    end

    local dir = RotationToDirection(camRot)
    local dest = {
        x = camCoords.x + dir.x * distance,
        y = camCoords.y + dir.y * distance,
        z = camCoords.z + dir.z * distance
    }

    local rayHandle = StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, dest.x, dest.y, dest.z, -1, PlayerPedId(), 0)
    local _, hit, hitCoords, _, _ = GetShapeTestResult(rayHandle)

    return hit, hitCoords
end

lib.disableControls.Add({ 24, 25 })

local pointSelectionActive = false

function GetPointCoords()
    Wait(500)
    pointSelectionActive = true
    lib.showTextUI(locale("point_help"), { icon = "fas fa-mouse-pointer" })

    local hit, hitCoords = DrawLaser({ r = 108, g = 0, b = 135, a = 200 })

    while true do
        if not pointSelectionActive then break end
        Wait(1)
        lib.disableControls()
        hit, hitCoords = DrawLaser({ r = 108, g = 0, b = 135, a = 200 })

        if IsDisabledControlJustPressed(0, 24) and hit then
            pointSelectionActive = false
            lib.hideTextUI()
            return hitCoords
        end
    end
end

local function GetStreetName()
    local pedCoords = GetEntityCoords(cache.ped)
    local streetHash = Citizen.InvokeNative(3365332906397525184, pedCoords.x, pedCoords.y, pedCoords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    return GetStreetNameFromHashKey(streetHash)
end

local function createStorageDialog()
    local streetName = GetStreetName()

    local input = lib.inputDialog(locale("create_storage"), {
        {
            type = "input",
            label = locale("label"),
            description = locale("label_description"),
            required = true,
            min = 2,
            max = 30,
            default = streetName
        },
        {
            type = "number",
            label = locale("price"),
            description = locale("price_description"),
            required = true,
            icon = "dollar-sign"
        },
        {
            type = "checkbox",
            label = locale("can_buy_forever"),
            required = false
        },
        {
            type = "checkbox",
            label = locale("blip"),
            required = false
        },
        {
            type = "slider",
            label = locale("rental_days"),
            required = true,
            min = 1,
            max = 30,
            default = 7,
            icon = "fa-calendar"
        },
        {
            type = "number",
            label = locale("inventory_slots"),
            description = locale("inventory_slots_description"),
            required = true,
            min = 1,
            default = sharedConfig.defaultSlots,
            max = sharedConfig.maxSlots,
            icon = "fa-box-open"
        },
        {
            type = "number",
            label = locale("inventory_weightlimit"),
            description = locale("inventory_weightlimit_description"),
            required = true,
            min = 1,
            default = sharedConfig.defaultWeight,
            max = sharedConfig.maxWeight,
            icon = "fa-weight-hanging"
        }
    })

    if not input then return end

    local coords = GetPointCoords()

    local storageData = {
        label = input[1],
        price = input[2],
        forever = input[3],
        blip = input[4],
        rental_days = input[5],
        coords = coords,
        inventory = {
            slots = input[6],
            weight = input[7]
        }
    }

    local success = lib.callback.await("nolag_storageunits:server:createStorage", 200, storageData)
    if success then
        Utils.Notify("storage_created_title", "success", 5000)
    else
        Utils.Notify("storage_created_error_title", "error", 5000)
    end
end

exports("createStorage", createStorageDialog)
