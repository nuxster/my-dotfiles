#!/usr/bin/bash

revert() {
  xset dpms 0 0 0
}

trap revert HUP INT TERM
xset +dpms dpms 5 5 5
#dm-tool lock
i3lock -c 000000 -n
revert
