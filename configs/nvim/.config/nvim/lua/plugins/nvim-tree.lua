return {

  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local nvimtree = require("nvim-tree")
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- Set Keymaps
    local map = vim.keymap.set
    local api = require("nvim-tree.api")
    map('n', '<leader>tt', api.tree.toggle, { desc = 'Toggle tree' })
    map('n', '<leader>tr', api.tree.reload, { desc = 'refresh tree' })
    map('n', '<leader>tf', api.tree.focus, { desc = 'Focus tree' })
    map('n', '<leader>tcp', api.fs.copy.relative_path, { desc = 'Copy relative path' })

    nvimtree.setup({
      disable_netrw = true,
      hijack_netrw = true,
      -- filters = {
      --   -- custom = { ".git" },
      -- },
      sync_root_with_cwd = true,
      hijack_cursor = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      git = {
        enable = false,
        -- ignore = true,
        -- timeout = 700,
      },
      filesystem_watchers = {
        enable = false,
        -- debounce_delay = 500,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      log = {
        enable = true,
        types = {
          all = true,
          diagnostics = true,
        }
      },
      renderer = {
        root_folder_label = false,
        -- highlight_git = true,
        highlight_opened_files = "icon",
        indent_markers = {
          enable = false,
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            -- git = true,
          },
          glyphs = {
            default = "󰈚",
            symlink = "",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
              symlink_open = "",
              arrow_open = "",
              arrow_closed = "",
            },
            -- git = {
            --   unstaged = "✗",
            --   staged = "✓",
            --   unmerged = "",
            --   renamed = "➜",
            --   untracked = "★",
            --   deleted = "",
            --   ignored = "◌",
            -- -- },
          },
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
    })
  end,
}
