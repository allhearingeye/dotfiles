set nocompatible


call plug#begin()

Plug 'preservim/nerdtree'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'sheerun/vim-polyglot'

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'mhartington/oceanic-next'
Plug 'w0ng/vim-hybrid'
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
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

" search
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <silent><C-_> :nohlsearch<CR>
nnoremap <silent><C-/> :nohlsearch<CR>


filetype on
filetype plugin on
filetype plugin indent on
syntax on

" let mapleader = ","

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
" set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
inoremap <C-l> <C-^>

set spelllang=ru_yo,en_us

" Toggle spellchecking
nnoremap <silent><leader>s :setlocal invspell<CR>

nmap <silent><leader><leader> :NERDTreeToggle<CR>

" disable bell
set belloff=all
"set noerrorbells
"set novisualbell


"colorschemes
try
    " colorscheme OceanicNext
    " colorscheme gruvbox

    " let g:molokai_original = 0
    " let g:rehash256 = 1
    " colorscheme molokai

    " let g:sonokai_style = 'default'
    " let g:sonokai_better_performance = 1
    " colorscheme sonokai

    " colorscheme hybrid
    " colorscheme onedark
    " colorscheme solarized
    " colorscheme base16-default-dark
catch
endtry

" colors
set background=dark
set t_Co=256
set t_ut=
" if (has("termguicolors"))
"   set termguicolors
" endif

set autoread
set backspace=indent,eol,start

" copy and paste in system clipboard
set clipboard=unnamed,unnamedplus

" Split
set splitbelow
set splitright

" json
if executable("jq")
    nnoremap <silent><leader>j :% !jq<CR>
    nnoremap <silent><leader>J :% !jq -c<CR>
endif

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
  colorscheme sonokai

  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h12:cANSI
  endif
endif

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
" let &t_SI = "\e[6 q"
" let &t_EI = "\e[2 q"

" statusline
set laststatus=2

" file size
    function! FileSize()
        let bytes = getfsize(expand("%:p"))
        if bytes <= 0
            return ""
        endif
        if bytes < 1024
            return bytes . "B"
        else
            return (bytes / 1024) . "K"
        endif
    endfunction


" Buffer number
set statusline=[%n]
" File name
set statusline+=\ %t
" Modified flag
set statusline+=\ %m
" Read Only flag
set statusline+=\ %r
" Paste mode flag
set statusline+=\ %{&paste?'[paste]':''}
" Left/right separator
set statusline+=%=
" Line number:column number
set statusline+=\ %4l:%-3c
" Percentage
set statusline+=\ %3p%%
" Separator
set statusline+=\ \|\ 
" File size
set statusline+=%{FileSize()}
" Filetype
set statusline+=\ %y
" File encoding
set statusline+=\ %{&fileencoding}
" File format
set statusline+=\ [%{&ff}]

