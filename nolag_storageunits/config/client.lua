return {
    blipData = {
        sprite = 478,
        color = 0,
        scale = 0.6,
        display = 4,
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

    targetEnabled = true, -- Set to true if you want to enable the target system [only ox_target]
    storageInteractDistance = 1.25, -- The distance to interact with the storage [distance for ox_target and radius for the ox_lib zone if ox_target is not used]
}
