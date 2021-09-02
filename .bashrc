#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias proxy_up='export all_proxy=http://127.0.0.1:8889'
alias proxy_down='unset all_proxy'
