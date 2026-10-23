local meta = {
    name = "Template",
    description = "A template for new mods to work with the main bundler.",
    author = "Gugubo",
    version = "1.0",
}

local callbacks = {}
local local_options = {}


local function activate()
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
