ifneq ($(COMSPEC),)
  HOST_OS ?= MSDOS
endif

ifeq ($(HOST_OS),MSDOS)
  TARGET_OS = MSDOS
  RM = deltree /y
  CP = rem cp
else
  TARGET_OS =
  RM = rm -f --
  CP = cp --
endif

ifeq ($(TARGET_OS),MSDOS)
  CC = i586-pc-msdosdjgpp-gcc
  E = .exe
  O = obj
  PCILIB =
else
  CC = gcc
  E =
  O = o
  PCILIB = -lpci -lz
endif

CFLAGS = -O3 -g -Wall -std=gnu99

version := $(shell grep VERSION version.h | sed -re 's/^.*"([^"]+)".*$$/\1/')

cc_dump_mach := $(shell $(CC) -dumpmachine)
target_arch   = $(firstword $(subst -, ,$(cc_dump_mach)))

TAR_PREFIX  = gha-practice-$(version)
TAR_SRC     = $(TAR_PREFIX)-src.tar.gz 
TAR_LINUX   = $(TAR_PREFIX)-linux-$(target_arch).tar.gz
TAR_MSDOS   = $(TAR_PREFIX)-msdos.tar.gz
TAR_TARGETS = $(TAR_SRC) \
		$(if $(subst MSDOS,,$(TARGET_OS)),$(TAR_MSDOS),$(TAR_LINUX))


dstr = $(shell date)

all:
	echo "make all: TARGET_OS = $(TARGET_OS)"

make fullrelease:
	echo "make fullrelease"
	echo '$(TAR_PREFIX)-src.tar.gz $(dstr)' > '$(TAR_PREFIX)-src.tar.gz'
	echo '$(TAR_PREFIX)-linux-$(target_arch).tar.gz $(dstr)' > \
		'$(TAR_PREFIX)-linux-$(target_arch).tar.gz'
	echo '$(TAR_PREFIX)-msdos.tar.gz $(dstr)' > '$(TAR_PREFIX)-msdos.tar.gz'
