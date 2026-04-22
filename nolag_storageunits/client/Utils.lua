local clientConfig = lib.load("config.client")

Utils = {}

local keybindCallback = nil

PrimaryKeybind = lib.addKeybind({
    name = "+storage_interact",
    description = locale("keybind_description"),
    defaultKey = clientConfig.keybinds.interact,
    onPressed = function(self)
        if keybindCallback then
            keybindCallback()
        end
    end
})

function Utils.Notify(key, type, time)
    Notify({
        message = locale(key),
        type = type,
        time = time
    })
end

function Utils.CreateMenuOption(title, description, icon, onSelect, metadata, arrow)
    if string.sub(title, 1, 7) == "locale_" then
        local translated = locale(string.sub(title, 8))
        if translated then
            title = translated
        end
    end

    if description then
        if string.sub(description, 1, 7) == "locale_" then
            local translated = locale(string.sub(description, 8))
            if translated then
                description = translated
            end
        end
    end

    return {
        title = title,
        description = description,
        icon = icon,
        onSelect = onSelect,
        metadata = metadata,
        arrow = arrow
    }
end

function Utils.AddInteraction(text, callback)
    keybindCallback = callback
    ShowTextUI(text)
end

function Utils.RemoveInteraction()
    keybindCallback = nil
    HideTextUI()
end

function Utils.FormatDateTime(value)
    if not value then
        return "N/A"
    end

    local function isLeapYear(year)
        local mod = year % 4
        if mod == 0 then
            mod = year % 100
        end
        return mod ~= 0
    end

    local function daysInYear(year)
        if isLeapYear(year) then
            return 366
        end
        return 365
    end

    local monthDays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

    local function getMonthDays(year, month)
        if month == 2 then
            if isLeapYear(year) then
                return 29
            end
        end
        return monthDays[month]
    end

    local function timestampToDateTime(ts)
        ts = math.floor(tonumber(ts) or 0)
        if ts < 0 then ts = 0 end

        local days = math.floor(ts / 86400)
        local secs = ts % 86400
        local year = 1970

        while days >= daysInYear(year) do
            days = days - daysInYear(year)
            year = year + 1
        end

        local month = 1
        while days >= getMonthDays(year, month) do
            days = days - getMonthDays(year, month)
            month = month + 1
        end

        local day = days + 1
        local hour = math.floor(secs / 3600)
        secs = secs % 3600
        local min = math.floor(secs / 60)
        local sec = secs % 60

        return string.format("%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, min, sec)
    end

    local t = type(value)

    if t == "string" then
        if value:match("^%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d$") then
            return value
        end
        local num = tonumber(value)
        if num then
            if #value >= 13 then
                return timestampToDateTime(math.floor(num / 1000))
            else
                return timestampToDateTime(num)
            end
        end
        return value
    elseif t == "number" then
        if value > 100000000000 then
            return timestampToDateTime(math.floor(value / 1000))
        else
            return timestampToDateTime(value)
        end
    end

    return tostring(value)
end

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= cache.resource then return end
    if keybindCallback then
        HideTextUI()
    end
end)
