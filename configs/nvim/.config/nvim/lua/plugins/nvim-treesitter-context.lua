-- Shows current context (class, function, method name) while scrolling
return {
  "nvim-treesitter/nvim-treesitter-context",
  lazy = true,
  event = "BufRead",
  opts = function()
    return { mode = "cursor", max_lines = 3 }
  end,
}
