version := $(shell grep VERSION version.h | sed -re 's/^.*"([^"]+)".*$$/\1/')

cc_dump_mach := $(shell $(CC) -dumpmachine)
target_arch   = $(firstword $(subst -, ,$(cc_dump_mach)))

TAR_PREFIX = gha-practice-$(version)

ds = $(shell date)

all:
	echo "make all: TARGET_OS = $(TARGET_OS)"

make fullrelease:
	echo "make fullrelease"
	echo '$(TAR_PREFIX)-src.tar.gz $(ds)' > '$(TAR_PREFIX)-src.tar.gz'
	echo '$(TAR_PREFIX)-linux-$(target_arch).tar.gz $(ds)' > \
		'$(TAR_PREFIX)-linux-$(target_arch).tar.gz'
	echo '$(TAR_PREFIX)-msdos.tar.gz $(ds)' > '$(TAR_PREFIX)-msdos.tar.gz'
