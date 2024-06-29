
" Pathogen plugin manager
execute pathogen#infect()

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netwr_winsize = 25
augroup ProjectDrawer
	autocmd!
	autocmd VimEnter * :Vexplore
augroup	END


" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Autoindenting on for progamming languages.
set ai

" display incomplete commands.
set showcmd

" Show the filename in the window titlebar
set title

" Show current row and column
set ruler

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Use highlighting when doing a search.
set hlsearch

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" Show relative line numbers.
set relativenumber
" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.


" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.
" start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
