#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# proxy setting in WSL2
host=$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')
port=10809

alias proxy_up='export all_proxy=http://${host}:${port}'
alias proxy_down='unset all_proxy'
