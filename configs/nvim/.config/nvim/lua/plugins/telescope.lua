return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "nvim-tree/nvim-web-devicons",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules", "__pycache__" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = {
            ["q"] = require("telescope.actions").close,
          },
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
      extensions_list = { "themes", "terms", "fzf" },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })


    telescope.load_extension("fzf")

    local map = vim.keymap.set

    local telescopeBuiltin = require("telescope.builtin")

    map('n', '<leader>ff', telescopeBuiltin.find_files, { desc = 'Find Files' })
    map('n', '<leader>fa', function()
      telescopeBuiltin.find_files({ follow = true, hidden = true, no_ignore = true })
    end, { desc = 'Find All' })
    map('n', '<leader>ft', function()
      local cwd_with_tests = vim.fn.getcwd() .. '/src/tests'
      telescopeBuiltin.live_grep({ cwd = cwd_with_tests })
    end, { desc = 'Find in tests' })
    map('n', '<leader>fg', function()
      local live_grep_in_glob = function(glob_pattern)
        telescopeBuiltin.live_grep({
          prompt_title="Searching in glob pattern: " .. (glob_pattern or "All files"),
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--glob=" .. (glob_pattern or ""),
          }
        }
        )
      end
      vim.ui.input({ prompt = "Glob: ", completion = "file", default = "**/*." }, live_grep_in_glob)
    end, { desc = 'Find in glob' })

    -- map('n', '<leader>fh', telescopeBuiltin.help_tags, { desc = 'Help Page' })
    map('n', '<leader>fs', telescopeBuiltin.grep_string, { desc = 'Find current string' })
    map('n', '<leader>fw', telescopeBuiltin.live_grep, { desc = 'Find by Grep' })
    map('n', '<leader>fd', telescopeBuiltin.diagnostics, { desc = 'Search Diagnostics' })
    map('n', '<leader>fr', telescopeBuiltin.resume, { desc = 'Find Resume' })
    map('n', '<leader>fo', telescopeBuiltin.oldfiles, { desc = 'Find recently opened files' })
    map('n', '<leader>fb', telescopeBuiltin.buffers, { desc = 'Find existing buffers' })
    map('n', '<leader>fz', function()
      telescopeBuiltin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'Fuzzily search in current buffer' })

    -- List objects
    map('n', '<leader>lf', telescopeBuiltin.lsp_document_symbols, { desc = 'List Functions, Variables in the file.' })
    map('n', '<leader>lr', telescopeBuiltin.registers, { desc = 'List registers' })
    map('n', '<leader>lc', telescopeBuiltin.colorscheme, { desc = 'List color schemes' })
    map('n', '<leader>lq', telescopeBuiltin.quickfix, { desc = 'List quickfix' })
    map('n', '<leader>lk', telescopeBuiltin.keymaps, { desc = 'List keymaps' })
    map('n', '<leader>lm', telescopeBuiltin.marks, { desc = 'List Bookmarks' })
    map('n', '<leader>lv', telescopeBuiltin.vim_options, { desc = 'List Bookmarks' })
    map('n', '<leader>lt', telescopeBuiltin.filetypes, { desc = 'List Bookmarks' })
  end
}
