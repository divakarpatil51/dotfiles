local Options = {
    standup_interval = 60 * 60 * 1000,  -- Show standup popup every hour
    definitions_interval = 15 * 60 * 1000 -- Show definitions popup every 15 mins
}

local standup_timer = vim.loop.new_timer()
local definition_timer = vim.loop.new_timer()

local has_notify, notify = pcall(require, "notify")
if has_notify then
    vim.notify = notify
end

local function is_within_working_hours()
    local current_time = tonumber(vim.fn.strftime("%H"))
    return current_time >= 9 and current_time <= 18
end

-- Standup timer callback
local function on_standup_timer()
    if not is_within_working_hours() then
        return
    end

    vim.notify("⏰ Time to stand", vim.log.levels.WARN, {
        title = "stand.nvim",
        render = "minimal",
        timeout = false,
        on_open = function()
            standup_timer:stop()
        end,
        on_close = function()
            standup_timer:again()
        end,
    })
end

-- Start standup timer
standup_timer:start(Options.standup_interval, Options.standup_interval, vim.schedule_wrap(on_standup_timer))

local function read_json_file(file_path)
    local file, err = io.open(file_path, "r")
    if not file then
        return nil, "Error opening file: " .. (err or "unknown error")
    end

    local content = file:read("*a")
    file:close()

    local ok, decoded = pcall(vim.json.decode, content)
    if not ok then
        return nil, "Error decoding JSON: " .. (decoded or "unknown error")
    end

    return decoded
end

local file_path = string.sub(debug.getinfo(1).source:match("(.*[/\\])"), 2) .. "definitions.json"
local definitions, err = read_json_file(file_path)
if not definitions then
    vim.print("Error occurred while reading file: " .. (err or "unknown error"))
    return
end

Options.definitions = definitions
Options.def = {}
for k in pairs(definitions) do
    table.insert(Options.def, k)
end
Options.definition_counts = #Options.def
local is_enabled = true

-- Definitions timer callback
local function on_definition_timer()
    if not is_within_working_hours() or not is_enabled then
        return
    end


    local curr_idx = math.random(Options.definition_counts)
    local word = Options.def[curr_idx]
    -- local line = "---------------------\n"
    local definition = Options.definitions[word]

    vim.notify(definition, vim.log.levels.WARN, {
        title = word,
        timeout = false,
        on_open = function()
            definition_timer:stop()
        end,
        on_close = function()
            definition_timer:again()
        end,
    })
end

-- Start definitions timer
definition_timer:start(Options.definitions_interval, Options.definitions_interval, vim.schedule_wrap(on_definition_timer))

vim.api.nvim_create_user_command("StopNotifications", function()
    vim.print("Stopping notifications")
    is_enabled = false
    definition_timer:stop()
end, {
    desc = "stop notifications"
})

vim.api.nvim_create_user_command("StartNotifications", function()
    is_enabled = true
    definition_timer:again()
end, {
    desc = "start notifications"
})
