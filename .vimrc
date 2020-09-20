inoremap jk <ESC>
let mapleader = " "
filetype plugin indent on
syntax on
set noerrorbells
set expandtab
set smartindent
set nowrap
set noswapfile
set incsearch
set smartcase
set encoding=utf-8
set clipboard=unnamedplus
set nu
set number 
set relativenumber
set spell spelllang=en_us
set expandtab shiftwidth=4 softtabstop=4
set mouse=a

function! Cpp()
    " set UTF-8 encoding
    set enc=utf-8
    set fenc=utf-8
    set termencoding=utf-8
    " disable vi compatibility (emulation of old bugs)
    set nocompatible
    " use indentation of previous line
    set autoindent
    " use intelligent indentation for C
    set smartindent
    " configure tabwidth and insert spaces instead of tabs
    set tabstop=4        " tab width is 4 spaces
    set shiftwidth=4     " indent also with 4 spaces
    set expandtab        " expand tabs to spaces
    set smarttab
    " wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
    set textwidth=120
    " turn syntax highlighting on
    set t_Co=256
    syntax on
    " turn line numbers on
    set number
    " highlight matching braces
    set showmatch
    " intelligent comments
    set comments=sl:/*,mb:\ *,elx:\ */

    " in normal mode F2 will save the file
    nmap <F2> :w<CR>
    " in insert mode F2 will exit insert, save, enters insert again
    imap <F2> <ESC>:w<CR>i

    set autowrite
    nnoremap <C-c> :!g++ -std=c++11 % -Wall -g && ./a.out<CR>

    inoremap ( ()<Esc>i
    inoremap [ []<Esc>i
    inoremap { {<CR>}<Esc>O
    autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
    inoremap ) <c-r>=ClosePair(')')<CR>
    inoremap ] <c-r>=ClosePair(']')<CR>
    inoremap } <c-r>=CloseBracket()<CR>
    inoremap " <c-r>=QuoteDelim('"')<CR>
    inoremap ' <c-r>=QuoteDelim("'")<CR>

    function ClosePair(char)
     if getline('.')[col('.') - 1] == a:char
     return "\<Right>"
     else
     return a:char
     endif
    endf

    function ClogeBracket()
     if match(getline(line('.') + 1), '\s*}') < 0
     return "\<CR>}"
     else
     return "\<Esc>j0f}a"
     endif
    endf

    function QuoteDelim(char)
     let line = getline('.')
     let col = col('.')
     if line[col - 2] == "\\"
     "Inserting a quoted quotation mark into the string
     return a:char
     elseif line[col - 1] == a:char
     "Escaping out of the string
     return "\<Right>"
     else
     "Starting a string
     return a:char.a:char."\<Esc>i"
     endif
    endf
endfunction

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'mbbill/undotree'
Plug 'ycm-core/YouCompleteMe'

call plug#end()

colorscheme gruvbox
set background=dark

let mapleader = " "

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
:autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
:autocmd BufReadPost,BufNewFile *.cpp call Cpp()
