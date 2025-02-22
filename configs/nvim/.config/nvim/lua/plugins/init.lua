-- Refactor thislualine
local function clock()
  local time = tostring(os.date()):sub(12, 16)
  if os.time() % 2 == 1 then time = time:gsub(":", " ") end -- make the `:` blink
  return time
end


return {
  -- Command line git
  { "tpope/vim-fugitive",    event = "VeryLazy" },
  -- rhubarb.vim is the Hub.
  { "tpope/vim-rhubarb",     event = "VeryLazy" },
  -- Detect tabstop and shiftwidth automatically
  { "tpope/vim-sleuth",      event = "VeryLazy" },
  { "nvim-lua/plenary.nvim", event = "VeryLazy" },

  "nvim-tree/nvim-web-devicons",

  {
    name = "local_plugins",
    dir = "~/.config/nvim/lua/custom",
    dev = { true },
    event = "VeryLazy",
    -- opts ={}
    config = function()
      require("custom.python_test").setup()
      require("custom.reminders").setup()
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "BufReadPre",
    config = function()
      require("lualine").setup({
        sections = {
          lualine_x = { _G.lualine_x_section or "", 'encoding', 'fileformat', 'filetype', clock },
        }
      })
    end
  },
  {
    'rcarriga/nvim-notify',
    lazy = true,
    config = function()
      local notify = require("notify")
      notify.setup {
        render = "wrapped-compact",
        merge_duplicates = true,
      }
      vim.keymap.set("n", "<leader>nd", notify.dismiss, { desc = "Dismiss notification" })
    end
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
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    cmd = 'LazyDev',
    opts = {
      library = {
        { path = 'snacks.nvim', words = { 'Snacks' } },
      },
    },
  },

}
