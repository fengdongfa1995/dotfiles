#! /bin/bash
# description: do something while X-window starts
# file: ~/.auto_start.sh
# author: StableGenius
# mail: feng@dongfa.pro
# date: 2021-09-02

# change wallpaper periodically
bash ~/.scripts/wallpaper/change_wallpaper_periodically.sh &

# power manager
mate-power-manager &

# download a new wallpaper from bing.com
python ~/.scripts/wallpaper/bing_today_wallpaper_crawler.py &

# input method
fcitx &

# alpha terminal 
# sudo pacman -S picom
picom &

# proxy
qv2ray &

# status bar 
slstatus &
