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
Plugin 'rodjek/vim-puppet'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'supercollider/scvim'
Plugin 'hashivim/vim-terraform'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'rust-lang/rust.vim'
" ...

" Plugins need to be added before this line
call vundle#end()            " required
filetype plugin indent on    " required




" Indentation for file types
" ...................................................
" Python PEP8 indentation
autocmd BufNewFile,BufRead *.py
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

" HTML, JS and css indents
autocmd BufNewFile,BufRead *.js,*.html,*.css
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |
    \ setlocal autoindent

" YAML Indents
autocmd FileType yaml
    \ setlocal ts=2 |
    \ setlocal sts=2 |
    \ setlocal sw=2 |
    \ setlocal expandtab |
    \ setlocal autoindent

" Terraform Indents
autocmd BufNewFile,BufRead *.tf,*.tfvars
    \ setlocal ts=2 |
    \ setlocal sts=2 |
    \ setlocal sw=2 |
    \ setlocal expandtab |
    \ setlocal autoindent

" Rust Indents
autocmd BufNewFile,BufRead *.rs
    \ setlocal ts=4 |
    \ setlocal sts=4 |
    \ setlocal sw=4 |
    \ setlocal expandtab |
    \ setlocal autoindent

" Indent marker plugin
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 239
let g:indentLine_char = '|'




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

" Relative Numbers
set relativenumber

" Turn off swapfiles
set noswapfile

" Highlight 80th column in Python file
autocmd FileType python set colorcolumn=80

" Remove all tailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e




" NerdTree settings
" ...................................................
" Show NerdTree bookmarks by default
let NERDTreeShowBookmarks=1

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




" Custom keymappings
" ...................................................
" Buffer manipulation
nmap <leader>h :bp<cr>
nmap <leader>l :bn<cr>
nmap <leader>x :bd<cr>

" FZF
nmap <leader>p :Files<cr>
nmap <leader>g :GFiles<cr>
nmap <leader>rg :Rg<cr>

" Edit vimrc
nmap <leader>e :e ~/.vimrc<cr>

" Run current python script in buffer
autocmd FileType python map <buffer> <leader>r :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" For openFrameworks, build and run project
autocmd FileType cpp map <buffer> <leader>r :w<CR>:exec '!make -j16 && make run'<CR>

" Run the current go script in buffer
autocmd FileType go map <buffer> <leader>r :w<CR>:exec '!go run' shellescape(@%, 1)<CR>

" F-Keys
nnoremap <silent> <F2> :so ~/.vimrc<CR>
set pastetoggle=<F3>
nnoremap <silent> <F5> :write<CR>
nnoremap <silent> <F6> :wqa<CR>
nnoremap <silent> <F7> :edit<CR>
nnoremap <silent> <F9> :Git<CR>
nnoremap <silent> <F10> :Git diff<CR>

" Cursor hightlighting
:hi CursorLine    guibg=#2b2b2b
:nnoremap <Leader>c :set cursorline!<CR>

" Allowing editing of protected files
cmap w!! w !sudo tee > /dev/null %
