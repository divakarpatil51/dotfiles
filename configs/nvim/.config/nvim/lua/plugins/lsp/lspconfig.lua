return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    'folke/neodev.nvim',
    'j-hui/fidget.nvim',
  },
  config = function()
    local lspconfig = require("lspconfig")

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

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
        vim.notify("Searching for references...", "info", { title = "LSP" })
        vim.cmd("Telescope lsp_references")
      end, opts)

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>vsplit | Telescope lsp_definitions<CR>", opts)

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>vsplit | Telescope lsp_implementations<CR>", opts)

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>vsplit | Telescope lsp_type_definitions<CR>", opts)

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
      if client.name == 'ruff_lsp' then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
      end
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

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

    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pyright = {
          disableOrganizeImports = true, -- Using Ruff
        },
        python = {
          analysis = {
            ignore = { '*' },         -- Using Ruff
            typeCheckingMode = 'off', -- Using mypy
          },
          pythonPath = vim.g.python3_host_prog,
        },
      },
    })
    lspconfig.ruff_lsp.setup {
      init_options = {
        settings = {
          args = {
            config = _G.pyproject_toml_path,
          },
        }
      }
    }
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
