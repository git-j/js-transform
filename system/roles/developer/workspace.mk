include $(realpath $(dir $(lastword $(MAKEFILE_LIST)))/../rde_vars.mk)

OBE_DEBUG:=debug
OBE=${ROOT}system/sys/obe/
CONSOLE=con
buildshell=./usr/share/obe/proc/buildshell
PWD=`pwd`
OSTYPE=`uname -s`-`uname -m`
INSTALL_DIR:=${ROOT}var/install-${OSTYPE}/
CXXFLAGS=" -fno-stack-protector"
ce_specimen=
ROLE=developer
git_status=(git status;git status -s | sed 's|...\(.*\)$$|git add \1|'; git status -s | sed 's|...\(.*\)$$|\# git checkout \1|';)
#git status -s | sed 's|...\(.*\)$$|git add \1|';git status -s | sed 's|...\(.*\)$$|#git checkout \1|'`

.PHONY: $(subdirs) all help manage 
.PHONY: oshell oscript checkdb
.PHONY: developer_edit developer_build developer_install developer_clean
.PHONY: edit build install clean
.PHONY: rebuild
$(subdirs):
	cd $@ && $(MAKE) $(ROLE)_$(ACTION)

#:# recursive actions
%edit: export ACTION=edit
%build: export ACTION=build
%install: export ACTION=install
%clean: export ACTION=clean

developer_edit: $(subdirs)
developer_build: $(subdirs)
developer_install: $(subdirs)
developer_clean: $(subdirs)
edit: developer_edit        # start a editor
build: developer_build      # build binaries
install: developer_install  # install binaries for debugging
clean: developer_clean      # clean all binaries


all: help

#:# useful actions

help: # print available commands
	@echo available commands: ${ROLEPATH}
	@cat ${ROOT}${ROLEPATH}/workspace.mk | grep :.*# | grep -v '@cat' |sed 's|:\(.*\)\#\(.*\)|: \2: \1|'| awk -F':' '{printf "\033[0;32m%-10s\033[00m %s \033[01;32m%s\033[00m\n", $$1, $$2, $$3}'
	@echo == local ==
	@cat $(PWD)/Makefile | grep : | grep -v '@cat' |sed 's|:\(.*\)\#\(.*\)|: \2: \1|'| awk -F':' '{printf "\033[0;32m%-20s\033[00m %s \033[01;32m%s\033[00m\n", $$1, $$2, $$3}'|| echo 'no local commands'

rebuild: # rebuild all binaries
	make clean
	make build


oshell: # makes a oshell in DB with SCRIPT
	export MAKEPWD=$(PWD) && export INSTALL_DIR=${INSTALL_DIR} && cd ${ROOT}/${sysdir} && pwd && ./oshell-workspace "${DB}" "${SCRIPT}" "${DICT}" "${DICT_CTX}"

oscript: # makes a oscript in DB with SCRIPT
	export MAKEPWD=$(PWD) && export INSTALL_DIR=${INSTALL_DIR} && cd ${ROOT}/${sysdir} && pwd && ./oscript-workspace "${DB}" "${SCRIPT}" "${DICT}" "${DICT_CTX}" "${RES}" "${DEBUG}"

checkdb: # makes a oscript in DB with SCRIPT
	@echo to repair prefix CHECKDB_REPAIR
	export MAKEPWD=$(PWD) && cd ${ROOT}${sysdir} && pwd && ./checkdevdb ${DB}

runtimelog: # starts a midnight commander in the currend directory
	cd ${ROOT}/${sysdir} && CON_GEOM="135x10+730+10" ${CONSOLE} "tail -f var/log/odaba/error.lst" &

manage: # starts a midnight commander in the currend directory
	test -d manage || CON_GEOM="135x43+430+10" ${CONSOLE} "mc" &


.PHONY:scm
scm: # guides through the repositories
	@echo " -- scm --"
	@echo " this make targed spawns a bash for each repository and displays the current status"
	@echo "common commands:"
	@echo " git pull         syncronize the repository"
	@echo " git commit -m '' commit your changes to the local repository"
	@echo " git push         upload your commits to the master"
	@echo " git diff | colordiff"
	@echo " git diff ORIG_HEAD"
	
	@echo "---"
	@echo "system (obe, build/edit tools)"
	@cd ${ROOT}/system/ && $(git_status) && PS1="\[\033[0;32m\]scm:system: \[\033[01;32m\]\u@\h\[\033[01;34m\] \w \n\$$\[\033[00m\]" ${SHELL}
	@echo "workspaces (sources)"
	@cd ${ROOT}/workspaces && $(git_status) && PS1="\[\033[0;32m\]scm:ws: \[\033[01;32m\]\u@\h\[\033[01;34m\] \w \n\$$\[\033[00m\]" ${SHELL}
	@echo odaba
	@cd ${ROOT}/workspaces/auxiliary/odaba && $(git_status) && PS1="\[\033[0;32m\]scm:odaba: \[\033[01;32m\]\u@\h\[\033[01;34m\] \w \n\$$\[\033[00m\]" ${SHELL}
	@echo scm done
