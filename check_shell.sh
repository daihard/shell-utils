#!/bin/sh

# Get the parent process name
parent_shell=$(ps -o comm= -p $PPID)

echo $parent_shell

