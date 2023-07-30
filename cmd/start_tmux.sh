#!/bin/bash
which tmux > /dev/null 2>&1
if [ $? -eq 0 ] && [ -z $TMUX ] && [ "$TERM_PROGRAM" != 'vscode' ]; then
    if $(tmux has-session 2> /dev/null); then
        tmux -2 attach
    else
        tmux -2 new-session -s main
    fi
fi
