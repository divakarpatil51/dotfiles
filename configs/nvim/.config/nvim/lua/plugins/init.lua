-- Refactor thislualine
local function clock()
	local time = tostring(os.date()):sub(12, 16)
	if os.time() % 2 == 1 then time = time:gsub(":", " ") end -- make the `:` blink
	return time
end
return {
	-- Command line git
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			if vim.fn.filereadable(vim.fn.getcwd() .. "/.nvim.lua") == 1 then
				-- Doesn't look like good practice to use dofile, but it works for now
				dofile(vim.fn.getcwd() .. "/.nvim.lua")
			end
			require("lualine").setup({
				sections = {
					lualine_x = { _G.lualine_x_section or "", 'encoding', 'fileformat', 'filetype', clock },
				}
			})
		end
	},
	{
		'rcarriga/nvim-notify',
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
	-----------------------------------------------------------------------------
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
