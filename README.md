# openam-playground

openam automation spikes

## vbox network requirements

when using virtualbox as a vagrant provider you need to be sure that you have a `host-only` network configured with the required ip range for the static IPs specified in the vagrantfile. I have one with the following settings:
- IP: `172.28.128.1`
- mask: `255.255.255.0`

you can add one from file > preferences > network > host-only

TODO I'm sure there's a way to automate this with vboxmanage too
