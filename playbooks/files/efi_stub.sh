#!/bin/sh

set -e

if [ ! -d /boot/efi ]; then
  exit 0
fi

if ! mountpoint /boot/efi > /dev/null; then
  mount /boot/efi
fi

install --backup=simple --suffix=.old --verbose $2 /boot/efi/efi/boot/bootx64.efi
