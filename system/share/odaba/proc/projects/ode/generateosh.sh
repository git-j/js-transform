#!/bin/bash

# this is changed during install
datarootdir=./share
localstatedir=./var
sysconfdir=./etc

. ${datarootdir}/odaba/proc/shelltools.sh
. ${datarootdir}/odaba/proc/proc/startup.sh

# uses the oshell to generate a oshell script

SOURCE_DAT=$1
targetpath=$2
tmposh=$(mktemp /tmp/generate.osh.XXXXXXXX)
tmposh2=$(mktemp /tmp/generate.osh.XXXXXXXX)
tmpini=$(mktemp /tmp/edit_project_path.ini.XXXXXXXX)
# edit template osh
cat ${datarootdir}/share/odaba/osh/generateosh.tpl.osh | sed 's|//.*||' > ${tmposh}
# edit inifile
initemplate generateosh.tpl.ini > ${tmpini}

# debug: display the edited osh
# echo "template generator" ; cat ${tmposh}
# echo "template ini"; cat ${tmpini}

# run the edited osh and grep out stuff the oshell writes
# and edit the generated code
OShell ${tmpini} ${tmposh} \
    | grep -v "^ >\|^ODABA\|^log:" \
    | sed "s|\\\\|/|g" \
    | sed "s|proj_path=.*|proj_path='${targetpath}'|g" > ${tmposh2}

# debug : display the generated osh
# echo "template" ; cat ${tmposh2}

# run the result of the generator
OShell ${tmpini} ${tmposh2}

# clean up
rm ${tmpini}
rm ${tmposh}
rm ${tmposh2}

