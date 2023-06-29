-- GENERAL SETTINGS
vim.o.termguicolors = true
vim.o.timeoutlen = 500
vim.o.updatetime = 200
vim.o.scrolloff = 8
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.cindent = true
vim.o.autoindent = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.pumheight = 25
vim.o.background = "light"

--KEYBINDINGS
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "ss", "i<cr><esc>")
vim.keymap.set("n", "<leader>e", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>g", "<cmd>Telescope git_files<cr>")
vim.keymap.set("n", "<leader>r", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>h", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>o", "<cmd>Telescope command_history<cr>")
vim.keymap.set("n", "<leader>p", "<cmd>lua vim.lsp.buf.format()<cr>")
vim.keymap.set("n", "<leader>t", "<cmd>source ~/.config/nvim/init.lua<cr>")

-- HIGHLIGH YANK
vim.cmd[[ autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=(vim.fn["hlexists"]("HighlightedyankRegion") > 0 and "HighlightedyankRegion" or "IncSearch"), timeout=1000} ]]

--PLUGINS
require("packer").startup(function()
  use "wbthomason/packer.nvim"
  use "tpope/vim-obsession"
  use "tpope/vim-fugitive"
  use "tpope/vim-surround"
  use "mhinz/vim-signify"
  use "preservim/nerdcommenter"
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true }
  }
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"
  use "onsails/lspkind.nvim"
  use "sbdchd/neoformat"
  --use 'sunjon/shade.nvim' 
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
      "nvim-telescope/telescope-file-browser.nvim",
      requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
end)


-- TELESCOPE
require("telescope").setup {
  defaults = {
    mappings = {
      n = {
        ['<c-d>'] = require('telescope.actions').delete_buffer
      },
      i = {
        ['<c-d>'] = require('telescope.actions').delete_buffer
      },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
}
require("telescope").load_extension "file_browser"

-- COLORSCHEME 
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
    },
    color_overrides = {
        latte = {
            text = "#111111",
        },
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = false,
        mini = false,
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"

-- LUA LINE
require("lualine").setup {
  options = {
    theme = "catppuccin",
    component_separators = { left = " ", right = " "},
    section_separators = { left = " ", right = " "},
  },
}

-- FZF
vim.cmd [[let g:fzf_layout = { "window": { "width": 0.9, "height": 0.8 } } ]]

-- NEOFORMAT
vim.g.neoformat_only_msg_on_error = 1
vim.cmd [[ autocmd BufWritePre *.js,*.jsx,*.json,*.scss,*.css,*.html,*.svg Neoformat ]]

-- TREESITTER
require"nvim-treesitter.configs".setup {
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
    "markdown",
    "typescript"
  },
  highlight = {
    enable = true,
  },
}

-- LSP
vim.opt.completeopt = {"menu", "menuone", "noselect"}
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  formatting = {
    format = require("lspkind").cmp_format({
      mode = 'symbol_text',
      maxwidth = 60,
    })
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("lspconfig").tsserver.setup {
  capabilities = capabilities,
}

require("lspconfig").html.setup {
  capabilities = capabilities,
}

require("lspconfig").cssls.setup {
  capabilities = capabilities,
}
require("lspconfig").jsonls.setup {
  capabilities = capabilities,
}

require("lspconfig").eslint.setup {
  capabilities = capabilities,
}
