export PATH=$HOME/bin:$HOME/.npm/bin:$PATH:/usr/local/sbin:/usr/sbin:/sbin
export MANPATH=$HOME/.npm/man:$MANPATH
export NODE_PATH=$HOME/.npm/libraries:$NODE_PATH

if which keychain > /dev/null; then
  keychain id_rsa
  source $HOME/.keychain/$HOST-sh
fi
