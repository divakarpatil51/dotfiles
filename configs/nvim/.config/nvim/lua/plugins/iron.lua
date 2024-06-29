return {
  "Vigemus/iron.nvim",
  config = function()
    local iron = require("iron.core")
    iron.setup {
      config = {
        preferred = {
          python = "ipython",
        }
      }
    }
    vim.keymap.set('n', '<space>ro', '<cmd>IronRepl<cr>')
    vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
    vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
    vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
  end
}
