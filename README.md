# openam-playground

openam automation spikes

# requirements

## openam packages

since using forgerock software requires signup, license and whatnot you have to [download the files from here](https://backstage.forgerock.com/downloads/OpenAM/OpenAM%20Enterprise/12.0.0/OpenAM%2012#list) yourself and put them in a dir called `deps`

You need:
- `OpenAM-12.0.0.war`
- `SSOAdminTools-12.0.0.zip`
- `SSOConfiguratorTools-12.0.0.zip`

FYI I seem to understand that use of these binaries is limited to an evaluation period or buy a license because they're hardened so you might want to compile from source instead. Or go read the license and prove me wrong #notALawyer.

## vbox network

when using virtualbox as a vagrant provider you need to be sure that you have a `host-only` network configured with the required ip range for the static IPs specified in the vagrantfile. I have one with the following settings:
- IP: `172.28.128.1`
- mask: `255.255.255.0`

you can add one from file > preferences > network > host-only

TODO I'm sure there's a way to automate this with vboxmanage too

# build a cluster

`make`
