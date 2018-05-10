set --export PATH $HOME/bin $HOME/.anyenv/bin $HOME/.yarn/bin $PATH
set --export GOPATH $HOME

source (anyenv init - fish | psub)
eval (direnv hook fish)

set --export FZF_DEFAULT_COMMAND 'fd --type file'
set FZF_FIND_FILE_COMMAND "$FZF_DEFAULT_COMMAND . \$dir"

set FZF_CD_COMMAND 'fd --type directory . $dir'
set FZF_CD_WITH_HIDDEN_COMMAND 'fd --type directory --hidden . $dir'
set FZF_LEGACY_KEYBINDINGS 0
set fish_greeting ''

abbr b bundle
abbr g git
abbr ap ansible-playbook
abbr be bundle exec
abbr dc docker-compose
