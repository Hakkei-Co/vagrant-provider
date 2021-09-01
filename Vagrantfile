# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "hashicorp/bionic64"
    config.vm.provider :digital_ocean do |provider, override|
	# config.vm.hostname = 'hakkei.net'
	override.ssh.private_key_path = '~/.ssh/id_rsa'
	override.vm.box = 'digital_ocean'
	override.vm.box_url = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"
	override.nfs.functional = false
	override.vm.allowed_synced_folder_types = :rsync
	provider.token = Secret.do_token
	provider.image = 'ubuntu-18-04-x64'
	provider.region = 'nyc1'
	provider.size = 's-1vcpu-1gb'
	provider.backups_enabled = false
	provider.private_networking = false
	provider.ipv6 = false
	provider.monitoring = false
	provider.ssh_key_name = 'vagrant'
    end

#  config.vm.define "droplet2" do |config|
#    config.vm.provider :digital_ocean do |provider, override|
#        override.ssh.private_key_path = '~/.ssh/id_rsa'
#        override.vm.box = 'digital_ocean'
#        override.vm.box_url = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"
#        override.nfs.functional = false
#        override.vm.allowed_synced_folder_types = :rsync
#        provider.token = Secret.do_token
#        provider.image = 'ubuntu-18-04-x64'
#        provider.region = 'SFO3'
#        provider.size = 's-1vcpu-1gb'
#        provider.backups_enabled = false
#        provider.private_networking = false
#        provider.ipv6 = false
#        provider.monitoring = false
#    end
#  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  

  # Check if ~/.gitconfig exists locally
  # If so, copy basic Git Config settings to Vagrant VM
  if File.exists?(File.join(Dir.home, ".gitconfig"))
      git_name = `git config user.name`
      git_email = `git config user.email`
      config.vm.provision :shell, :inline => "echo 'Saving local git username to VM...' && sudo -i -u vagrant git config --global user.name '#{git_name.chomp}'"
      config.vm.provision :shell, :inline => "echo 'Saving local git email to VM...' && sudo -i -u vagrant git config --global user.email '#{git_email.chomp}'"
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # The user-config.sh holds configuration specific to the vagrant login user. 
    id_rsa_pub = File.read("#{Dir.home}/.ssh/id_rsa.pub")
    
    config.vm.provision :shell do |s|
      s.path = 'vagrant/provision.sh'
      s.inline = 'echo \"#{id_rsa_pub}\" >> /home/vagrant/.ssh/authorized_keys'
    end

    config.vm.synced_folder '.', '/home/vagrant'
end
