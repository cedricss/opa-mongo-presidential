########################################
# USER VARIABLES
MKLIB = opa-plugin-builder
PLUGNAME = tabs.opp
SRC = tabs.js bootstrap-tabs.js
CONF = conf.jsconf

########################################
# MAKEFILE VARIABLES
ifeq ($(origin BUILDDIR), undefined)
	PWD := $(shell pwd)
	BUILDDIR := $(PWD)/_build/
	export BUILDDIR
endif

########################################
# PLUGIN BUILDING
$(PLUGNAME) : $(SRC)
	@echo "### Building plugin $(PLUGNAME)"
	@$(MKLIB) --js-validator-off -o $(@:%.opp=%) $? $(CONF) --build-dir $(BUILDDIR)

########################################
# CLEANING
clean :
	@echo "### Cleaning plugin $(PLUGNAME)"
	@rm -rf $(BUILDDIR)/$(PLUGNAME)
