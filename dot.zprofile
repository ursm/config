if which keychain > /dev/null; then
  keychain id_rsa id_ecdsa
  source $HOME/.keychain/$HOST-sh
fi
