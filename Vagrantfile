# Specify a custom Vagrant box for the demo
KUBE_DESKTOP =  ENV['KUBE_DESKTOP'] || "ubuntu/bionic64"

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Need vagrant-disksize plugin: https://github.com/sprotheroe/vagrant-disksize
  config.disksize.size = '50GB'
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "70"]
    v.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", 1]
    v.memory = 4096
    v.cpus = 2
  end

  config.vm.box = KUBE_DESKTOP

  config.vm.provision "shell", inline: "\
    echo 'Installing docker...'
    sudo apt-get update
    sudo curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh", run: "once"

  config.vm.provision "shell", inline: "\
    echo 'Installing dependencies...'
    sudo apt-get install -y python"

  config.vm.provision "ansible" do |ansible|
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "ansible/playbooks/main.yml"
  end

  #config.vm.synced_folder ".", "/vagrant"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.define "kube1" do |kube1|
    kube1.vm.hostname = "kube-desktop"
    kube1.vm.network "private_network", ip: "172.20.20.20"
    kube1.vm.network "forwarded_port", guest: 80, host: 1080
    kube1.vm.network "forwarded_port", guest: 6443, host: 6443

    kube1.vm.provision :shell, path: "scripts/kube-provisioner.sh", privileged: false
    kube1.vm.provision :shell, inline: "mkdir -p /home/vagrant/.kube && cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config && chown -R vagrant: /home/vagrant"
  end
end
