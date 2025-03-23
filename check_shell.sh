#!/bin/sh

## check_shell() {
##     # Detect the shell
##     parent_shell=$(ps -o comm= -p $PPID)
## 
##     case $parent_shell in
##         bash)
##             echo "Bash"
##             ;;
##         -zsh)
##             echo "Zsh"
##             ;;
##         *)
##             echo "Unsuported"
##             ;;
##     esac
## }
## 
#
checkshell
echo $1
