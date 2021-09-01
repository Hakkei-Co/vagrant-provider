#!/bin/bash


sudo apt-get update

# Turn off apt errors "dpkg-preconfigure: unable to re-open stdin: No such file or directory"

export DEBIAN_FRONTEND=noninteractive

# Make sure we have up to date versions of git and curl 

echo "Install basic packages..." 
apt-get install git
apt-get install curl

# Installing developer packages

echo "Install basic packages..." 
sudo apt-get install build-essential curl vim -y > /dev/null



# Added zsh shell.

echo "Install zsh..." 
sudo apt-get install -y zsh

echo "Install antigen manager for zsh..."
curl -L git.io/antigen > antigen.zsh

echo "Change shell to zsh..." 
sudo chsh -s /bin/zsh vagrant
zsh



# Install Node and NVM
echo "Install nvm..." 
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
source ~/.nvm/nvm.sh

echo "Install compatible Node version 12 for Stencil support..." 
nvm install 12
nvm alias default node 



# Get latest npm

npm install npm --global

# Get latest yarn

npm install --global yarn

# Install prismic 
npm install -global prismic-cli


# Install gatsby

echo "Install Gatsbyjs..." 
npm install -g gatsby-cli

# Install rsync

echo "Install rsync..." 
apt-get install -y rsync



# Start Apache server 

apt-get install -y apache2
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi

su -c "source /home/vagrant/vagrant_dir/vagrant/user-config.sh" vagrant


