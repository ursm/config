source /usr/share/antigen.zsh

antigen use oh-my-zsh

antigen bundle docker
antigen bundle golang
antigen bundle npm
antigen bundle rake-fast
antigen bundle screen
antigen bundle sudo
antigen bundle vundle
antigen bundle z

antigen apply

PROMPT=$'%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[blue]%}%(!.%1~.%~)%{$reset_color%} $(git_prompt_info)\n%{$fg_bold[blue]%}$%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}("

setopt hist_ignore_all_dups
unsetopt correct_all

export PATH=$HOME/bin:$HOME/.nodebrew/current/bin:$PATH
export GOPATH=$HOME
unset RUBYOPT

eval "$(rbenv init -)"
eval "$(direnv hook zsh)"

autoload -Uz zmv
alias zmv='noglob zmv -W'

function peco-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}

zle -N peco-history
bindkey '^[r' peco-history

function peco-src() {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}

zle -N peco-src
bindkey '^[s' peco-src
