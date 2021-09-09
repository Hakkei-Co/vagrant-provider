# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<-SCRIPT
echo I am provisioning inline script...
date > /etc/vagrant_provisioned_at
SCRIPT

Vagrant.configure("2") do |config|
  # By default, Vagrant shares your project directory (the one containing the Vagrantfile) to the /vagrant directory in your guest machine.
  config.vm.synced_folder ".", "/vagrant", disabled: false, type: 'rsync',
    rsync__exclude: ".git/"

  config.vm.network "private_network", type: "dhcp"
  config.trigger.before :provisioner_run, type: :hook do |t|
    t.info = "-> Before Provision"
  end
  config.vm.provider :digital_ocean do |provider, override|
    config.vm.hostname = 'hakkei.net'
    override.ssh.private_key_path = '~/.ssh/git_vagrant_id_ed25519'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    override.nfs.functional = false
    override.vm.allowed_synced_folder_types = :rsync
    provider.token = Secret.do_token
    provider.image = 'ubuntu-18-04-x64'
    provider.region = 'nyc1'
    provider.size = 's-1vcpu-1gb'
    provider.backups_enabled = false
    # provider.private_networking = false
    provider.ipv6 = false
    provider.monitoring = false
    provider.ssh_key_name = 'vagrant'
  end
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Check if ~/.gitconfig exists locally
  # If so, copy basic Git Config settings to Vagrant VM
  if File.exists?(File.join(Dir.home, ".gitconfig"))
      git_name = `git config user.name`
      git_email = `git config user.email`
      config.vm.provision :file, source: "~/.gitconfig", destination: ".gitconfig"
  end

  config.vm.provision :file, source: "~/.zshrc", destination: ".zshrc"
  config.vm.provision "shell", inline: $script
  config.vm.provision :shell, path: "vagrant/provision.sh"


end
