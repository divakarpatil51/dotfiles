return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
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

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add to harpoon list" })
    vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end, { desc = "Remove from harpoon list" })
    vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end, { desc = "Clear harpoon list" })
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Move to next loc in harpoon list" })
    vim.keymap.set("n", "<leader>hb", function() harpoon:list():prev() end, { desc = "Move to prev loc in harpoon list" })
    vim.keymap.set("n", "<leader>hm", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon list" })
  end
}
