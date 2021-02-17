#!/bin/sh

#        -lf/nf/cf color
#            Defines the foreground color for low, normal and critical notifications respectively.
# 
#        -lb/nb/cb color
#            Defines the background color for low, normal and critical notifications respectively.
# 
#        -lfr/nfr/cfr color
#            Defines the frame color for low, normal and critical notifications respectively.

[ -f "$HOME/.cache/wal/colors.sh" ] && . "$HOME/.cache/wal/colors.sh" ]

pidof dunst && killall dunst

dunst -lf  "${color7:-#ffffff}" \
      -lb  "${color0:-#eeeeee}" \
      -lfr "${color3:-#dddddd}" \
      -nf  "${color7:-#cccccc}" \
      -nb  "${color0:-#bbbbbb}" \
      -nfr "${color3:-#aaaaaa}" \
      -cf  "${color7:-#999999}" \
      -cb  "${color0:-#888888}" \
      -cfr "${color3:-#777777}" > /dev/null 2>&1 &
