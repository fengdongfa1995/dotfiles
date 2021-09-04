#!/bin/bash
LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

while true
do
	bash "$DIR/dwm-status-refresh.sh"
	sleep 2
done
