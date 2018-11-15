# Specify a custom Vagrant box for the demo
DEMO_BOX_NAME =  ENV['DEMO_BOX_NAME'] || "ubuntu/xenial64"

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "70"]
    v.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", 1]
    v.memory = 4096
    v.cpus = 3
  end

  config.vm.box = DEMO_BOX_NAME
  config.vm.provision "shell", inline: "\
    echo 'Installing dependencies...'
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y unzip curl git jq make docker.io mc python-pip postgresql-client screen"
  config.vm.provision "shell", inline: "pip install --upgrade pip"
  config.vm.provision "shell", inline: "pip install yq"
  config.vm.provision "shell", inline: "usermod -a -G docker vagrant"

  config.vm.synced_folder ".", "/vagrant"

  config.vm.define "kube1" do |kube1|
    kube1.vm.hostname = "kube-desktop"
    kube1.vm.network "private_network", ip: "172.20.20.20"
    kube1.vm.network "forwarded_port", guest: 80, host: 1080
    kube1.vm.network "forwarded_port", guest: 6443, host: 6443

    kube1.vm.provision :shell, path: "install-kubeadm.sh", privileged: false
    kube1.vm.provision :shell, path: "deploy-ci-stack.sh", privileged: false
    kube1.vm.provision :shell, inline: "mkdir -p /home/vagrant/.kube && cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config && chown -R vagrant: /home/vagrant"
  end
end
