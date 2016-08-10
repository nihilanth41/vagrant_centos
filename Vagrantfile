# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  config.vm.provider "virtualbox" do |v|
    v.name = "ZRR CentOS 6.8 Base VM"
  end
  config.vm.hostname = "centos68"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "zrrm74/centos68"

  # Port forwarding example:
  config.vm.network :forwarded_port, guest: 8000, host: 8000 
  config.vm.network :forwarded_port, guest: 8080, host: 8080 

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", '3000']
    vb.customize ["modifyvm", :id, "--cpus", "2"]   
  end

  shared_dir = "/vagrant"
  
  config.ssh.insert_key = false

  config.vm.provision :shell, path: "./scripts/bootstrap.sh", :args => shared_dir

  if File.exist?("./scripts/custom.sh") then
    config.vm.provision :shell, path: "./scripts/custom.sh", :args => shared_dir
  end
end
