vagrant-puppet-template
=======================

Basic empty Vagrant environment for local puppet apply testing/development

Includes librarian-puppet and hiera

Based on work by Andre Keller (https://github.com/andrekeller)

Usage:
------
* in the puppet/ subdirectory there is:
** puppet/hieradata/common.yaml: define the classes and provide the parameters here
** puppet/Puppetfile: define what modules you need, can be from puppetforge or a git repo
* run =vagrant up= to start the VM
** if the machine is running and you just want to re-apply changes to the files above you can run =vagrant provision=
** if =vagrant provision= fails you can always start over by =vagrant destroy -f ; vagrant up=, this deletes the VM and all data in it !
* this directory will be mounted to /vagrant/ inside the VM
* you can access the running VM through =vagrant ssh=

Behind the scenes:
------------------
* puppet/manifests/default.pp instructs puppet to use hiera
* puppet/hiera.yaml configures hiera to use hieradata/common.yaml
* Vagrantfile tells vagrant to start a VM and provision it with the files and tools above

