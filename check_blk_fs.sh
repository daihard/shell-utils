#!/usr/bin/env bash

# Checks the underlying file system of a device mounted via
# FUSE

file_path=${1}

lsblk -no name,fstype,mountpoint "$(findmnt --target "$file_path" -no SOURCE)"
