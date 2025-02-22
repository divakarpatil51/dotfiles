return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- { "hrsh7th/cmp-nvim-lsp", lazy = true, event = { "BufReadPre", "BufNewFile" }, },
    { "saghen/blink.cmp", lazy = true, event = { "BufReadPre", "BufNewFile" }, },
    { "folke/neodev.nvim",    lazy = true, event = { "BufReadPre", "BufNewFile" }, },
    { "j-hui/fidget.nvim",    lazy = true, event = { "BufReadPre", "BufNewFile" }, },
  },
  config = function()
    local lspconfig = require("lspconfig")

    -- local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local cmp_nvim_lsp = require("blink.cmp")

    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }

    local on_attach = function(client, bufnr)
      if string.match(vim.api.nvim_buf_get_name(0), "/site-packages/") then
        return
      end
      if string.match(vim.api.nvim_buf_get_name(0), "/lib/python") then
        return
      end
      opts.buffer = bufnr

      opts.desc = "Show LSP references"
      keymap.set("n", "gr", function()
        vim.cmd("Telescope lsp_references")
      end, opts)


      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      -- opts.desc = "Show buffer diagnostics"
      -- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
      if client.name == 'ruff' then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
      end
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.get_lsp_capabilities()

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    --
    --   -- configure html server
    --   lspconfig["html"].setup({
    --     capabilities = capabilities,
    --     on_attach = on_attach,
    --   })
    --
    -- configure pylsp server with plugin
    -- Remember this needs to be set per project to use project specific config
    if vim.fn.filereadable(vim.fn.getcwd() .. "/.nvim.lua") == 1 then
      -- Doesn't look like good practice to use dofile, but it works for now
      dofile(vim.fn.getcwd() .. "/.nvim.lua")
    end

    lspconfig.gopls.setup {
      capabilities = capabilities,
      -- Optionally disable certain features if you need more performance
      on_attach = on_attach,
    }
    lspconfig.basedpyright.setup({
      settings = {
        python = {
          analysis = {
            -- Use new type analyzer (more accurate)
            typeCheckingMode = "standard",
            -- Cache analysis results
            useLibraryCodeForTypes = true,
            autoSearchPaths = true,
            -- Performance settings
            diagnosticMode = "openFilesOnly",
            maxImportDepth = 5,
            -- Customize diagnostics
            diagnosticSeverityOverrides = {
              -- Optionally downgrade some diagnostics
              reportUnusedImport = "none",
              reportUnusedVariable = "none",
              reportGeneralTypeIssues = "none",
              reportOptionalMemberAccess = "none",
              reportOptionalSubscript = "none",
              reportPrivateImportUsage = "none",
              reportAttributeAccessIssue = "none",
              reportIncompatibleVariableOverride = "none",
              -- reportTypedDictNotRequiredAccess = "warning",
            },
            -- Ignore specific directories
            exclude = {
              '**/__pycache__',
              '**/node_modules',
              '.env',
              'venv',
              '.venv',
              'env',
              "**/.vscode",
              "**/.git",
              "**/.mypy_cache",
              "**/.pytest_cache",
              "**/.tox",
              "**/htmlcov",
              "**/*.egg-info",
              "**/migrations",
            },
          },
        },
      },
      -- Improve responsiveness
      flags = {
        debounce_text_changes = 150,
      },
      capabilities = capabilities,
      -- Optionally disable certain features if you need more performance
      on_attach = on_attach,
    })
    -- lspconfig.pyright.setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   settings = {
    --     pyright = {
    --       disableOrganizeImports = true, -- Using Ruff
    --       python = {
    --         analysis = {
    --           ignore = { '*' }, -- Using Ruff
    --           autoSearchPaths = false,
    --           useLibraryCodeForTypes = false,
    --           diagnosticMode = "openFilesOnly",
    --           diagnosticSeverityOverrides = {
    --             reportGeneralTypeIssues = "none",
    --             reportOptionalMemberAccess = "none",
    --             reportOptionalSubscript = "none",
    --             reportPrivateImportUsage = "none",
    --             reportAttributeAccessIssue = "none",
    --             reportIncompatibleVariableOverride = "none",
    --             -- reportTypedDictNotRequiredAccess = "warning",
    --           },
    --           autoImportCompletions = false,
    --           typeCheckingMode = 'off', -- Using mypy
    --         },
    --       },
    --       pythonPath = vim.g.python3_host_prog,
    --     },
    --   },
    -- })
    lspconfig.ruff.setup {
      init_options = {
        settings = {
          args = {
            config = _G.pyproject_toml_path,
          },
        }
      }
    }

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      update_in_insert = false, -- Disable diagnostics while typing
      underline = true,         -- Underline the errors
      virtual_text = false,     -- Disable inline error text
    })
    -- lspconfig["pylsp"].setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   settings = {
    --     pylsp = {
    --       plugins = {
    --         noy_pyls = { enabled = true },
    --         pydocstyle = { enabled = false },
    --         pycodestyle = { enabled = false },
    --         pyflakes = { enabled = false },
    --         -- flake8 = {
    --         --   enabled = true,
    --         --   config = _G.flake8_setup_config_path or ""
    --         --   -- ignore = { "D103", "D101", "D102", "D100", "D401", "E501" }
    --         -- },
    --         mccabe = { enabled = false },
    --         pylint = { enabled = false },
    --         yapf = { enabled = false },
    --         pyls_isort = { enabled = false },
    --         pylama = { enabled = true },
    --         -- pylsp_mypy = { enabled = false, dmypy = true, live_mode = false },
    --         jedi_completion = { include_params = true, },
    --         jedi_hover = { enabled = true },
    --         jedi_signature_help = { enabled = true },
    --         jedi_symbols = { enabled = true },
    --         ruff = {
    --           enabled = true,
    --           extendSelect = { "I" },
    --           format = { "I" },
    --           config = _G.flake8_setup_config_path
    --         },
    --       }
    --     }
    --   }
    -- })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim", "require" },
          },
        },
      },
    })
  end,
}
