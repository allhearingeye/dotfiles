call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'sheerun/vim-polyglot'
Plug 'lervag/wiki.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/fzf'
" , { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'sainnhe/sonokai'

call plug#end()

set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
set noswapfile
set undofile
set ruler
set showcmd
set mouse=a
set number
set scrolloff=7
" set colorcolumn=80
set pastetoggle=<F2>
set hidden
set linebreak
let mapleader = " "

" search
set ignorecase
set smartcase
set incsearch
set hlsearch


filetype on
filetype plugin on
filetype plugin indent on
syntax on


" undo dir
if has('win32')
    set undodir=~\vimfiles\undodir
else
    set undodir=~/.vim/undodir
endif


" tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent

set list
" set listchars=trail:+

let python_highlight_all=1

" russian keymap
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
inoremap <C-l> <C-^>
cnoremap <C-l> <C-^>

set spelllang=ru,en_us

" Toggle spellchecking
nnoremap <silent><leader>s :setlocal invspell<CR>


" disable bell
set belloff=all
"set noerrorbells
"set novisualbell


"colorschemes
try
    " let g:gruvbox_transparent_bg = '1'
    " let g:gruvbox_contrast_darkd = 'hard'
    " colorscheme gruvbox

    let g:sonokai_style = 'default'
    let g:sonokai_better_performance = 1
    let g:sonokai_disable_italic_comment = 1
    let g:sonokai_transparent_background = 1
    colorscheme sonokai
catch
endtry

" colors
set background=dark
set t_Co=256
set t_ut=
if (has("termguicolors"))
  set termguicolors
endif


highlight Normal ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight StatusLine ctermbg=NONE guibg=NONE
highlight StatusLineNC ctermbg=NONE guibg=NONE

set autoread
set backspace=indent,eol,start

" copy and paste in system clipboard
set clipboard=unnamed,unnamedplus

" Split
set splitbelow
set splitright


" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

if has("gui_running")
  set guioptions -=m "Hides the menubar
  set guioptions -=T "Hides the toolbar
  set guioptions -=r "Hides right-hand scroll bar
  set guioptions -=L "Hides left-hand scroll bar
  set lines=50 columns=95

  let g:sonokai_style = 'default'
  let g:sonokai_better_performance = 1
  let g:sonokai_disable_italic_comment = 0
  let g:sonokai_transparent_background = 0
  colorscheme sonokai

  highlight lCursor guifg=NONE guibg=Cyan


  if has("gui_gtk3")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Hack\ Nerd\ Font\ Mono:h12:cANSI
  endif
endif


" statusline
set laststatus=2

let g:wiki_root = '~/notes'

" FZF maps
nnoremap <silent><leader>ff :Files<CR>
nnoremap <silent><leader>fg :Rg<CR>
nnoremap <silent><leader>fb :Buffers<CR>
nnoremap <silent><leader>fn :cd ~/notes <bar> Files<CR>
let $FZF_DEFAULT_OPTS="--bind ctrl-u:preview-up,ctrl-d:preview-down"

