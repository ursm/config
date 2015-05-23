#!/bin/bash

for path in $(find files/home -type f -printf "%P\n"); do
  cp ~/$path files/home/$path
done
