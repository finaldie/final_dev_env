include $(topdir)/common/Makefile.common

files := common.bashrc tags.bashrc

all:
	cp $(files) $(topdir)/$(USER_ENV)/$(BASH_OUT);

clean:
	cd $(topdir)/$(USER_ENV)/$(BASH_OUT) && rm -rf $(files);

notes:


.PHONY: all clean
