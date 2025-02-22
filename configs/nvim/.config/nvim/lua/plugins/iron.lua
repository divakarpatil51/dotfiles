return {
  "Vigemus/iron.nvim",
  event = { "BufReadPre" },
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")
    iron.setup {
      config = {
        preferred = {
          python = "ipython",
        },
        repl_open_cmd = view.bottom(40),
      },

      keymaps = {
        toggle_repl = "<space>ro", -- toggles the repl open and closed.
        restart_repl = "<space>rr" -- calls `IronRestart` to restart the repl
      }
    }
    -- vim.keymap.set('n', '<space>ro', '<cmd>IronRepl<cr>')
    -- vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
    vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
    -- vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
  end
}
