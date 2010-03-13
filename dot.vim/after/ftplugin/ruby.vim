if exists('b:did_ftplugin_ruby_after')
  finish
endif

let b:did_ftplugin_ruby_after = 1

setlocal tabstop=3 shiftwidth=3 noexpandtab

" surround.vim
let b:surround_{char2nr('%')} = "%(\r)"
let b:surround_{char2nr('w')} = "%w(\r)"
let b:surround_{char2nr('#')} = "#{\r}"
let b:surround_{char2nr('g')} = "begin \r end"
let b:surround_{char2nr('i')} = "if \1if\1 \r end"
let b:surround_{char2nr('u')} = "unless \1unless\1 \r end"
let b:surround_{char2nr('c')} = "class \1class\1 \r end"
let b:surround_{char2nr('m')} = "module \1module\1 \r end"
let b:surround_{char2nr('d')} = "def \1def\1\2args\r..*\r(&)\2 \r end"
let b:surround_{char2nr('p')} = "\1method\1 do \2args\r..*\r|&| \2\r end"
let b:surround_{char2nr('P')} = "\1method\1 {\2args\r..*\r|&|\2 \r }"
