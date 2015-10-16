# -*- mode: ruby -*-
# vi: set ft=ruby :

# shell script to install puppet and librarian-puppet, used below
$shell_puppetinstall = <<SCRIPT
if [ ! -f /usr/bin/librarian-puppet ] ; then
  echo "librarian-puppet not found, installing"
  sudo sed -i 's/us.archive.ubuntu.com/archive.ubuntu.com/g' /etc/apt/sources.list
  export DEBIAN_FRONTEND="noninteractive"
  sudo -E apt-get -y update
  #sudo -E apt-get -y upgrade
  sudo -E apt-get -y install puppet librarian-puppet git software-properties-common
  #sudo -E apt-get -y autoremove
  #sudo -E apt-get -y clean
fi
echo "running librarian-puppet"
sudo cp /vagrant/puppet/Puppetfile /etc/puppet
sudo bash -c "cd /etc/puppet ; librarian-puppet install --verbose"
echo "done, running puppet"
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/ubuntu-14.04-64-nocm"

#  config.hostmanager.enabled = true
#  config.hostmanager.manage_host = false
#  config.hostmanager.ignore_private_ip = false
#  config.hostmanager.include_offline = true

  config.ssh.forward_agent = true

  # set CPU/RAM usage here
  config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
  end

  # you can install this install cache plugin through "vagrant plugin install vagrant-cachier", makes the re-building of the box faster
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  # forward ports from the local machine, add more if needed
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true # http://localhost:8080/
  config.vm.network "forwarded_port", guest: 443, host: 8443, auto_correct: true # https://localhost:8443/

  # here the shell script at the top is executed
  config.vm.provision "shell", inline: $shell_puppetinstall
  # .. and then puppet is run with the correct settings
  config.vm.provision "puppet" do |puppet|
      puppet.manifests_path = ["vm", "/vagrant/puppet/manifests"]
      puppet.hiera_config_path = "puppet/hiera.yaml"
      puppet.working_directory = "/tmp/vagrant-puppet"
  end
end
