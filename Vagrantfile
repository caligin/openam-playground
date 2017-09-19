Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048 # with 512 openam goes oom during setup
    v.cpus = 1
  end

  config.vm.provision "file", source: "slapd.ldif", destination: "slapd.ldif"
  config.vm.provision "file", source: "role.ldif", destination: "role.ldif"
  config.vm.provision "file", source: "user.ldif", destination: "user.ldif"
  config.vm.provision "file", source: "configuration", destination: "configuration"
  config.vm.provision "file", source: "gneldap.config", destination: "gneldap.config"
  config.vm.provision "file", source: "deps", destination: "deps"
  config.vm.provision "shell", inline: "rpm --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7"
  config.vm.provision "shell", inline: "yum install -y java-1.8.0-openjdk-headless.x86_64 tomcat net-tools openldap-clients openldap-servers vim"
  config.vm.provision "shell", inline: "find /etc/openldap/slapd.d/ -mindepth 1  -delete"
  config.vm.provision "shell", inline: "slapadd -n0 -F /etc/openldap/slapd.d/ -l /home/vagrant/slapd.ldif"
  config.vm.provision "shell", inline: "chown -R ldap. /etc/openldap/slapd.d/"
  config.vm.provision "shell", inline: "setenforce 0"
  config.vm.provision "shell", inline: "grep cluster01 /etc/hosts && sed -ir 's/.+?cluster01/172.28.128.11 cluster01/' /etc/hosts || echo '172.28.128.11 cluster01 openam.anima.tech openam01.anima.tech' >> /etc/hosts"
  config.vm.provision "shell", inline: "grep cluster02 /etc/hosts && sed -ir 's/.+?cluster02/172.28.128.12 cluster02/' /etc/hosts || echo '172.28.128.12 cluster02 openam02.anima.tech' >> /etc/hosts"
  config.vm.provision "shell", inline: "cp /vagrant/deps/OpenAM-12.0.0.war /var/lib/tomcat/webapps/openam.war" # filename matters as there is no context.xml so tomcat deploys on a contexpath equal to the war name
  config.vm.provision "shell", inline: "systemctl start slapd.service"
  config.vm.provision "shell", inline: "systemctl enable slapd.service"
  config.vm.provision "shell", inline: "systemctl start tomcat.service"
  config.vm.provision "shell", inline: "systemctl enable tomcat.service"
  config.vm.provision "shell", inline: "ldapadd -x -D 'cn=Manager,dc=ldap,dc=anima,dc=tech' -w secret -f role.ldif"
  config.vm.provision "shell", inline: "ldapadd -x -D 'cn=Manager,dc=ldap,dc=anima,dc=tech' -w secret -f user.ldif"
  config.vm.provision "shell", inline: "timeout 180s bash -c 'while true; do curl localhost:8080 && break || sleep 0.5; done' && java -jar deps/configurator/openam-configurator-tool-12.0.0.jar -f configuration"
  config.vm.provision "shell", inline: "cd deps/admintools && JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk/ ./setup --acceptLicense -p /usr/share/tomcat/webapps/openam"
  config.vm.provision "shell", inline: "echo password > pwd"
  config.vm.provision "shell", inline: "chmod 400 pwd" # important or the tool refuses to work
  config.vm.provision "shell", inline: "deps/admintools/openam/bin/ssoadm  create-datastore -e / -u amadmin -f pwd -m gneldap -D gneldap.config -t LDAPv3"

  config.vm.define "cluster01" do |cluster01|
    cluster01.vm.network "private_network", ip: "172.28.128.11"
    cluster01.vm.provision "shell", inline: "hostnamectl set-hostname cluster01"
  end

  config.vm.define "cluster02" do |cluster02|
    cluster02.vm.network "private_network", ip: "172.28.128.12"
    cluster02.vm.provision "shell", inline: "hostnamectl set-hostname cluster02"
  end

end
