include $(topdir)/common/Makefile.common

files := common.bashrc tags.bashrc linux.bashrc maven.bashrc
env_homerc := env_home.bashrc

all: prepare export_env_home copy_files generate

prepare:
	@test -d $(USER_ENV)/$(BASH_OUT) || mkdir $(USER_ENV)/$(BASH_OUT);

export_env_home:
	echo "export FENV_HOME=$(topdir)/$(USER_ENV)" > $(env_homerc)
	echo "export FENV_GIT=$(topdir)" >> $(env_homerc)
	mv $(env_homerc) $(topdir)/$(USER_ENV)/$(BASH_OUT)

copy_files:
	cp $(files) $(topdir)/$(USER_ENV)/$(BASH_OUT);

generate:
	@cd $(topdir)/$(USER_ENV) && echo "" > all.$(BASH_SUFFIX) && \
	    for bashrc in `ls $(BASH_OUT) | grep .$(BASH_SUFFIX)`; do \
		echo "source $(topdir)/$(USER_ENV)/$(BASH_OUT)/$$bashrc" >> all.$(BASH_SUFFIX); \
	    done;

clean:
	cd $(topdir)/$(USER_ENV)/$(BASH_OUT) && rm -rf $(files) $(env_homerc);

notes:
	@echo "=========================================================";
	@echo "*   Install Complete, Please Read The Following Notes   *";
	@echo "=========================================================";
	@echo "";
	@echo "========================BASH NOTE========================";
	@echo "If you are using bash as your default shell";
	@echo "1. Add the following into $(HOME)/.bash_profile";
	@echo "2. Run bash or re-login";
	@echo "=========================================================";
	@echo "if [ -f $(topdir)/$(USER_ENV)/all.$(BASH_SUFFIX) ]; then";
	@echo "    . $(topdir)/$(USER_ENV)/all.$(BASH_SUFFIX)";
	@echo "fi";
	@echo "";

.PHONY: all clean export_env_home copy_files generate
