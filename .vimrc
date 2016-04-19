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
"Plugin 'scrooloose/syntastic'
Plugin 'Yggdroot/indentLine'
Plugin 'ervandew/supertab'
Plugin 'jiangmiao/auto-pairs'
Plugin 'itchyny/lightline.vim'

call vundle#end()
filetype plugin indent on

" Plugin settings
" Syntastic
let g:syntastic_quiet_messages = {"level": "warnings"}
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_cpp_checkers = ['clang_check']
let g:syntastic_cpp_clang_check_config_file = '~/.vim/clang_check_args.txt'

" auto-pairs
let g:AutoPairsMultilineClose = 0

" lightline
let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ }

" Colors
syntax on " Enable vim's syntax highlighting
colorscheme molokai
set t_Co=256

" Allow backspace to remove newline and auto-indent whitespace
set backspace=indent,eol,start "Equivalent to: set backspace=2

" Indentation
set autoindent " Maintain current indent when starting a new line
set smartindent " Increase indentation after opening a new block ({} or keywords)
set cindent " Use C-style indentation rules TODO: Configure this properly
set tabstop=4 " Number spaces that a tab is equivalent to
set shiftwidth=4 " Number of spaces used for each autoindent level
set expandtab " Insert spaces instead of a tab character when pressing tab
set smarttab " Backspace removes <shiftwidth>-many characters

" Ensure that we never scroll to the last line visible onscreen
set scrolloff=4

set clipboard=unnamed " Yank/Put with the unnamed (system) register by default

" UI
set laststatus=2 " Always show the status line, even with only 1 window
set number " Show line numbers at the start of each line
set numberwidth=4 " Use at least 4 columns to show the line number
set wildmenu " Show the autocomplete options with pressing tab
set wildmode=list:longest,full
set ruler " Show text in the bottom-right corner indicating the current line number, column and relative position in the file (percent)
match Error "\s\+$" " Highlight all trailing whitespace
set linebreak " Wrap lines at an intelligent place instead of just at the last character that fits onto the screen
set breakindent " Indent the start of wrapped lines to the same level as their original linestart
set breakindentopt:shift:2 " Further indent the start of the wrapped line to emphasize the wrap

set cursorline " Highlight the line that the cursor is on

" Split Setup
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
set splitright " Make new vertical splits appear to the right the current one
set splitbelow " Make new horizontal splits appear below the current one

" Switch between buffers easily
nnoremap <tab> <C-w><C-w>

" Better indenting in visual mode
vnoremap <tab> > gv
vnoremap <S-tab> < gv

" Use jj to go back to normal mode
imap jj <esc>

" Learn to stop using arrow keys to move around
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Search
set incsearch " Highlight a search match as the search term is being entered
set hlsearch " Highlight all search results. enter :noh to clear highlight
set ignorecase  " Ignore case in search strings
set smartcase " Disable case-insensitivity if the search string contains upper-case characters
