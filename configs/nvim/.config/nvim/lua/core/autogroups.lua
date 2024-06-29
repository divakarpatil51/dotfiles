local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- This should be provided in .nvim.lua of each project
-- local auto_save_file_group = vim.api.nvim_create_augroup('AutoSavePyFileGroup', { clear = true })
-- vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
--   group = auto_save_file_group,
--   pattern = "*.py",
--   command = "!black % | ruff --fix %"
-- })
