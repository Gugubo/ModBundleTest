meta = {
    name = 'Mod Bundle Test',
    version = "WIP",
    description = 'Test bundling and choosing between multiple mods',
    author = 'Gugubo',
}

local mod_paths = {
    "mods/teleport_challenge/tele",
    "mods/temple_start/main",
    "mods/template/main"
}
local mods = {}
local mod_names = {}

local active_mod = nil


local function load_mods()
    for _, path in ipairs(mod_paths) do
        mods[path] = require(path)
    end
    for _, path in ipairs(mod_paths) do
        table.insert(mod_names, mods[path].meta.name)
    end
end


local function deactivate_active_mod()
    if active_mod ~= nil then
        active_mod.deactivate()
    end
end

local function activate_mod()
    -- Deactivate current
    deactivate_active_mod()

    -- Activate new one
    local new_selected_mod_path = mod_paths[options.selected_mod_index]
    active_mod = mods[new_selected_mod_path]
    active_mod.activate()

    prinspect("Loaded " .. active_mod.meta.name .. " from " .. new_selected_mod_path)
end


-- Load all mods, once on startup
load_mods()

-- Register options
register_option_combo("selected_mod_index", "Select a mod", "", table.concat(mod_names, "\0") .. "\0\0", 1)
register_option_button("activate_mod", "Activate selected mod", "", activate_mod)
register_option_button("deactivate_mod", "Deactivate active mod", "", deactivate_active_mod)
