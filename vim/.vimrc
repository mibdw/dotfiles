syntax enable
set nocompatible
set hidden
set nowrap
set ignorecase
set smartcase
set pumheight=10
set encoding=UTF-8
set ruler
set number
set relativenumber
set cmdheight=1
set mouse=a
set splitbelow
set splitright
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
set signcolumn=number
set shortmess+=c
set foldcolumn=1
set clipboard=unnamed
set list
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"Plugins
filetype plugin on

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-obsession'
Plug 'mhinz/vim-signify'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'

Plug 'machakann/vim-highlightedyank'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'

Plug 'sainnhe/sonokai'

call plug#end()

"Change cursor on Insert
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

"Space leader key 
let g:mapleader = "\<Space>"

nnoremap <silent> <leader>q :wqa!<CR>

"Easy ESC
inoremap jk <Esc>
inoremap kj <Esc>

"Buffer switching
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

"Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"Indent lines
vnoremap < <gv
vnoremap > >gv

"NERD Commenter
nnoremap <silent> <leader>cc :NERDCommenterToggle<CR>
nnoremap <silent> <leader>cu :NERDCommenterUncomment<CR>

"Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
nnoremap <silent> <leader>e :Vexplore<CR>

"FZF
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fg :GFiles<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fr :Rg<CR>

"Airline
let g:airline#extensions#tabline#enabled = 1

"COC
command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
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
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

"Sonokai colorscheme
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_transparent_background = 1
let g:sonokai_enable_italic = 1
colorscheme sonokai

hi HighlightedyankRegion cterm=reverse gui=reverse
