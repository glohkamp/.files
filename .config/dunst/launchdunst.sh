#!/bin/sh

#        -lf/nf/cf color
#            Defines the foreground color for low, normal and critical notifications respectively.
# 
#        -lb/nb/cb color
#            Defines the background color for low, normal and critical notifications respectively.
# 
#        -lfr/nfr/cfr color
#            Defines the frame color for low, normal and critical notifications respectively.

source "${HOME}/.cache/wal/colors.sh"

[ -f "$HOME/.cache/wal/colors.sh" ] && . "$HOME/.cache/wal/colors.sh" ]

launch_dunst() {
	pidof dunst && killall dunst

	dunst -lf  "${color1:-#ffffff}" \
    	  -lb  "${color0:-#eeeeee}" \
     	  -lfr "${color3:-#dddddd}" \
      	  -nf  "${color1:-#cccccc}" \
      	  -nb  "${color0:-#bbbbbb}" \
      	  -nfr "${color3:-#aaaaaa}" \
      	  -cf  "${color1:-#999999}" \
      	  -cb  "${color0:-#888888}" \
      	  -cfr "${color3:-#777777}" > /dev/null 2>&1 &
}

set_gtk() {

    background="$color0"
    background=${background:1}
    foreground="$color1"
    foreground=${foreground:1}

    oomoxconf="/tmp/autotheme"

    cat << HEREDOC > $oomoxconf
    NAME="autotheme"
    BG=$background
    FG=$foreground
    TXT_BG=$background
    TXT_FG=$foreground
    MENU_BG=$background
    MENU_FG=$foreground
    SEL_BG=$foreground
    SEL_FG=$background
    BTN_BG=$background
    BTN_FG=$foreground
HEREDOC

    oomox-cli $oomoxconf
    icon.sh "#$foreground"

    sed -i 's/-/_/g' ~/.gtkrc-2.0
    . ~/.gtkrc-2.0 2>&1
    rm ~/.gtkrc-2.0

    gtk_theme_name=oomox-$(basename $oomoxconf)
    gtk_icon_theme_name=acyl
    gtkvars=(theme-name icon-theme-name font-name cursor-theme-name cursor-theme-size toolbar-style toolbar-icon-size button-images menu-images enable-event-sounds enable-input-feedback-sounds xft-antialias xft-hinting xft-hintstyle xft-rgba)

    for i in "${gtkvars[@]}"; do
        value="$(eval echo \$`echo gtk-$i | sed 's/-/_/g'`)"
        echo "gtk-$i=\"$value\"" >> ~/.gtkrc-2.0
    done

    gtkrc-reload
}

main() {
	launch_dunst &
	set_gtk&
}

main > /dev/null 2>&1
