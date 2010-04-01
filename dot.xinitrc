#!/bin/sh

export LANG=ja_JP.UTF-8
export GTK_IM_MODULE=uim
export XMODIFIERS=@im=uim

xmodmap $HOME/.Xmodmap
uim-xim &
xbindkeys &
thunar --daemon &
xscreensaver -no-splash &
dropboxd &

exec awesome
