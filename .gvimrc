autocmd GUIEnter * simalt ~x " Maximize the gVim window on startup

set renderoptions=type:directx " Use DirectX (DirectWrite) for text rendering (looks better than the default on Windows)
set guifont=Consolas:h12 " Set the font and size

set guioptions-=m " Remove the menu bar
set guioptions-=T " Remove the toolbar
set guioptions-=r " Remove the right-hand scroll bar
set guioptions-=l " Remove the left-hand scroll bar
set guioptions-=L " Remove the left-hand scroll bar for vertical splits
set guioptions-=e " Draw tabs using Vim's built-in UI, rather than the native Window UI
set guioptions+=! " When running external commands, draw output in a window inside Vim, rather than a separate console window
