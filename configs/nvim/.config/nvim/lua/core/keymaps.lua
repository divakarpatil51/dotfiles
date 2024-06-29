local map = vim.keymap.set

--
map("n", "<leader>pv", vim.cmd.Ex)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("x", "<leader>p", [["_dP]])
map({"n", "v"}, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map({"n", "v"}, "<leader>d", [["_d]])
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("i", "\"", "\"\"<ESC>ha")
map("i", "'", "''<ESC>ha")
map("i", "[", "[]<ESC>ha")
map("i", "(", "()<ESC>ha")

-- Insert Mode Mappings
map("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line in insert mode" })
map("i", "<C-e>", "<End>", { desc = "End of line in insert mode" })
map("i", "jj", "<ESC>", { desc = "Escape insert mode" })

map("i", "<C-h>", "<Left>", { desc = "Move left in insert mode" })
map("i", "<C-l>", "<Right>", { desc = "Move right in insert mode" })
map("i", "<C-j>", "<Down>", { desc = "Move down in insert mode" })
map("i", "<C-k>", "<Up>", { desc = "Move Up in insert mode" })

-- Insert Mode Mappings
map("n", "<leader>x", "<cmd>q<CR>", { desc = "Close current Tab" })
map("n", "<leader>X", "<cmd>qa<CR>", { desc = "Close all Tab" })
map("n", "<TAB>", "<cmd>tabnext<CR>w", { desc = "Goto Next Tab" })
map("n", "<S-TAB>", "<cmd>tabprevious<CR>w", { desc = "Goto Previous Tab" })

map('n', '<C-h>', '<C-w>h', { desc = "Window left" })
map('n', '<C-l>', '<C-w>l', { desc = "Window right" })
map('n', '<C-k>', '<C-w>k', { desc = "Window up" })
map('n', '<C-j>', '<C-w>j', { desc = "Window down" })

map('n', '<C-s>', ':w <CR>', { desc = "Save File" })
map('n', '<Esc>', ':noh <CR>', { desc = "Clear Highlights" })
map('n', '<C-c>', ':%y+ <CR>', { desc = "Copy whole file." })

map('n', '<leader>fm', function()
	vim.lsp.buf.format { async = true }
end, { desc = "LSP Formatting" })
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Git Mappings
map('n', '<leader>gs', "<cmd>Git<cr>", { desc = 'Git Status' })
map('n', '<leader>gbl', "<cmd>Git blame<cr>", { desc = 'Git Blame' })
map('n', '<leader>gbr', "<cmd>Git branch<cr>", { desc = 'Git Branch' })
map('n', '<leader>gd', "<cmd>Gdiffsplit<cr>", { desc = 'Git Diff' })
map('n', '<leader>gl', "<cmd>Gclog<cr>", { desc = 'Git Log' })

map('n', '<leader>ot', ":split | term<cr>", { desc = 'Open terminal in a new split' })
map('n', '<F9>', ":w | split | terminal python %<cr>", { desc = 'Run python script' })

-- Terminal mode command
vim.api.nvim_set_keymap('t', '<ESC>', [[<C-\><C-n>]], { noremap = true })

map('n', '<leader>le', ":ALEToggle<cr>", { desc = 'Toggle ALE linting' })
