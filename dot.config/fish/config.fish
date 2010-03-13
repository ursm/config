#set -l paths ~/.gem/ruby/1.8/bin /opt/bin /opt/gentoo/usr/sbin /opt/gentoo/sbin /usr/sbin /sbin $PATH
#eval set -x PATH (eval array-unique (select-exist-path $paths))

set -x LANG ja_JP.UTF-8
set -x EDITOR vim
set -x PAGER lv
set -x LV '-lc -Ou8'
set -x PYTHONPATH ~/.hgext $PYTHONPATH
set -x PYTHONSTARTUP ~/.pythonrc
set -x VTE_CJK_WIDTH 1

set BROWSER (find-exist-command open firefox w3m)

if which keychain >&- ^&-
  keychain id_rsa
  . ~/.keychain/(hostname)-fish
end

cdd_init

#alias b bzr
