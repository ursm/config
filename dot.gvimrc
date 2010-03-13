colorscheme bensday

set guioptions-=aegimrLtT
set t_vb=

highlight CursorLine guibg=gray20

if has('gui_gtk')
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 8
end

if has('gui_macvim')
  set imdisable
  set transparency=5
end
