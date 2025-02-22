-- [[
-- Script to test Python code.
-- Run one of the following user commands:
--   * :TestFunction
--   * :TestClass
--   * :TestFile
-- ]]


local M = {}

function M.setup()
  local map = vim.keymap.set
  map("n", "<leader>tcf", ":TestFile<CR>", { desc = "Run tests for the file" })
  map("n", "<leader>tcc", ":TestClass<CR>", { desc = "Run tests for the Class" })
  map("n", "<leader>tcn", ":TestFunction<CR>", { desc = "Run tests for the function" })

  local ts_utils = require('nvim-treesitter.ts_utils')

  local function run_test_cmd(cmd)
    cmd = ":split | terminal " .. cmd
    vim.cmd(cmd)
  end

  local function get_parent_node_by_type(current_node, type, err_on_nil)
    local parent = current_node

    while parent do
      if parent:type() == type then
        return parent
      end
      parent = parent:parent()
    end

    if err_on_nil then
      error("Not inside a " .. type .. "!!!")
    end
  end

  local function get_current_node()
    local current_node = ts_utils.get_node_at_cursor()
    if not current_node then
      error("Invalid node under cursor")
    end
    return current_node
  end

  local function build_test_cmd_from_suffix_and_args(suffix, args)
    return table.concat({
      _G.test_cmd,
      args,
      vim.fn.expand("%") .. suffix,
    }, " ")
  end

  local function test_function(opts)
    local current_node = get_current_node()

    local parent_function = get_parent_node_by_type(
      current_node, "function_definition", true
    )
    -- By default, function name will be present at location 1 but for async functions it will be at location 2
    local loc = 1
    if vim.treesitter.get_node_text(parent_function:child(0), 0) == 'async' then
      loc = 2
    end
    local function_name = vim.treesitter.get_node_text(
      parent_function:child(loc), 0
    )

    local parent_class = get_parent_node_by_type(
      parent_function, "class_definition", false
    )

    local test_suffix
    if not parent_class then
      test_suffix = "::" .. function_name
    else
      local class_name = vim.treesitter.get_node_text(
        parent_class:child(1), 0
      )
      test_suffix = "::" .. class_name .. "::" .. function_name
    end

    local cmd = build_test_cmd_from_suffix_and_args(test_suffix, opts.args)
    run_test_cmd(cmd)
  end

  local function test_class(opts)
    local current_node = get_current_node()

    local parent_class = get_parent_node_by_type(
      current_node, "class_definition", true
    )
    local class_name = vim.treesitter.get_node_text(
      parent_class:child(1), 0
    )
    print(class_name)
    local test_suffix = "::" .. class_name

    local cmd = build_test_cmd_from_suffix_and_args(test_suffix, opts.args)
    run_test_cmd(cmd)
  end

  local function test_file(opts)
    local cmd = build_test_cmd_from_suffix_and_args("", opts.args)
    run_test_cmd(cmd)
  end

  vim.api.nvim_create_user_command("TestFunction", test_function, {
    -- Zero or one arguments are accepted
    nargs = "?",
    -- Can't be used in visual mode too.
    range = false,
  })
  vim.api.nvim_create_user_command("TestClass", test_class, {
    -- Zero or one arguments are accepted
    nargs = "?",
    -- Can't be used in visual mode too.
    range = false,
  })
  vim.api.nvim_create_user_command("TestFile", test_file, {
    -- Zero or one arguments are accepted
    nargs = "?",
    -- Can't be used in visual mode too.
    range = false,
  })
end

return M
