filetype indent plugin on
syntax enable

set encoding=utf-8
set fileencodings=utf-8,cp932,eucjp,iso2022jp
set fileformats=unix,dos,mac

set ambiwidth=double
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set cursorline
set directory-=.
set display=lastline
set hidden
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:»\ 
set mouse=a
set nobackup
set nohlsearch
set number
set ruler
set showcmd
set showmatch
set showmode
set smartcase
set smartindent
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%=%l,%c%v%8p
set tabstop=4 shiftwidth=4
set ttimeoutlen=0
set virtualedit=block
set visualbell t_vb=
set wildmode=list:longest,list:full

if $SHELL =~ '/fish$'
  set shell=zsh
endif

noremap ; :
noremap : ;
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap k gk
noremap gj j
noremap gk k

nnoremap + <C-w>+
nnoremap - <C-w>-
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <M-p> :set paste<CR>
nnoremap <M-n> :set number!<CR>
nnoremap <M-m> :set hlsearch!<CR>
nnoremap gc `[v`]

inoremap <C-l> <Esc>

cnoremap <C-a> <Home>
cnoremap <C-x> <C-r>=expand('%:p:h')<CR>/
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

onoremap gc :<C-u>normal gc<CR>

highlight Pmenu ctermbg=LightGray ctermfg=Black guibg=LightGray guifg=Black
highlight PmenuSel ctermbg=Blue guibg=RoyalBlue
highlight PmenuSbar ctermbg=LightGray guibg=LightGray
highlight PmenuThumb ctermbg=White guibg=White

" 挿入モード時、paste オプションを解除する
autocmd InsertLeave * set nopaste

" 以前開いていたときのカーソル位置を復元する
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" 全角空白と行末の空白の色を変える
highlight WideSpace ctermbg=blue guibg=blue
highlight EOLSpace ctermbg=red guibg=red

function! s:HighlightSpaces()
  syntax match WideSpace /　/ containedin=ALL
  syntax match EOLSpace /\s\+$/ containedin=ALL
endf

call s:HighlightSpaces()
autocmd WinEnter * call s:HighlightSpaces()

" 挿入モード時、ステータスラインの色を変える
autocmd InsertEnter * highlight StatusLine ctermfg=red
autocmd InsertLeave * highlight StatusLine ctermfg=white

" 自動的に QuickFix リストを表示する
autocmd QuickFixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
autocmd QuickFixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin

let g:Align_xstrlen = 3
let g:netrw_altv = 1
let g:vimwiki_home = '~/vimwiki/'
let g:rsenseUseOmniFunc = 1

" FuzzyFinder
let g:fuf_modesDisable = []
let g:fuf_enumeratingLimit = 30
let g:fuf_ignoreCase = 0
let g:fuf_keyOpenSplit = '<C-m>'

nnoremap ,ff :FufBuffer<CR>
nnoremap ,fi :FufFile<CR>
nnoremap ,fd :FufDir<CR>
nnoremap ,fm :FufMruFile<CR>
nnoremap ,fc :FufMruCmd<CR>
nnoremap ,fb :FufBookmark<CR>
nnoremap ,fa :FufAddBookmark<CR>
nnoremap ,ft :FufTag<CR>
nnoremap ,fg :FufTaggedFile<CR>

call pathogen#runtime_append_all_bundles() 
