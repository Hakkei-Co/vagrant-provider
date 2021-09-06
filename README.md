# Usage

Install required provider plugins:

- [Vagrant-Secret](https://github.com/tcnksm/vagrant-secret)
- [Vagrant-Digital-Ocean](vagrant plugin install vagrant-digitalocean)


```bash
$ vagrant plugin install vagrant-secret
$ vagrant plugin install vagrant-digitalocean
```

### Note

Do not run from root user.  Create a new user from root and add the authorized user's .pub contents into the DigitalOcean SSH key registry. 

`vagrant up` will fail if keys are not owned by the user. 

Debug
  
```bash
$ VAGRANT_LOG=debug vagrant up --provider=digital_ocean

# Verify the keys specified in Vagrantfile have the correct owner 
$ stat ~/.ssh/<your_key_name>
# Use sudo
$ chown vagrant:vagrant ~/.ssh/<key_name>

``` 

