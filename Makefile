.PHONY: all cluster provision 

all: cluster

# donwloading war requires signup.... https://backstage.forgerock.com/downloads/OpenAM/OpenAM%20Enterprise/12.0.0/OpenAM%2012#list

cluster: deps/OpenAM-12.0.0.war deps/openam-configurator-tool-12.0.0.jar
	vagrant up

provision: deps/OpenAM-12.0.0.war deps/openam-configurator-tool-12.0.0.jar
	vagrant provision

deps/openam-configurator-tool-12.0.0.jar: deps/SSOConfiguratorTools-12.0.0.zip
	unzip $< -d deps
	touch $@ # hack b/c extracting the file maintains the original timestamp and counts as ood, there is probably a more elegant solution but who remembers
