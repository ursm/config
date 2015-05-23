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
