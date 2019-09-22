#!/usr/bin/env bash

[[ $TERM != "screen" ]] && exec tmux

source ~/.exports
source ~/.alias
source ~/.functions
source ~/.bash_prompt

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
