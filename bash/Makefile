include $(topdir)/common/Makefile.common

files := common.bashrc tags.bashrc
env_homerc := env_home.bashrc

all: export_env_home
	cp $(files) $(topdir)/$(USER_ENV)/$(BASH_OUT);

export_env_home:
	echo "export FENV_HOME=$(topdir)/$(USER_ENV)" > $(env_homerc)
	echo "export FENV_GIT=$(topdir)" >> $(env_homerc)
	mv $(env_homerc) $(topdir)/$(USER_ENV)/$(BASH_OUT)

clean:
	cd $(topdir)/$(USER_ENV)/$(BASH_OUT) && rm -rf $(files) $(env_homerc);

notes:


.PHONY: all clean
