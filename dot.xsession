#!/bin/sh

# run all system xinitrc shell scripts.
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for i in /etc/X11/xinit/xinitrc.d/* ; do
    if [ -x "$i" ]; then
      . "$i"
    fi
  done
fi

export LANG=ja_JP.UTF-8
export GTK_IM_MODULE=uim
export XMODIFIERS=@im=uim
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus

xbindkeys &
xscreensaver -no-splash &
uim-xim &
dhcpcd-gtk &
dropboxd &
unclutter -keystroke -noevents &
xcompmgr -n &
gnome-do &
#ibus-daemon -d -x

exec awesome
