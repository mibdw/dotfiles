require'nvim-treesitter.configs'.setup {
  ensure_installed = { 
    "html",
    "css",
    "scss",
    "javascript",
    "vim",
    "go",
    "toml",
    "lua",
    "json",
    "markdown"
  },

  highlight = {
    enable = true,
  },
}
