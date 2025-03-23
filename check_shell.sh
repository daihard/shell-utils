#!/bin/sh

if [ -f ~/.sh_detectshell ]; then
    . ~/.sh_detectshell
fi

shell=$(detectshell)

if [ "$shell" == "Bash" ]; then
    Echo "This is Bash!"
elif [ "$shell" == "Zsh" ]; then
    Echo "This is Zsh!"
else
    exit 1
fi
