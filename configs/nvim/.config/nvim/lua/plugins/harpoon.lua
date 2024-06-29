return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
      opts = {
        global_settings = {
          tabline_prefix = "   ",
          tabline_suffix = "   ",
          tabline = true,
        },
        menu = {
          width = vim.api.nvim_win_get_width(0) - 20,
        }
      }
    })

    -- telescope integration is good but not able to find how to delete a mark
    -- local conf = require("telescope.config").values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require("telescope.pickers").new({}, {
    --     prompt_title = "Harpoon",
    --     finder = require("telescope.finders").new_table({
    --       results = file_paths,
    --     }),
    --     previewer = conf.file_previewer({}),
    --     sorter = conf.generic_sorter({}),
    --   }):find()
    -- end
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { desc = "Append to harpoon list" })
    vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end, { desc = "Clear harpoon list" })
    -- vim.keymap.set("n", "<leader>hm", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon list" })
    vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Open harpoon list" })
  end
}
