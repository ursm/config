let s:colors = ['snow', '#ff4444', '#44dd44', '#ffaa44']
let s:i = 0

function! s:ToggleBgcolor()
  let color = s:colors[s:i]
  exe 'highlight Normal guibg=' . color
  exe 'highlight NonText guibg=' . color
  let s:i = (s:i + 1) % len(s:colors)
endfunction

command! TDDToggle call s:ToggleBgcolor()

nmap ,t :TDDToggle<CR>
