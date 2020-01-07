" Fix the path so that we can find ~/.vim on windows, by default the runtime path only includes ~/vimfiles, so it doesn't find plugins
if has('win32') || has('win64')
    if has('nvim')
        set runtimepath=$HOME/.config/nvim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.config/nvim/after
    else
        set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif
endif

" =======
" Plugins
" =======

if has('nvim')
    call plug#begin('~/.config/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif
Plug 'airblade/vim-gitgutter' " Show a gutter with git changes next to the line numbers
Plug 'alvan/vim-closetag' " HTML & XML tag auto-closing
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy-find files and buffers
Plug 'elzr/vim-json' " Better JSON highlighting
Plug 'fatih/vim-go' " Golang development helper (highlighting, formatting, source navigation etc)
Plug 'godlygeek/tabular' " Formatting text into tables easily
Plug 'google/vim-searchindex' " Show a count of the total and current results (e.g '[3/4]') when searching
Plug 'itchyny/lightline.vim' " A nicer status bar, colour-coded by mode
Plug 'jiangmiao/auto-pairs' " Insert & delete pairs of characters in pairs (brackets, quotes etc)
Plug 'junegunn/gv.vim'
Plug 'justinmk/vim-sneak' " Adds a more powerful f/t-style command that jumps to the next instance of a 2-character sequence
Plug 'machakann/vim-highlightedyank' " Temporarily highlight the yanked text when yanking
Plug 'majutsushi/tagbar'
" TODO: This currently has a bug whereby the warning icons don't go away after I fix the warnings Plug 'maximbaz/lightline-ale'
Plug 'OrangeT/vim-csharp'
Plug 'rr-/vim-hexdec' " Convert numbers between decimal and hexadecimal inside vim
Plug 'rust-lang/rust.vim' " Highlighting, formatting and filetype for the Rust language
Plug 'scrooloose/nerdtree' " A better file explorer within vim
" TODO: Get this running once we have autocomplete Plug 'shougo/echodoc.vim' " Display function signatures from completions on the command line.
Plug 'tikhomirov/vim-glsl' " Syntax highlighting for GLSL
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch' " Asynchronous task execution in vim
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive' " Wrapper for many git commands (commit, browse, blame etc)
Plug 'tpope/vim-repeat' " Extend the . operator to support actions provided by certain plugins
if !has('nvim')
    Plug 'tpope/vim-sensible' " Set a bunch of options to better default values. Unnecessary in neovim (this is built-in there)
endif
Plug 'tpope/vim-surround' " Add a 'surround' noun so that you can refer to surrounding quotes, braces, XML tags etc
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/CursorLineCurrentWindow' " Toggles highlighting of the cursor line so it is only active on the focussed buffer
Plug 'vim-scripts/Gundo'
Plug 'vimwiki/vimwiki' " An easy-to-use wiki from the comfort of your own editor
Plug 'w0rp/ale' " Asynchronous Linting Engine
Plug 'Yggdroot/indentLine' " Show indent guides (e.g a pipe every 4 consecutive spaces)
Plug 'ziglang/zig.vim' " Auto-formatting, syntax highlighting etc for the Zig language

if has('nvim')
    "Plug 'roxma/nvim-yarp' | Plug 'ncm2/ncm2' " TODO: Get this working?
    "Plug 'ncm2/ncm2-path'
    "Plug 'ncm2/ncm2-snippet' " TODO
    "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'prabirshrestha/asyncomplete.vim'

    " GUI
    " TODO:
    " https://github.com/equalsraf/neovim-qt/wiki
    " https://github.com/equalsraf/neovim-qt/issues/506
    " :h nvim-gui-shim
    "Plug 'equalsraf/neovim-gui-shim' " Necessary for neovim-qt to understand configuration from this file
    "GuiTabline 0
    "GuiPopupMenu 0
else
    "Plug 'Shougo/neocomplete.vim'
endif

Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'

call plug#end()
filetype plugin indent on

" Plugin settings

if has('nvim')
    " deoplete
    let g:deoplete#enable_at_startup = 1
else
    " NeoComplete
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_auto_delimiter = 1 " Auto-insert delimiters, such as / for filenames
    let g:neocomplete#enable_camel_case = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_patter = '\*ku\*'
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-e> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
    let g:neocomplete#sources#omni#input_patterns.c =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#sources#omni#input_patterns.cpp =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
endif

"ALE
let g:ale_linters = {
            \ 'javascript': ['eslint'],
            \ 'html': []
            \ }
let g:ale_echo_msg_format = '[%severity%-%linter%] %s'
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '!'
let g:ale_sign_info = 'i'
nnoremap gln :ALENext<CR>
nnoremap glp :ALEPrevious<CR>

" indentLine
let g:indentLine_faster = 1

" vim-json
let g:vim_json_syntax_conceal = 0

" auto-pairs
let g:AutoPairsMultilineClose = 0
let g:AutoPairsCenterLine = 0

" lightline
let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ 'component_type': {
    \   'linter_checking': 'left',
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error',
    \   'linter_ok': 'left',
    \ },
    \ 'component_expand': {
    \   'linter_checking': 'lightline#ale#checking',
    \   'linter_warnings': 'lightline#ale#warnings',
    \   'linter_errors': 'lightline#ale#errors',
    \   'linter_ok': 'lightline#ale#ok',
    \ },
    \ }
" TODO: Fix this so that the ALE stats update as we fix the linter errors. The _linter* options above are all just there fore ALE stats, without lightline-ale they're not doing anything. They should be removed or fixed.
" let g:lightline.active.right = { 'right': [  [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]], }

