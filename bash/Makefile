include $(topdir)/common/Makefile.common

files := common.bashrc tags.bashrc

all:
	cp $(files) $(topdir)/$(USER_ENV);

backup:

revert:

clean:
	cd $(topdir)/$(USER_ENV) && rm -rf $(files);

.PHONY: all clean backup revert
