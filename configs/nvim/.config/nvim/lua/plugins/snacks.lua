local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
vim.api.nvim_create_autocmd("User", {
  pattern = "NvimTreeSetup",
  callback = function()
    local events = require("nvim-tree.api").events
    events.subscribe(events.Event.NodeRenamed, function(data)
      if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        data = data
        Snacks.rename.on_rename_file(data.old_name, data.new_name)
      end
    end)
  end,
})
return {

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      statuscolumn = { enabled = true },
      explorer = { enabled = true },
      picker = { enabled = true },
      indent = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      zen = { enabled = true },
      notifier = { enabled = true },
      bufdelete = { enabled = true },
      lazygit = { enabled = true },
      scroll = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
          { section = "startup" },
        },
      },
      terminal = {
        enabled = true,
        win = {
          -- style = 'terminal',
          -- position = 'float',
          border = 'single',
        },
        keys = {
          q = "hide",
          gf = function(self)
            local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
            if f == "" then
              Snacks.notify.warn("No file under cursor")
            else
              self:hide()
              vim.schedule(function()
                vim.cmd("e " .. f)
              end)
            end
          end,
          term_normal = {
            "<esc>",
            function(self)
              self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
              if self.esc_timer:is_active() then
                self.esc_timer:stop()
                vim.cmd("stopinsert")
              else
                self.esc_timer:start(200, 0, function() end)
                return "<esc>"
              end
            end,
            mode = "t",
            expr = true,
            desc = "Double escape to normal mode",
          },
        },
      },
      words = {
        enabled = true,
        debounce = 200,
        notify_jump = false,
        notify_end = true,
        foldopen = true,
        jumplist = true,
        modes = { 'n', 'v', 'i' },
      },
    },
    keys = {
      { '<leader>lg',      function() Snacks.lazygit() end,                                                                       desc = 'Lazygit', },
      { '<leader>gB',      function() Snacks.gitbrowse() end,                                                                     desc = 'Git Browse', },
      { '<leader>gf',      function() Snacks.lazygit.log_file() end,                                                              desc = 'Lazygit Current File History', },
      { '<leader>gl',      function() Snacks.lazygit.log() end,                                                                   desc = 'Lazygit Log (cwd)', },
      { '<leader>ot',      function() Snacks.terminal.toggle() end,                                                               desc = 'Toggle Terminal', },
      { '<leader>]]',      function() Snacks.words.jump(vim.v.count1) end,                                                        desc = 'Next Reference', },
      { '<leader>[[',      function() Snacks.words.jump(-vim.v.count1) end,                                                       desc = 'Prev Reference', },
      { '<leader>zz',      function() Snacks.zen.zen({ toggles = { dim = false }, }) end,                                         desc = 'Zen mode', },
      { '<leader>Z',       function() Snacks.zen.zoom() end,                                                                      desc = 'Zen zoom mode', },
      { '<leader>.',       function() Snacks.scratch() end,                                                                       desc = 'Open a scratch buffer', },
      { "<leader>S",       function() Snacks.scratch.select() end,                                                                desc = "Select Scratch Buffer" },
      { "<leader>,",       function() Snacks.picker.buffers() end,                                                                desc = "Buffers" },
      { "<leader>:",       function() Snacks.picker.command_history() end,                                                        desc = "Command History" },
      { "<leader>nh",      function() Snacks.picker.notifications() end,                                                          desc = "Notification History" },
      { "<leader><space>", function() Snacks.explorer({ hidden = true }) end,                                                     desc = "File Explorer" },
      -- find
      { "<leader>fc",      function() Snacks.picker.files({ hidden = true, ignored = true, cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff",      function() Snacks.picker.files({ hidden = true, ignored = true, exclude = { "__pycache__", ".git" } }) end,    desc = "Find Files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                                                              desc = "Find Git Files" },
      { "<leader>fp",      function() Snacks.picker.projects() end,                                                               desc = "Projects" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                                                                 desc = "Recent" },
      -- Grep
      { "<leader>sb",      function() Snacks.picker.lines() end,                                                                  desc = "Buffer Lines" },
      { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                                                           desc = "Grep Open Buffers" },
      { "<leader>fg",      function() Snacks.picker.grep() end,                                                                   desc = "Grep" },
      { "<leader>ft",      function() Snacks.picker.grep({ title = "Grep in tests", cwd = vim.fn.getcwd() .. '/src/tests' }) end, desc = "Grep" },
      { "<leader>fw",      function() Snacks.picker.grep_word() end,                                                              desc = "Visual selection or word",     mode = { "n", "x" } },
      -- search
      { '<leader>s"',      function() Snacks.picker.registers() end,                                                              desc = "Registers" },
      { '<leader>s/',      function() Snacks.picker.search_history() end,                                                         desc = "Search History" },
      { "<leader>sa",      function() Snacks.picker.autocmds() end,                                                               desc = "Autocmds" },
      { "<leader>sb",      function() Snacks.picker.lines() end,                                                                  desc = "Buffer Lines" },
      { "<leader>sc",      function() Snacks.picker.command_history() end,                                                        desc = "Command History" },
      { "<leader>sC",      function() Snacks.picker.commands() end,                                                               desc = "Commands" },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,                                                            desc = "Diagnostics" },
      { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                                                     desc = "Buffer Diagnostics" },
      { "<leader>sh",      function() Snacks.picker.help() end,                                                                   desc = "Help Pages" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,                                                             desc = "Highlights" },
      { "<leader>si",      function() Snacks.picker.icons() end,                                                                  desc = "Icons" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,                                                                  desc = "Jumps" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,                                                                desc = "Keymaps" },
      { "<leader>sl",      function() Snacks.picker.loclist() end,                                                                desc = "Location List" },
      { "<leader>sm",      function() Snacks.picker.marks() end,                                                                  desc = "Marks" },
      { "<leader>sM",      function() Snacks.picker.man() end,                                                                    desc = "Man Pages" },
      { "<leader>sp",      function() Snacks.picker.lazy() end,                                                                   desc = "Search for Plugin Spec" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,                                                                 desc = "Quickfix List" },
      { "<leader>sR",      function() Snacks.picker.resume() end,                                                                 desc = "Resume" },
      { "<leader>su",      function() Snacks.picker.undo() end,                                                                   desc = "Undo History" },
      { "<leader>lc",      function() Snacks.picker.colorschemes() end,                                                           desc = "Colorschemes" },
      -- LSP
      { "gd",              function() Snacks.picker.lsp_definitions({ auto_confirm = false, }) end,                               desc = "Goto Definition" },
      { "gD",              function() Snacks.picker.lsp_declarations() end,                                                       desc = "Goto Declaration" },
      { "gr",              function() Snacks.picker.lsp_references() end,                                                         nowait = true,                         desc = "References" },
      { "gI",              function() Snacks.picker.lsp_implementations() end,                                                    desc = "Goto Implementation" },
      { "gy",              function() Snacks.picker.lsp_type_definitions() end,                                                   desc = "Goto T[y]pe Definition" },
      { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                                                            desc = "LSP Symbols" },
      { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                                                  desc = "LSP Workspace Symbols" },
    },
  },
}
