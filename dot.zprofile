export PATH=$HOME/bin:$PATH
export DE=gnome

if which keychain > /dev/null; then
  keychain id_rsa
  source $HOME/.keychain/$HOST-sh
fi
