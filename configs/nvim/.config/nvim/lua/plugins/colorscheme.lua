return {
  {
    "rose-pine/neovim",
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function()
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
  {
    'navarasu/onedark.nvim',
    priority = 999,
    config = function()
      vim.cmd.colorscheme 'onedark'
      require("onedark").setup {
        -- transparent = true,
        -- -- style = "darker",
        -- toggle_style_key = "<leader>ts",                                                     -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        -- toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between
        -- styles = {
        --   sidebars = "transparent",
        --   floats = "transparent",
        -- },
      }
      require('onedark').load()
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority=10,
    config = function()
      vim.cmd.colorscheme 'kanagawa'
    end
  }
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 10,
  --   config = function()
  --     vim.cmd([[colorscheme tokyonight-night]])
  --   end,
  -- },
  -- {
  --   "bluz71/vim-nightfly-guicolors",
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     vim.cmd([[colorscheme nightfly]])
  --   end,
  -- },
}
