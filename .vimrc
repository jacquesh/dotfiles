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
Plug 'elzr/vim-json' " Better JSON highlighting
Plug 'fatih/vim-go' " Golang development helper (highlighting, formatting, source navigation etc)
Plug 'godlygeek/tabular' " Formatting text into tables easily
Plug 'google/vim-searchindex' " Show a count of the total and current results (e.g '[3/4]') when searching
Plug 'itchyny/lightline.vim' " A nicer status bar, colour-coded by mode
Plug 'jiangmiao/auto-pairs' " Insert & delete pairs of characters in pairs (brackets, quotes etc)
Plug 'junegunn/gv.vim'
Plug 'junegunn/fzf' " General purpose fuzzy-finder, for use to open files. Required for fzf.vim
Plug 'junegunn/fzf.vim' " Vim integration for fzf
Plug 'justinmk/vim-sneak' " Adds a more powerful f/t-style command that jumps to the next instance of a 2-character sequence
Plug 'machakann/vim-highlightedyank' " Temporarily highlight the yanked text when yanking
Plug 'majutsushi/tagbar'
Plug 'maximbaz/lightline-ale' " Show ALE stats on the status line
Plug 'prabirshrestha/async.vim' " Async job handling, used by asyncomplete, not used directly
Plug 'prabirshrestha/vim-lsp' " A language server protocol client. Used for linting and autocomplete
Plug 'prabirshrestha/asyncomplete.vim' " Async autocompletion with pluggable sources
Plug 'prabirshrestha/asyncomplete-buffer.vim' " Asyncomplete source that reads from the current buffer
Plug 'prabirshrestha/asyncomplete-file.vim' " Asyncomplete source that reads file names from disk
Plug 'prabirshrestha/asyncomplete-lsp.vim' " Asyncomplete source that uses a language server to provide intelligent completions
Plug 'rust-lang/rust.vim' " Highlighting, formatting and filetype for the Rust language
Plug 'scrooloose/nerdtree' " A better file explorer within vim
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
    " GUI
    " TODO:
    " https://github.com/equalsraf/neovim-qt/wiki
    " https://github.com/equalsraf/neovim-qt/issues/506
    " :h nvim-gui-shim
    Plug 'equalsraf/neovim-gui-shim' " Necessary for neovim-qt to understand configuration from this file
    GuiTabline 0
    GuiPopupMenu 0
endif

Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'

call plug#end()
filetype plugin indent on

" Plugin settings

" Asyncomplete
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : asyncomplete#force_refresh()
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
imap <C-SPACE> <Plug>(asyncomplete_force_refresh)

autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completeor': function('asyncomplete#sources#file#completor')
    \ }))
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))

"ALE
" let g:ale_linters = {
"             \ 'javascript': ['eslint'],
"             \ 'html': [],
"             \ 'cpp': ['clangd', 'clang-format']
"             \ }
" let g:ale_echo_msg_format = '[%severity%-%linter%] %s'
" let g:ale_sign_error = 'X'
" let g:ale_sign_warning = '!'
" let g:ale_sign_info = 'i'
" nnoremap gln :ALENextWrap<CR>
" nnoremap glp :ALEPreviousWrap<CR>

" vim-lsp
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_hint = {'text': '?'}
if executable('clangd')
    " TODO: Add --clang-tidy to arguments? Possibly some clang-tidy-checks=foo?
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
    autocmd FileType c setlocal omnifunc=lsp#complete
    autocmd FileType cpp setlocal omnifunc=lsp#complete
    autocmd FileType objc setlocal omnifunc=lsp#complete
    autocmd FileType objcpp setlocal omnifunc=lsp#complete
endif

nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gi :LspImplementation<CR>
" TODO: Would be awesome if we could get this: nnoremap <silent> gs :CocCommand clangd.switchSourceHeader<CR>
" TODO: Does it auto-insert delimiters? E.g / for filenames (if the dir is foobar/baz then I want to type foo<tab>baz and have it insert the "bar/")
" TODO: Can we configure a min keyword length? We used to use 3
nnoremap <silent> gln :LspNextDiagnostic<CR>
nnoremap <silent> glp :LspPreviousDiagnostic<CR>

" TODO: Status-line diagnostic counts, see source for lightline-ale (its very simple)
" (autocmd/event:) lsp_diagnostics_updated               |lsp_diagnostics_updated|
" lsp#get_buffer_diagnostics_counts()    *lsp#get_buffer_diagnostics_counts()*
" Returns dictionary with keys "error", "warning", "information", "hint".

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
    \   'linter_checking': 'right',
    \   'linter_infos': 'right',
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error',
    \   'linter_ok': 'right',
    \ },
    \ 'component_expand': {
    \   'linter_checking': 'lightline#ale#checking',
    \   'linter_infos': 'lightline#ale#infos',
    \   'linter_warnings': 'lightline#ale#warnings',
    \   'linter_errors': 'lightline#ale#errors',
    \   'linter_ok': 'lightline#ale#ok',
    \ },
    \ }
let g:lightline.active = { 'right': [[ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos']], }

" vim-gitgutter
let g:gitgutter_map_keys = 0

" FZF
let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }
let g:fzf_layout = { 'down': '~25%' }

autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
if executable('rg')
    command! -bang -nargs=? -complete=dir FZFRipgrepFiles
    \   call fzf#vim#files(<q-args>, {
    \   'source': 'rg -F --files --smart-case',
    \   'options': ['--info=inline']
    \}, <bang>0)
endif
nnoremap <C-p> :FZFRipgrepFiles<CR>
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Statement'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Comment'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

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
set spelllang=en_gb " Use Real English :)

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