" vim-gitgutter
let g:gitgutter_map_keys = 0

" CtrlP
let g:ctrlp_user_command='rg --maxdepth 10 -F --files %s'
let g:ctrlp_use_caching=0
let g:ctrlp_map = '<c-p>'

" highlighted yank
if !has('nvim')
    " NOTE: We only need this map configuration in Vim, Neovim handles it automatically
    map y <Plug>(highlightedyank)
endif
let g:highlightedyank_highlight_duration = 200

" CursorLineCurrentWindow
set cursorline

" NERDTree
let g:NERDTreeMouseMode=2
let NERDTreeDirArrowExpandable = "►"
let NERDTreeDirArrowCollapsible = "▼"


" =========================
" Vim (non-plugin) settings
" =========================


" Colors
syntax enable " Enable vim's syntax highlighting
colorscheme onedark
set t_Co=256

" Indentation
set cindent " Use C-style indentation rules TODO: Configure this properly
set expandtab " Insert a space characters when pressing tab (not a tab)
set shiftwidth=4 " Number of spaces used for each autoindent level
set smartindent " Increase indentation after opening a new block ({} or keywords)
set tabstop=4 " Number spaces that a tab is equivalent to

" UI
set breakindent " Indent the start of wrapped lines to the same level as their original linestart
set breakindentopt:shift:2 " Further indent the start of the wrapped line to emphasize the wrap
set completeopt-=preview " Don't open a preview window with more info about completion options
set cursorline " Highlight the line that the cursor is on
set encoding=utf-8
set lazyredraw " Do not redraw between every action when executing macros or other non-typed commands
set linebreak " Wrap lines at an intelligent place instead of just at the last character that fits onto the screen
set list " Enable rendering of listchars in place of their corresponding invisible characters
set listchars=tab:┆\·,trail:·,nbsp:?,extends:»,precedes:« " Set which characters to render in place of tabs/trailing spaces
set mouse=a " Enable mouse-usage in all modes
set nowrap " Don't wrap long lines (zH and zL to move horizontally)
set number " Show line numbers at the start of each line
set numberwidth=4 " Use at least 4 columns to show the line number
set showbreak=↪\  " The characters to display at the start of the new line when wrapping

" Misc
if has('nvim')
    set clipboard=unnamedplus " Yank/Put with the unnamed (system) register by default
else
    set clipboard=unnamed " Yank/Put with the unnamed (system) register by default
endif
set diffopt+=vertical " Open diffs in a vertical (rather than horizontal) split
set encoding=utf-8 " Use UTF-8 for all character encoding in vim
set nofixeol " Don't insert missing newlines at EOF on save
set scrolloff=4 " Ensure that we never scroll to the last line visible onscreen
set sidescroll=1 " Scroll sideways by only 1 column at a time when the cursor moves to close to the edge of the screen
set sidescrolloff=4 " Ensure that we never scroll to the last column visible onscreen
set spell " Enable spellcheck

" Split Setup
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
set splitright " Make new vertical splits appear to the right the current one
set splitbelow " Make new horizontal splits appear below the current one

" Better indenting in visual mode
vnoremap <tab> > gv
vnoremap <S-tab> < gv

" More intuitive vertical movement on wrapped lines.
" Without this, j & k ignore wrapped text and move the cursor in actual lines rather than visible lines.
nmap j gj
nmap k gk

" Learn to stop using arrow keys to move around
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Search
set ignorecase  " Ignore case in search strings
set smartcase " Disable case-insensitivity if the search string contains upper-case characters
if has('nvim')
    set inccommand=nosplit " Show a live in-place preview of the substitution command while it is being entered
endif

" Persistent Undo
set undodir^=~/.vim/undo// " Write undo files to a specific directory by default. The trailing // instructs vim to use each file's full path in the undo dir (to prevent ambiguity between files with the same name in different directories). The ^= prepends the value.
set undofile " Persist undo history to disk when writing a buffer to a file (allows you to close and re-open a file and keep the undo history)
set undolevels=1000 " The maximum number of changes that can be undone at one time
set undoreload=10000 " Save the whole buffer for undo when reloading it if the number of lines in the buffer is less than this option's value

" Swap files
set directory^=~/.vim/swap// " Write swap files to a specific directory by default
set swapfile " Write swap files for each buffer, which protects against crash/power loss between writes

" Backups
set backupcopy=auto " Use whatever the platform-specific best scheme is for making and using backup files
set backupdir^=~/.vim/backup// " Write backups to a specific directory by default
set nobackup " Do not persist backup files after a successful write
set writebackup " Make a backup before overwriting a file that is removed after successful write. Prevents data loss if we crash during a write

" Set defaults that neovim has built-in
if !has('nvim')
    set autoindent " Maintain current indent when starting a new line
    set backspace=indent,eol,start " Allow backspace to remove newline and auto-indent whitespace. Equivalent to: set backspace=2
    set hlsearch " Highlight all search results. enter :noh to clear highlight
    set incsearch " Highlight a search match as the search term is being entered
    set laststatus=2 " Always show the status line, even with only 1 window
    set ruler " Show text in the bottom-right corner indicating the current line number, column and relative position in the file (percent)
    set smarttab " Backspace removes <shiftwidth>-many characters
    set ttyfast " Send more characters to be drawn because we have a fast tty connection. Renders faster
    set wildmenu " Show the autocomplete options with pressing tab
endif

" File-type-specific settings overrides
autocmd FileType gitcommit setlocal spell
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType markdown setlocal wrap spell

