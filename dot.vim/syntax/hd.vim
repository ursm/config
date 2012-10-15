" Vim syntax file
" Language:         HikiDoc
" Maintainer:       HARA, Yutaka (yhara/at/kmc.gr.jp)
" URL:              http://mono.kmc.gr.jp/~yhara/
" Latest Revision:  ?
" arch-tag:         ?

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword hdTodo      contained TODO FIXME XXX NOTE
syn region  hdHeader    start='^!' end='$'
syn region  hdPaste     start='<<<' end='>>>'
syn region  hdPasteLine start='^ ' end='$'
syn region  hdItemize   start='^*' end='$'
syn region  hdEnumerate start='^#' end='$'
syn region  hdDescription start='^:' end=':'
syn region  hdHref        start='\[\[' end='\]\]'


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_hd_syn_inits")
  if version < 508
    let did_hd_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink hdHeader           Type
  "HiLink hdPasteLine       Comment
  HiLink hdPaste            Comment
  HiLink hdItemize          String
  HiLink hdEnumerate        String
  HiLink hdHref     Underlined
  HiLink hdDescription      Underlined
  HiLink hdTodo             Todo

"  HiLink hdComment         Comment
"  HiLink hdDocumentEnd      PreProc
"  HiLink hdDirective       Keyword
"  HiLink hdNodeProperty   Type
"  HiLink hdAnchor          Type
"  HiLink hdAlias           Type
"  HiLink hdDelimiter       Delimiter
"  HiLink hdBlock           Operator
"  HiLink hdOperator        Operator
"  HiLink hdKey     Identifier
"  HiLink hdString          String
"  HiLink hdEscape          SpecialChar
"  HiLink hdSingleEscape   SpecialChar
"  HiLink hdNumber          Number
"  HiLink hdConstant        Constant
"  HiLink hdTimestamp       Number

  delcommand HiLink
endif

let b:current_syntax = "hd"

" vim: set sts=2 sw=2:

