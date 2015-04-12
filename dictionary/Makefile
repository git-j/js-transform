ROOT=..
subdirs=
ifneq ($(ROLEPATH),)
include ${ROOT}/${ROLEPATH}/workspace.mk
endif
DB=$(shell pwd)/js-transform.dictionary
DICT=${ROOT}/system/share/odaba/ode.sys

pack:
	$(ROOT)/system/bin/copydb-js-transform
# make ce
ce:
	cd ${ROOT}/system/bin && x_otool_tool=ce ./otool ${DB} &