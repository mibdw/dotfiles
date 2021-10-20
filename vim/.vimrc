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
set laststatus=2
set showtabline=1
set cursorline
set background=dark
set updatetime=300
set timeoutlen=500
set completeopt=longest,menu
set noshowmode
set hlsearch
set incsearch
set wildmenu
"set signcolumn=number
set shortmess+=c
set list
set showbreak=↪\
set listchars=tab:—\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set foldcolumn=1
set clipboard=unnamed

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"Plugins
filetype plugin on

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mhinz/vim-signify'

Plug 'junegunn/fzf.vim'

Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'machakann/vim-highlightedyank'

Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-obsession'

Plug 'sainnhe/sonokai'

call plug#end()

"Change cursor on Insert
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

"Space leader key (see WhichKey for more...)
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

"Easy ESC
inoremap jk <Esc>
inoremap kj <Esc>
inoremap jj <Esc>

"Buffer switching
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

"Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Resize windows
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>

"Indent lines
vnoremap < <gv
vnoremap > >gv

"NerdTree
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore = ['^node_modules$']

"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#obsession#enabled = 1

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

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"Which key
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}
let g:which_key_sep = '→'
let g:which_key_use_floating_win = 0

highlight default link WhichKey Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup Identifier
highlight default link WhichKeyDesc Function

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

let g:which_key_map['/'] = ['<Plug>NERDCommenterToggle', 'Comment' ]
let g:which_key_map['e'] = [':NERDTreeFind', 'NERDTree Find' ]
let g:which_key_map['E'] = [':NERDTreeToggle', 'NERDTree Toggle' ]
let g:which_key_map['Q'] = [':source ~/.vimrc', '(Re)compile Vim' ]
let g:which_key_map['j'] = ['<C-W>w', 'Next window']
let g:which_key_map['q'] = [':wqa!', 'Quit everything']
let g:which_key_map['p'] = [':Prettier', 'Prettier']
let g:which_key_map['u'] = ['vUi ', 'Make uppercase']

let g:which_key_map.b = {
  \ 'name' : '+Buffers' ,
  \ 'j' : [':bnext', 'Next buffer'],
  \ 'k' : [':bprevious', 'Previous buffer'],
  \ 'd' : [':bdelete', 'Delete buffer'],
  \ 'w' : [':bwipeout', 'Wipeout buffer'],
  \ }

let g:which_key_map.c = {
  \ 'name' : '+CoC' ,
  \ 'f' : ['<Plug>(coc-format-selected)', 'Format selected'],
  \ 'a' : ['<Plug>(coc-codeaction-selected)', 'Code action selected'],
  \ 'A' : ['<Plug>(coc-codeaction)', 'Code action'],
  \ 'q' : ['<Plug>(code-fix-current)', 'Quickfix'],
  \ 'd' : [':CocList diagnostics', 'Diagnostics'],
  \ 'x' : [':CocList extensions', 'Extensions'],
  \ 'c' : [':CocList commands', 'Commands'],
  \ 'o' : [':CocList outline', 'Outline'],
  \ 's' : [':CocList -I symbols', 'Symbols'],
  \ 'j' : [':CocNext', 'Next'],
  \ 'k' : [':CocPrev', 'Previous'],
  \ 'p' : [':CocListResume', 'Resume'],
  \ }

let g:which_key_map.g = {
  \ 'name' : '+Git' ,
  \ 'a' : [':Git add', 'Add'],
  \ 'b' : [':Git blame', 'Blame'],
  \ 'B' : ['GBrowse', 'Browse'],
  \ 'c' : [':Git commit', 'Commit'],
  \ 'C' : [':GV', 'Commit browser'],
  \ 'd' : [':Git diff', 'Diff'],
  \ 'D' : ['Gdiffsplit', 'Diff split'],
  \ 'g' : [':Gist', 'Create Gist'],
  \ 'j' : ['<plug>(signify-next-hunk)', 'Next hunk'],
  \ 'k' : ['<plug>(signify-prev-hunk)', 'Previous hunk'],
  \ 'l' : [':Git log', 'Log'],
  \ 'r' : ['GRemove', 'Remove'],
  \ 's' : [':Git status', 'Status'],
  \ 'p' : [':Git push', 'Push'],
  \ 'P' : [':git pull', 'Pull'],
  \ }

let g:which_key_map.w = {
  \ 'name' : '+Windows' ,
  \ 'w' : ['<C-W>w', 'Next window'],
  \ 'q' : ['<C-W>c', 'Close window'],
  \ 'b' : ['<C-W>s', 'New window below'],
  \ 'v' : ['<C-W>v', 'New window right'],
  \ 'h' : ['<C-W>h', 'Left window'],
  \ 'j' : ['<C-W>j', 'Down window'],
  \ 'k' : ['<C-W>k', 'Up window'],
  \ 'l' : ['<C-W>l', 'Right window'],
  \ 'u' : ['<C-W>5<', 'Expand window left'],
  \ 'i' : [':resize +5', 'Expand window below'],
  \ 'o' : [':resize -5', 'Expand window up'],
  \ 'p' : ['<C-W>5>', 'Expand window right'],
  \ 'z' : [':Windows', 'Overview'],
  \ }

let g:which_key_map.f = {
  \ 'name' : '+Find' ,
  \ 'f' : [':Files', 'Files'],
  \ 'g' : [':GFiles', 'GFiles'],
  \ 'b' : [':Buffers', 'Buffers'],
  \ 'l' : [':BLines', 'Current buffer'],
  \ 'r' : [':Rg', 'Grep'],
  \ }


let g:which_key_group_dicts = ''
call which_key#register('<Space>', "g:which_key_map")

"Sonokai colorscheme
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_transparent_background = 1
let g:sonokai_enable_italic = 1
let g:airline_theme = 'sonokai'
colorscheme sonokai
