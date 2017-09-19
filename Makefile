.PHONY: all cluster provision 
CONFIGURATOR:=deps/configurator/openam-configurator-tool-12.0.0.jar
SSOADM_SETUP:=deps/admintools/setup

all: cluster

# donwloading war requires signup.... https://backstage.forgerock.com/downloads/OpenAM/OpenAM%20Enterprise/12.0.0/OpenAM%2012#list

cluster: deps/OpenAM-12.0.0.war $(CONFIGURATOR) $(SSOADM_SETUP)
	vagrant up cluster01

provision: deps/OpenAM-12.0.0.war $(CONFIGURATOR) $(SSOADM_SETUP)
	vagrant provision cluster01

$(CONFIGURATOR): deps/SSOConfiguratorTools-12.0.0.zip
	unzip -o $< -d deps/configurator
	touch $@ # hack b/c extracting the file maintains the original timestamp and counts as ood, there is probably a more elegant solution but who remembers

$(SSOADM_SETUP): deps/SSOAdminTools-12.0.0.zip
	unzip -o $< -d deps/admintools
	touch $@ # hack b/c extracting the file maintains the original timestamp and counts as ood, there is probably a more elegant solution but who remembers
