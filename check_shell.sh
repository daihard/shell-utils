#!/bin/sh

# Get the parent process name
parent_shell=$(ps -o comm= -p $PPID)

# Detect the shell
case $parent_shell in
    bash)
        echo "Running in Bash."
        ;;
    zsh)
        echo "Running in Zsh."
        ;;
    ksh)
        echo "Running in KornShell (ksh)."
        ;;
    *)
        echo "Running in an unknown or unsupported shell: $parent_shell"
        ;;
esac
