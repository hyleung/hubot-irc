#Setup instructions

Add "precise32" box to Vagrant by executing:

	vagrant box add precise32 http://files.vagrantup.com/precise32.box

Bring up the VM by executing:

	vagrant up

Puppet scripts still not 100% working - issue with *npm install* for Hubot, so to get things up and running will need to SSH into the box and...

	cd /opt/hubot
	npm install
	start hubot
	