local meta = {
    name = "TempleStart",
    version = "1.0",
    author = "Gugubo",
    description = "Restart runs in Temple"
}

-- Does not work on first start, only on reset

local function set_start_area_to_temple()
    state.world_start = 4
    state.theme_start = THEME.TEMPLE
    state.world_next = 4
    state.theme_next = THEME.TEMPLE
end

local function reset_start_area()
    state.world_start = 1
    state.theme_start = THEME.DWELLING
    state.world_next = 1
    state.theme_next = THEME.DWELLING
end


local function activate()
    set_start_area_to_temple()
end

local function deactivate()
    reset_start_area()
end

return { meta = meta, activate = activate, deactivate = deactivate }
