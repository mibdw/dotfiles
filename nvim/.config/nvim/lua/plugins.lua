return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-obsession'
  use 'tpope/vim-fugitive'
  use 'mhinz/vim-signify'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'preservim/nerdcommenter'
  use 'machakann/vim-highlightedyank'

  use 'preservim/nerdtree'
  use 'jeetsukumaran/vim-buffergator'
  use 'junegunn/fzf.vim'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use 'honza/vim-snippets'
  use {'dsznajder/vscode-es7-javascript-react-snippets',
    run = 'yarn install --frozen-lockfile && yarn compile'
  }

  use 'onsails/lspkind.nvim'

  use 'mhartington/formatter.nvim'

  use 'sainnhe/sonokai'
  use 'dracula/vim'

end)
