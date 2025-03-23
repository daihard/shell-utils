#!/bin/sh
# sh_detectshell.sh

# Function that checks the type of shell it is run in
# Currently, only Bash and Zsh are supported
detectshell() {
    case $SHELL in
        */bash)
            echo "Bash"
            ;;
        */zsh)
            echo "Zsh"
            ;;
        *)
            echo "Unsupported"
            ;;
    esac
}
