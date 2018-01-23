" Fix the path so that we can find ~/.vim on windows
if has('win32')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Vundle
set nocompatible " Force iMproved, required for Vundle
filetype off " Required for Vundle
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
if has('nvim')
    Plugin 'Shougo/deoplete.nvim'
else
    Plugin 'Shougo/neocomplete.vim'
endif
"Plugin 'rip-rip/clang_complete' " TODO: See about this, it doesn't appear to load the config that lets it know where the includes are
"Plugin 'SirVer/ultisnips' " TODO: This interferes with <tab> for completion
Plugin 'ctrlpvim/ctrlp.vim' " Fuzzy file & buffer finding
Plugin 'Yggdroot/indentLine' " Visible indentation guides
Plugin 'jiangmiao/auto-pairs'
Plugin 'itchyny/lightline.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'google/vim-searchindex' " Specify the index of a search match in the status bar (e.g [2/5])
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround' " Easily change characters surrounding a text object (e.g { to [)
Plugin 'tpope/vim-repeat' " Support using . to repeat command combinations defined by plugins
Plugin 'majutsushi/tagbar'
Plugin 'vimwiki/vimwiki'
Plugin 'tikhomirov/vim-glsl' " GLSL Syntax highlighting
Plugin 'alvan/vim-closetag' " HTML tag auto-closing
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'

Bundle 'tomasr/molokai'

call vundle#end()
filetype plugin indent on

" Plugin settings
" NeoComplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_delimiter = 1 " Auto-insert delimiters, such as / for filenames
let g:neocomplete#enable_camel_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc =
      \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.objcpp =
      \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)\|\h\w*::\w*'

" deoplete
let g:deoplete#enable_at_startup = 1

" Clang_Complete
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_omnicppcomplete_compliance = 0
let g:clang_make_default_keymappings = 0
let g:clang_use_library = 1
if has('win32')
    let g:clang_library_path='C:\Program Files\LLVM\bin'
endif

" indentLine
let g:indentLine_faster = 1

" auto-pairs
let g:AutoPairsMultilineClose = 0
let g:AutoPairsCenterLine = 0

" lightline
let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ }

" vim-gitgutter
let g:gitgutter_map_keys = 0

" CtrlP
let g:ctrlp_user_command = 'rg --maxdepth 15 -F --files %s'
let g:ctrlp_use_caching = 0
let g:ctrlp_map = '<c-p>'

" Colors
syntax enable " Enable vim's syntax highlighting
colorscheme molokai
set t_Co=256

" Allow backspace to remove newline and auto-indent whitespace
set backspace=indent,eol,start "Equivalent to: set backspace=2

" Indentation
set autoindent " Maintain current indent when starting a new line
set smartindent " Increase indentation after opening a new block ({} or keywords)
set cindent " Use C-style indentation rules
set tabstop=4 " Number spaces that a tab is equivalent to
set shiftwidth=4 " Number of spaces used for each autoindent level
set expandtab " Insert spaces instead of a tab character when pressing tab
set smarttab " Backspace removes <shiftwidth>-many characters

" Filetype-specific Indentation
au FileType html,js setlocal shiftwidth=2 tabstop=2

" UI
set laststatus=2 " Always show the status line, even with only 1 window
set number " Show line numbers at the start of each line
set numberwidth=4 " Use at least 4 columns to show the line number
set wildmenu " Show the autocomplete options with pressing tab
set ruler " Show text in the bottom-right corner indicating the current line number, column and relative position in the file (percent)
set linebreak " Wrap lines at an intelligent place instead of just at the last character that fits onto the screen
set breakindent " Indent the start of wrapped lines to the same level as their original linestart
set breakindentopt:shift:2 " Further indent the start of the wrapped line to emphasize the wrap
set cursorline " Highlight the line that the cursor is on
set completeopt-=preview " Don't open a preview window with more info about completion options
set listchars=tab:»\ ,trail:·,nbsp:?,extends:>,precedes:< " Set which characters to render in place of tabs/trailing spaces
set list " Enable rendering of listchars in place of their corresponding invisible characters
set showbreak=- " TODO: Also get a nicer character here, wraithy uses a cool unicode arrow

" Misc
set scrolloff=4 " Ensure that we never scroll to the last line visible onscreen
set sidescrolloff=1 " Ensure that we can scroll to the last column visible on the screen
set sidescroll=1 " When moving off the screen to the right, scroll sideways by 1 column at a time
set clipboard=unnamed " Yank/Put with the unnamed (system) register by default
set encoding=utf-8 " Use UTF-8 for all character encoding in vim
set ttyfast " Send more characters to be drawn because we have a fast tty connection. Renders faster
set fileformats=unix,dos " Prefer unix line-endings for new buffers, this is default on unix systems

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

" More intuitive vertical movement on wrapped lines
nmap j gj
nmap k gk

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
if has('nvim')
    set inccommand=nosplit
else
endif
