#!/bin/sh

export LANG=ja_JP.UTF-8
export GTK_IM_MODULE=uim
export XMODIFIERS=@im=uim

xrdb -merge $HOME/.Xresources
xmodmap $HOME/.Xmodmap
uim-xim &
xbindkeys &
urxvtd &
thunar --daemon &
xscreensaver -no-splash &
dropboxd &
wakoopa &

exec awesome
