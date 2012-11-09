set nocompatible
filetype off

set runtimepath&
set runtimepath+=~/.vim/bundle/vundle/

call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'EnhCommentify.vim'
Bundle 'Rename'
Bundle 'matchit.zip'
Bundle 'twilight256.vim'
Bundle 'vimwiki'

Bundle 'csexton/trailertrash.vim'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'ervandew/supertab'
Bundle 'h1mesuke/vim-alignta'
Bundle 'jpo/vim-railscasts-theme'
Bundle 'kana/vim-textobj-entire'
Bundle 'kana/vim-textobj-indent'
Bundle 'kana/vim-textobj-jabraces'
Bundle 'kana/vim-textobj-user'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kenchan/rubyblue'
Bundle 'kien/ctrlp.vim'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'pangloss/vim-javascript'
Bundle 'plasticboy/vim-markdown'
Bundle 'taq/vim-rspec'
Bundle 'thinca/vim-ref'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-ruby/vim-ruby'

filetype plugin indent on

syntax enable
colorscheme twilight256

set encoding=utf-8
set fileencodings=utf-8,cp932,eucjp,iso2022jp,utf-16
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
set expandtab tabstop=2 shiftwidth=2
set t_Co=256
set ttimeoutlen=0
set virtualedit=block
set visualbell t_vb=
set wildmode=list:longest,list:full
set expandtab tabstop=2 shiftwidth=2

if $SHELL =~ '/fish$'
  set shell=zsh
endif

noremap ; :
noremap : ;
noremap <silent> j gj
noremap <silent> k gk
noremap <silent> gj j
noremap <silent> gk k

nnoremap + <C-w>+
nnoremap - <C-w>-

cnoremap <C-a> <Home>
cnoremap <C-x> <C-r>=expand('%:p:h')<CR>/
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

highlight Pmenu ctermbg=LightGray ctermfg=Black guibg=LightGray guifg=Black
highlight PmenuSel ctermbg=Blue guibg=RoyalBlue
highlight PmenuSbar ctermbg=LightGray guibg=LightGray
highlight PmenuThumb ctermbg=White guibg=White

let g:ctrlp_map = '<Esc>t'
let g:netrw_altv = 1
let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]

augroup MyAutoCmd
  autocmd!

  " 挿入モード時、paste オプションを解除する
  autocmd InsertLeave * set nopaste

  " 以前開いていたときのカーソル位置を復元する
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

  " 挿入モード時、ステータスラインの色を変える
  autocmd InsertEnter * highlight StatusLine ctermfg=red
  autocmd InsertLeave * highlight StatusLine ctermfg=white

  " 自動的に QuickFix リストを表示する
  autocmd QuickFixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
  autocmd QuickFixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin

  if !has('gui_running') && !(has('win32') || has('win64'))
    " .vimrcの再読込時にも色が変化するようにする
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
  else
    " .vimrcの再読込時にも色が変化するようにする
    autocmd BufWritePost $MYVIMRC source $MYVIMRC | if has('gui_running') | source $MYGVIMRC
    autocmd BufWritePost $MYGVIMRC if has('gui_running') | source $MYGVIMRC
  endif
augroup END
