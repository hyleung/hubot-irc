# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise32"
  config.vm.forward_port 80, 8080
  config.vm.forward_port 6666, 6666
  config.vm.forward_port 6667, 6667
  config.vm.forward_port 6668, 6668
  config.vm.forward_port 6669, 6669

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "default.pp"
     #puppet.options = " --debug"
     puppet.module_path = 'modules'
   end

end