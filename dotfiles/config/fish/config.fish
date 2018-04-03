set -x PATH $HOME/.anyenv/bin $PATH
source (anyenv init - fish | psub)

set -x FZF_CD_COMMAND 'fd --type directory . $dir'
set -x FZF_CD_WITH_HIDDEN_COMMAND 'fd --type directory --hidden . $dir'
set -x FZF_FIND_FILE_COMMAND 'fd . $dir'
set -x FZF_LEGACY_KEYBINDINGS 0

abbr g git
abbr ap ansible-playbook
abbr be 'bundle exec'
abbr dc docker-compose
