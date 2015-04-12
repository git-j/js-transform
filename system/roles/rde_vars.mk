RDE_ROLEPATH=system/roles/$(ROLE)

# find RDE_BASEDIR
ifeq ($(RDE_BASEDIR),)
RDE_BASEDIR=$(realpath $(dir $(lastword $(MAKEFILE_LIST)))/../..)
endif
RDE_BASEDIR:=$(realpath $(RDE_BASEDIR))
ifeq ($(RDE_BASEDIR),)
$(exit invalid basedir)
endif

RDE_WORKSPACEDIR?=$(RDE_BASEDIR)/workspaces
RDE_LOCALSTATEDIR?=$(RDE_BASEDIR)/var

RDE_SYSTEMDIR?=$(RDE_BASEDIR)/system
RDE_BINDIR?=$(RDE_SYSTEMDIR)/bin
RDE_CONFIGDIR?=$(RDE_SYSTEMDIR)/etc
RDE_ODESTATEDIR?=$(RDE_SYSTEMDIR)/var
#RDE_OSTYPE=$(OSTYPE:-$(uname -s))-$(uname -m)
RDE_OSTYPE?=$(shell uname -s)-$(shell uname -m)

ifneq ( $(filter linux-gnu-x86_64 Linux-x86_64, $(RDE_OSTYPE)), )
	RDE_SYSBINDIR?=$(RDE_SYSTEMDIR)/sys/gentoo64/bin
	RDE_SYSLIBDIR?=$(RDE_SYSTEMDIR)/sys/gentoo64/lib
else ifneq ( $(filter linux-gnu-i686 Linux-i686, $(RDE_OSTYPE)), )
	RDE_SYSBINDIR?=$(RDE_SYSTEMDIR)/sys/ubuntu32/bin
	RDE_SYSLIBDIR?=$(RDE_SYSTEMDIR)/sys/ubuntu32/lib
else ifneq ( $(filter windows%, $(RDE_OSTYPE)), )
	RDE_SYSBINDIR?=$(RDE_SYSTEMDIR)/sys/windows
	RDE_SYSLIBDIR=$(RDE_SYSTEMDIR)/sys/windows
else
	RDE_SYSBINDIR?=$(RDE_SYSTEMDIR)/sys/$RDE_OSTYPE/bin
	RDE_SYSLIBDIR?=$(RDE_SYSTEMDIR)/sys/$RDE_OSTYPE/lib
endif
RDE_INSTALLDIR?=$(RDE_LOCALSTATEDIR)/install-$(RDE_OSTYPE)

export $(filter RDE_%, $(.VARIABLES))

LD_LIBRARY_PATH:=$(RDE_SYSLIBDIR)$(if $(LD_LIBRARY_PATH),:)$(LD_LIBRARY_PATH)
export LD_LIBRARY_PATH

sysdir=system/bin
RDE_DIR=$(RDE_BASEDIR)
export RDE_DIR sysdir
