#!/usr/bin/env bash
# linux/my_work.sh

[ -f /etc/os-release ] || { echo "/etc/os-release is needed to process this file" >&2; exit 1; }

source /etc/os-release

if [ "$ID" == "ubuntu" ]; then
    script_dir=$(dirname "$(readlink -f "$BASH_SOURCE")")
    source ${script_dir}/linux/my_work_ubuntu.sh
fi
