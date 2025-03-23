#!/bin/sh

if [ -f ~/.sh_detectshell ]; then
    . ~/.sh_detectshell
fi

detectshell
echo $1
