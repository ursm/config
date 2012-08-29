colorscheme railscasts

set guioptions-=aegimrLtT
set guicursor=a:blinkon0
set t_vb=

highlight CursorLine guibg=gray20

if has('gui_gtk')
  set guifont=Monospace\ 10
end

if has('gui_macvim')
  set transparency=5
end
