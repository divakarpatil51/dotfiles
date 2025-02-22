return {
	'saghen/blink.cmp',
	event = "InsertEnter",
	version = '*',
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			lazy = true,
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/plugins/snippets" } })
			end,
		},
	},
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = {
			preset = 'enter',
			["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			cmdline = {
				preset = 'enter',
			},
		},
		snippets = {
			preset = "luasnip",
		},
		appearance = {
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono'
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},
	},
	opts_extend = { "sources.default" }
}
