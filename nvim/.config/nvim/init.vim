syntax enable
set nocompatible
set hidden
set nowrap
set ignorecase
set smartcase
set pumheight=10
set ruler
set cmdheight=1
set t_Co=256
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent
set autoindent
set cursorline
set background=dark
set updatetime=300
set timeoutlen=500

set completeopt=menu,menuone,noselect
set hlsearch
set incsearch
set wildmenu
set clipboard=unnamedplus

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

function! GitBranch()
  let l:branchname = FugitiveHead()
  return strlen(l:branchname) > 0?'  ['.l:branchname.'] ':''
endfunction

function! GitStats()
  let l:branchstats = sy#repo#get_stats_decorated()
  return strlen(l:branchstats) > 0?' '.l:branchstats.' ':''
endfunction

set laststatus=2
set statusline=
set statusline+=
set statusline+=%{GitBranch()}
set statusline+=
set statusline+=%{GitStats()}
set statusline+=\ %f
set statusline+=\ %m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %p%%
set statusline+=\ %l,%c
set statusline+=\ 

"Treesitter
lua require('plugins')

"Treesitter
lua require('treesitter')

"LSP
lua require('language-servers')

"Prettier
lua require('formatting')

"Change cursor on Insert
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

"Space leader key 
let g:mapleader = "\<Space>"

"Disable Ex mode
map q: <Nop>
nnoremap Q <nop>

"Easy ESC
inoremap jk <Esc>
inoremap kj <Esc>

"Indent lines
vnoremap < <gv
vnoremap > >gv

"NERDTree
nnoremap <silent> <leader>e :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1

"FZF
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>r :Rg<CR>

"Sonokai colorscheme
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_transparent_background = 1
let g:sonokai_enable_italic = 1

"Dracula colorscheme
let g:dracula_colorterm = 0

colorscheme dracula
