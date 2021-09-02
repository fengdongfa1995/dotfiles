[[ -f ~/.xprofile ]] && source ~/.xprofile
[[ -f ~/.auto_start.sh ]] && bash ~/.auto_start.sh &
exec dwm
