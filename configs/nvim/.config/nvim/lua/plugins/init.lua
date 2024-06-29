-- Refactor thislualine
local function clock()
  local time = tostring(os.date()):sub(12, 16)
  if os.time() % 2 == 1 then time = time:gsub(":", " ") end -- make the `:` blink
  return time
end
return {
  {
    name = "Python tests",
    dir = "custom.python_test",
    dev = true,
    event = "VeryLazy",
    config = function()
      require("custom.python_test").setup()
    end
  },
  -- "dense-analysis/ale",
  -- Command line git
  'tpope/vim-fugitive',
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sections = {
        lualine_x = { 'encoding', 'fileformat', 'filetype', clock },
      }
    },
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require("notify")
      notify.setup {
        render = "wrapped-compact",
      }
      vim.keymap.set("n", "<leader>nd", notify.dismiss, { desc = "Dismiss notification" })
    end
  },
  {
    'folke/neodev.nvim',
    opts = {
      library = {
        plugins = {
          "nvim-dap-ui"
        },
        types = true
      }
    },
  },
  {
    'numToStr/Comment.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup()
      local api = require("Comment.api")
      vim.keymap.set({ "n", "v" }, "<leader>/", api.toggle.linewise.current)
      vim.keymap.set({ "i" }, "<C-_>", api.toggle.linewise.current)
    end,
  }
}
