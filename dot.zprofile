export PATH=$HOME/bin:$PATH
export DE=gnome

if which keychain > /dev/null; then
  keychain id_rsa id_ecdsa
  source $HOME/.keychain/$HOST-sh
fi
