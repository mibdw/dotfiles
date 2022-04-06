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

set completeopt=longest,menu
set hlsearch
set incsearch
set wildmenu

set number
set relativenumber
set signcolumn=number

set clipboard=unnamedplus

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

function! GitBranch()
  let l:branchname = fugitive#head()
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

"Plugins
filetype plugin on

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'preservim/nerdcommenter'
Plug 'machakann/vim-highlightedyank'

Plug 'preservim/nerdtree'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot' 
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'sainnhe/sonokai'

call plug#end()

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

"COC
command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:coc_global_extensions = [
  \ 'coc-highlight',
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-emmet', 
  \ 'coc-go', 
  \ ]

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

autocmd CursorHold * silent call CocActionAsync('highlight')

command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

"Sonokai colorscheme
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_transparent_background = 1
let g:sonokai_enable_italic = 1
colorscheme sonokai

hi HighlightedyankRegion cterm=reverse gui=reverse
