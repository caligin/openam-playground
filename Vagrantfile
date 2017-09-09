Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024 # with 512 openam goes oom during setup
    v.cpus = 1
  end

  config.vm.provision "shell", inline: "rpm --import file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7"
  config.vm.provision "shell", inline: "yum install -y java-1.8.0-openjdk-headless.x86_64 tomcat"
  config.vm.provision "shell", inline: "yum install -y net-tools"
  config.vm.provision "shell", inline: "grep cluster01 /etc/hosts && sed -ir 's/.+?cluster01/172.28.128.11 cluster01/' /etc/hosts || echo '172.28.128.11 cluster01' >> /etc/hosts"
  config.vm.provision "shell", inline: "grep cluster02 /etc/hosts && sed -ir 's/.+?cluster02/172.28.128.12 cluster02/' /etc/hosts || echo '172.28.128.12 cluster02' >> /etc/hosts"
  config.vm.provision "shell", inline: "grep cluster03 /etc/hosts && sed -ir 's/.+?cluster03/172.28.128.13 cluster03/' /etc/hosts || echo '172.28.128.13 cluster03' >> /etc/hosts"
  config.vm.provision "shell", inline: "cp /vagrant/OpenAM-12.0.0.war /var/lib/tomcat/webapps/openam.war" # filename matters as there is no context.xml so tomcat deploys on a contexpath equal to the war name
  config.vm.provision "shell", inline: "systemctl start tomcat.service"
  config.vm.provision "shell", inline: "systemctl enable tomcat.service"

  config.vm.define "cluster01" do |cluster01|
    cluster01.vm.network "private_network", ip: "172.28.128.11"
    cluster01.vm.provision "shell", inline: "hostnamectl set-hostname cluster01"
  end

  config.vm.define "cluster02" do |cluster02|
    cluster02.vm.network "private_network", ip: "172.28.128.12"
    cluster02.vm.provision "shell", inline: "hostnamectl set-hostname cluster02"
  end

  config.vm.define "cluster03" do |cluster03|
    cluster03.vm.network "private_network", ip: "172.28.128.13"
    cluster03.vm.provision "shell", inline: "hostnamectl set-hostname cluster03"
  end

end
