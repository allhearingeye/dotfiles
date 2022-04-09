set nocompatible


call plug#begin()

Plug 'preservim/nerdtree'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'sheerun/vim-polyglot'

" colorschemes
Plug '/morhetz/gruvbox'
Plug '/tomasr/molokai'
Plug '/mhartington/oceanic-next'

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
set pastetoggle=<F3>
set hidden

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

let mapleader = ","

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
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" set keymap=russian-jcukenwin
" set iminsert=0
" set imsearch=0
" inoremap <C-l> <C-^>

nmap <silent><leader><leader> :NERDTreeToggle<CR>

" disable bell
set belloff=all
"set noerrorbells
"set novisualbell


" colors
set t_Co=256
set t_ut=
if (has("termguicolors"))
  set termguicolors
endif

"colorschemes
set bg=dark
colorscheme OceanicNext
" colorscheme gruvbox
" let g:molokai_original = 0
" let g:rehash256 = 1
" colorscheme molokai

set autoread
set backspace=indent,eol,start

" copy and cut
vmap <C-c> "+y
vmap <C-x> "*x

" if system('uname -r') =~ "Microsoft"
"     augroup Yank
"         autocmd!
"         autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
"         augroup END
" endif

" Split
set splitbelow
set splitright

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" statusline
set laststatus=2

" Status line
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
" Column number:line number
set statusline+=\ %3c:%-4l
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

