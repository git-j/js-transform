#!/bin/bash

# this is changed during install
datarootdir=/data/sys/odaba-10.1.0//usr/share
localstatedir=/data/sys/odaba-10.1.0//var
sysconfdir=/data/sys/odaba-10.1.0//etc

. ${datarootdir}/odaba/proc/shelltools.sh
. ${datarootdir}/odaba/proc/proc/startup.sh

# updates the project path of a development database to a useful root
TARGET_DAT=$1
targetpath=$2
export targetpath;
# export to use variable in oshell
tmpini=$(mktemp /tmp/edit_project_path.ini.XXXXXXXX)
tmposh=$(mktemp /tmp/edit_project_path.osh.XXXXXXXX)

initemplate ode/edit_project_path.tpl.ini > ${tmpini}
cat ${datarootdir}/odaba/osh/update_project_path.osh | sed "s|%targetpath%|${targetpath}|" > ${tmposh}
OShell ${tmpini} ${tmposh}
cat ${tmpini}
cat ${tmposh}
rm ${tmpini}
rm ${tmposh}

