_G.flake8_setup_config_path = '/path/to/setup.cfg'
_G.test_cmd = "pytest -s -vv"
vim.g.python3_host_prog = 'path/to/venv/bin/python'
_G.pyproject_toml_path = 'pyproject.toml'

local auto_save_file_group = vim.api.nvim_create_augroup('AutoSavePyFileGroup', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    group = auto_save_file_group,
    callback = function()
        local file_name = vim.fn.expand('%:p')
        local file_extension = file_name:match("^.+(%..+)$")

        if file_extension == ".py" then
            vim.cmd("silent !ruff check --fix %")
            vim.cmd("silent !ruff format %")
        elseif file_extension == ".sql" then
            vim.cmd("!sqlformat --reindent --keywords upper --identifiers lower --indent_columns % -o %")
            vim.cmd("!echo '--- sqlformat FINISHED ---'")
        elseif file_extension == ".md" then
            -- error format required for the output of the command.
            vim.cmd("set errorformat+=%f:%l\\ %m")
            vim.cmd(table.concat({
                "cexpr ",
                "system('",
                "markdownlint ",
                vim.api.nvim_buf_get_name(0),
                "')"
            }, ""))
            vim.cmd("copen")
        else
            vim.api.nvim_command("lua vim.lsp.buf.format()")
        end
    end
})


local cwd = vim.fn.getcwd()

local env_name = function()
    -- local data_dir = cwd .. "path/to/env_file"
    return "Local Env"
end

_G.lualine_x_section = env_name


local function switchenv(_)
end

vim.api.nvim_create_user_command("SwitchEnv", switchenv, {
    nargs = '?',
    desc = "Command for switching between local and test env"
})

vim.keymap.set("n", "<leader>se", switchenv, { desc = "Switch Env" })


vim.api.nvim_create_user_command("Djshell", function(params)
    local host = ""
    local pwd = ""
    local database_name = ""
    local dbuser = ""

    local prompt = [[
        Enter your input:
        1. Prod
        2. Test
        3. Local Env
    ]]
    local user_input = vim.fn.input(prompt)

    local selected_env = user_input:match("^(%d+)")
    if selected_env == "1" then
        print("Using prod credentials")
        host = "<test_host>"
        pwd = "<test_pwd>"
    elseif selected_env == "2" then
        print("Using test credentials")
        host = "<test_host>"
        pwd = "<test_pwd>"
    end
    local cmd =
        " DATABASE_HOST=" .. host ..
        " DATABASE_NAME=" .. database_name ..
        " DATABASE_USER=" .. dbuser ..
        " DATABASE_PASSWORD=" .. pwd ..
        " ./src/manage.py shell_plus"
    cmd = ":split | terminal " .. cmd
    vim.cmd(cmd)
end, {
    nargs = '?',
    desc = 'Starts a django shell for given params'
})

