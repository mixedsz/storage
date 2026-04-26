return {
    blipData = {
        owner = {
            sprite = 478,
            color = 2,
            scale = 0.6,
            display = 4,
            enabled = true,
            category = 57,
        },
        owned = {
            sprite = 478,
            color = 1,
            scale = 0.6,
            display = 4,
            enabled = true,
            category = 56,
        },
        unowned = {
            sprite = 478,
            color = 0,
            scale = 0.6,
            display = 4,
            enabled = true,
            category = 58,
        },
        expired = {
            sprite = 478,
            color = 6,
            scale = 0.6,
            display = 4,
            enabled = true,
            category = 59,
        },
    },

    RaidProperty = function()
        local result = false

        local success = lib.skillCheck({ 'easy', 'easy' }, { 'w', 'a', 's', 'd' })
        if success then
            success = lib.progressCircle({
                duration = math.random(10000, 20000),
                label = 'Breaching the storage..',
                disable = {
                    car = true,
                    combat = true,
                    move = true
                },
                anim = {
                    dict = "missheistfbi3b_ig7",
                    clip = 'lift_fibagent_loop'
                }
            })
            if success then
                result = true
            end
        end

        return result
    end,

    keybinds = {
        interact = 'E',
    },

    targetEnabled = false,
    storageInteractDistance = 1.25,

    markerConfig = {
        enabled = true,
        type = 1,           -- 1 = upward cylinder
        sizeX = 0.8,
        sizeY = 0.8,
        sizeZ = 0.5,
        r = 30,
        g = 100,
        b = 255,
        a = 120,
        renderDistance = 15.0,
    },
}
