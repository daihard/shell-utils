#!/usr/bin/env bash
# linux/my_work_ubuntu.sh

# Fail if this file is used on a non-macOS platform
[ "$(uname -s)" = "Linux" ] || { echo "Linux required" >&2; exit 1; }

source /etc/os-release
[ "$ID" = "ubuntu" ] || { echo "Ubuntu required" >&2; exit 1; }

export WIN_LOGIN=dtoyama

JDK6_HOME=/opt/java/jdk1.6.0_45
JDK7_HOME=/opt/java/jdk1.7.0_67
JDK8_HOME=/opt/java/jdk1.8.0_231

if [ "$JAVA_HOME" = "" ]; then
    export JAVA_HOME=${JDK8_HOME}
fi

export JDK8_HOME
## export JAVA_COMPILER=$JAVA_HOME/bin/javac
## export PATH=$JAVA_HOME/bin:$PATH

##export CC=clang
##export CXX=clang++
export CC=gcc
export CXX=g++

## JDK stuff for RDM/RDMs
export JDK=${JDK6_HOME}
export JDKOS=linux
## export BUILD_JAR=1

# RDM Server
export RDSHOME=/home/dtoyama/rdms/pilot
export RDMS_DEBUG_BUILD=1
export RDS_QTDIR=/opt/qt3/x86_64
export RDS_QTDIR_32=/opt/qt3/i386
export CONNPATH=${HOME}/.rdmserver
##export BLDHOME=/${HOME}/rdms/84
export PLATFORMID=lnxamd64t
export RDSLOGIN="localhost;admin;secret"

RDSPATH=/home/dtoyama/rds-lnxamd64t-8.4.781
export CATPATH=$RDSPATH/catalog
export LD_LIBRARY_PATH=$RDSPATH/bin:$RDS_QTDIR/lib

# RDM Embedded
export RDM_CURRENT_VER=newport ## my own stuff...
export RDME_DEBUG_BUILD=1
#export RDME_HOME=${HOME}/rdm/91

# PC-Lint
export LINT_ROOT=/usr/local/etc/flint

