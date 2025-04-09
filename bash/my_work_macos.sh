#!/usr/bin/env bash

# Fail if this file is used on a non-macOS platform
[ "$(uname -s)" = "Darwin" ] || { echo "macOS required" >&2; exit 1; }

# Java stuff
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home"
export JAVA_INCLUDE_PATH=${JAVA_HOME}/include
export JAVA_INCLUDE_PATH2=${JAVA_HOME}/include/darwin
export JAVA_AWT_LIBRARY=$JAVA_HOME/lib/libawt.dylib
export JAVA_JVM_LIBRARY=$JAVA_HOME/lib/server/libjvm.dylib
