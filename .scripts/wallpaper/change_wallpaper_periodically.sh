#!/bin/bash
# description: change wallpaper periodically
# file: change_wallpaper_periodically.sh
# author: StableGenius
# mail: feng@dongfa.pro
# date: 2021-09-02

while true; do
  feh --bg-fill --no-fehbg --randomize ~/.feh/*
  sleep 300
done

