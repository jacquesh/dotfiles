" Fix the path so that we can find ~/.vim on windows
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Vundle
set nocompatible " Force iMproved, required for Vundle
filetype off " Required for Vundle
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
Plugin 'ervandew/supertab'

call vundle#end()
filetype plugin indent on

" Plugin settings
" YouCompleteMe
let g:ycm_show_diagnostics_ui = 1

" Colors
syntax on " Enable vim's syntax highlighting
colorscheme molokai
set t_Co=256

" Allow backspace to remove newline and auto-indent whitespace
set backspace=indent,eol,start "Equivalent to: set backspace=2

" Indentation
set autoindent " Maintain current indent when starting a new line
set tabstop=4 " Number spaces that a tab is equivalent to
set shiftwidth=4 " Number of spaces used for each autoindent level
set expandtab " Insert spaces instead of a tab character when pressing tab
set smarttab " Backspace removes <shiftwidth>-many characters

" Ensure that we never scroll to the last line visible onscreen
set scrolloff=4

" UI
set number " Show line numbers at the start of each line
set numberwidth=4 " Use at least 4 columns to show the line number
set wildmenu " Show the autocomplete options with pressing tab
set ruler " Show text in the bottom-right corner indicating the current line number, column and relative position in the file (percent)
match ErrorMsg "\s\+$" " Highlight all trailing whitespace
"set linebreak " Wrap lines at an intelligent place instead of just at the last character that fits onto the screen - TODO This causes vim to auto-insert actual newlines in my files while I'm typing if I re-source this. It keeps doing that until I restart vim. Plsfix. Apparently gvim sometimes gets sad if you don't have a manually set textwidth...should try that out
set breakindent " Indent the start of wrapped lines to the same level as their original linestart
set breakindentopt:shift:2 " Further indent the start of the wrapped line to emphasize the wrap

set cursorline
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" Split Setup
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
set splitright
set splitbelow

" Switch between buffers easily
nnoremap <tab> <C-w><C-w>

" Learn to stop using arrow keys to move around
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Search
set incsearch " Highlight a search match as the search term is being entered
set hlsearch " Highlight all search results. enter :noh to clear highlight

