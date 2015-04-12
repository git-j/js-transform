#!/bin/bash
# common startup for otools to ensure that errors are available

# this is changed during install
test "${datarootdir+set}" ||
datarootdir=./share
test "${localstatedir+set}" ||
localstatedir=./var
test "${sysconfdir+set}" ||
sysconfdir=./etc
test "${libdir+set}" ||
libdir=./lib
test "${bindir+set}" ||
bindir=./lib/odaba/tools

logdir=${localstatedir}/log/odaba
if [ -z "${TRACE}" ]; then
    TRACE=${logdir}
    export TRACE
fi
mkdir -p ${TRACE}
echo log: ${TRACE}

LD_LIBRARY_PATH=${libdir}:${LD_LIBRARY_PATH}
PATH=${bindir}:${libdir}/odaba/tools:${PATH}
export LD_LIBRARY_PATH
export PATH

#the ini-files may contain variables
export datarootdir
export localstatedir
export sysconfdir
export libdir
export bindir