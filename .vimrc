" .Vimrc
" ..................................................
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle plugin manager
Plugin 'gmarik/Vundle.vim'

" Plugins
" ..................................................
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-fugitive'
Plugin 'Yggdroot/indentLine'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'airblade/vim-gitgutter'
" ...

" Plugins need to be added before this line
call vundle#end()            " required
filetype plugin indent on    " required




" Indentation for file types
" ...................................................
" Python PEP8 indentation
au BufNewFile,BufRead *.py
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

" HTML, JS and css indents
au BufNewFile,BufRead *.js, *.html, *.css
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |
    \ setlocal autoindent

" YAML indents
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Indent marker plugin
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
let g:indentLine_char = '⸽'




" Other settings
" ..................................................
" Python highlighting
let python_highlight_all=1
syntax on

" UTF-8
set encoding=utf-8

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Set the number margin
set number
set numberwidth=4

" Set the theme
color gruvbox
set background=dark

" Custom update time
set updatetime=100

" GitGutter settings
set signcolumn=yes




" NerdTree settings
" ...................................................
" Show NERDTree on start up
autocmd VimEnter * NERDTree

" Do not show these files in NERDTree
let NERDTreeIgnore=['^__pycache__$', '\.pyc$', '\~$']

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=0

" show hidden files in NERDTree
let NERDTreeShowHidden=1

" Toggle NERDTree
nmap <silent> <leader>k :NERDTreeToggle<cr>

" expand to the path of the file in the current buffer
nmap <silent> <leader>y :NERDTreeFind<cr>
" Show NerdTree bookmarks by default
let NERDTreeShowBookmarks=1




" Custom keymappings
" ...................................................
nmap <S-J> :bp<cr>
nmap <S-K> :bn<cr>
nmap <S-X> :bd<cr>




