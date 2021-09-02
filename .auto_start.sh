#! /bin/bash
# description: do something while X-window starts
# file: ~/.auto_start.sh
# author: StableGenius
# mail: feng@dongfa.pro
# date: 2021-09-02

# download a new wallpaper from bing.com
python ~/.scripts/wallpaper/bing_today_wallpaper_crawler.py

# change wallpaper periodically
bash ~/.scripts/wallpaper/change_wallpaper_periodically.sh

# start input method
fcitx

# power manager
mate-power-manager
