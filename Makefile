.PHONY: all cluster provision 

all: cluster

# donwloading war requires signup.... https://backstage.forgerock.com/downloads/OpenAM/OpenAM%20Enterprise/12.0.0/OpenAM%2012#list

cluster: OpenAM-12.0.0.war
	vagrant up

provision: OpenAM-12.0.0.war
	vagrant provision

