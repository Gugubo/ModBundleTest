local meta = {
    name = "Teleport Every Second",
    description = "Teleports you every second",
    author = "Idea: Back air/Bair, Code Update: Gugubo",
    version = "2.1",
}

local callbacks = {}
local local_options = { "tele_frames_between_teleport", "tele_min", "tele_max" }

local function add_tele_callback()
    callbacks[#callbacks + 1] = set_interval(function()
        for i, player in ipairs(players) do
            if player and player.state ~= CHAR_STATE.ENTERING then
                local distance = math.random(options.tele_min, options.tele_max)

                local input = player.input.buttons_gameplay
                if input & INPUTS.UP ~= 0 then
                    player:perform_teleport(0, distance)
                elseif input & INPUTS.DOWN ~= 0 then
                    player:perform_teleport(0, -distance)
                else
                    local is_facing_left = test_flag(player.flags, ENT_FLAG.FACING_LEFT)
                    local dir = is_facing_left and -1 or 1 --1 if facing right, -1 if facing left
                    player:perform_teleport(distance * dir, 0)
                end
            end
        end
    end, options.tele_frames_between_teleport)
end

local function activate()
    register_option_int("tele_frames_between_teleport", "Number of frames betwen teleports", "", 60, 20, 22 * 60)
    register_option_int("tele_min", "Min teleport distance", "", 4, 0, 8)
    register_option_int("tele_max", "Max teleport distance", "", 8, 4, 12)

    add_tele_callback()
    callbacks[#callbacks + 1] = set_callback(add_tele_callback, ON.LEVEL)
end

local function deactivate()
    -- Clear callbacks
    for _, callback in ipairs(callbacks) do
        clear_callback(callback)
    end

    -- Unregister options
    for _, option in ipairs(local_options) do
        unregister_option(option)
    end
end

return { meta = meta, activate = activate, deactivate = deactivate }
