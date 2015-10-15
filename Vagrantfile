# -*- mode: ruby -*-
# vi: set ft=ruby :

$shell_puppetinstall = <<SCRIPT
sudo sed -i 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
export DEBIAN_FRONTEND="noninteractive"
sudo -E apt-get -y update
sudo -E apt-get -y upgrade
sudo -E apt-get -y install puppet librarian-puppet git
sudo -E apt-get -y autoremove
sudo -E apt-get -y clean
sudo cp /vagrant/puppet/Puppetfile /etc/puppet
sudo bash -c "cd /etc/puppet ; librarian-puppet install"
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-nocm"

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = false
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
  end

  config.vm.provision "shell", inline: $shell_puppetinstall
  config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = ["vm", "/vagrant/puppet/manifests"]
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
  end
end
