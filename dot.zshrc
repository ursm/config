export BROWSER=chromium
export DE=xfce
export EDITOR='vim'
export GREP_COLOR='01;34'
export GREP_OPTIONS='--color=auto'
export HGENCODING=utf-8
export LANG=en_US.UTF-8
export LS_COLORS='di=01;34:ln=32:ex=35'
export LV="-lc -Ou8"
export PYTHONPATH=$HOME/.hgext:$PYTHONPATH
export PYTHONSTARTUP=$HOME/.pythonrc

unset RUBYOPT

alias v='vim'
alias g="git"
alias b="bzr"

alias ls='ls -F --color=auto'
alias ll='ls -lh'
alias la='ll -a'
alias tf='tail -f'
alias psa='ps aux'
alias reload='source $ZDOTDIR/.zshrc'
alias mq='hg -R .hg/patches'
alias ql="qlmanage -p $@ >& /dev/null"
alias pmerge="sudo pump emerge -av"
alias be="bundle exec"
alias bo="bundle open"

alias -g L="| $PAGER"
alias -g S='`xclip -o`'
alias -g P='`xclip -o -selection clipboard`'
alias -g C='| xclip -selection clipboard'

function psg() {
  psa | head -n 1
  psa | grep $* | grep -v "ps aux" | grep -v grep
}

function refe() { command refe $@ | iconv -f euc-jp -t utf-8 }
function href() { command href $@ | iconv -f euc-jp -t utf-8 }

bindkey -e

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# prompt
setopt prompt_subst
autoload colors; colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b] (%a)'

precmd () {
    psvar=()
    vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT=$'%B%F{green}%n@%M%f %F{blue}%~%f%b%1(v| %F{green}%1v%f|)\n%B%F{blue}$%f%b '

# completion
fpath=($HOME/.zsh/functions $fpath)
autoload -U compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# cdd
autoload cdd; cdd > /dev/null

function chpwd() {
  ls
  _reg_pwd_screennum
}

# history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history
setopt extended_history

HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=100000

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# zmv
autoload zmv
alias zmv='noglob zmv -W'
alias zcp='zmv -C'
alias zln='zmv -L'

# options
setopt always_to_end
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_pushd
setopt auto_remove_slash
setopt complete_in_word
setopt extended_glob
setopt glob_complete
setopt glob_dots
setopt interactive_comments
setopt list_types
setopt long_list_jobs
setopt magic_equal_subst
setopt no_check_jobs
setopt no_flow_control
setopt nolistbeep
setopt pushd_ignore_dups
setopt zle

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
