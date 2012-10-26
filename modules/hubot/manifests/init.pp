class hubot {
	exec {'apt-get-update':
		command => '/usr/bin/apt-get update --fix-missing',
	}

	#hubot dependencies
	package {'build-essential':
		ensure => present
	}
	package {'libssl-dev':
		ensure => present
	}
	package { 'git-core':
		ensure => present
	}
	package {'redis-server':
		ensure => present
	}
	package {'libexpat1-dev':
		ensure => present
	}
	#node
	package {'nodejs':
		ensure => present
	}
	package {'npm':
		ensure => present,
		require => Package['nodejs']
	}
	

	#install NPM prereqs
	exec {'npm-prereqs':
		command => 'npm install -g coffee-script',
		path => ['/usr/bin'],
		require => Package['npm']
	}

	#install hubot
	file { '/opt':
		ensure => directory
	}
	exec {'download-hubot':
		command => 'wget https://github.com/downloads/github/hubot/hubot-2.3.2.tar.gz -O /tmp/hubot-2.3.2.tar.gz',
		path => ['/usr/bin'],
		creates => '/tmp/hubot-2.3.2.tar.gz'
	}

	exec { 'unpack-hubot':
		command => 'tar -xvxf /tmp/hubot-2.3.2.tar.gz -C /opt',
		cwd => '/tmp',
		path => ['/bin'],
		creates => '/opt/hubot',
		require => [Exec['download-hubot'],File['/opt']]
	}
	exec { 'npm-update':
		command => 'npm update',
		path => ['/usr/bin']
	}
	exec { 'install-hubot':
		command => 'npm install',
		cwd => '/opt/hubot',
		path => ['/usr/bin'],
		logoutput => true,
		require => [Exec['npm-prereqs','unpack-hubot','npm-update'],Package['npm']]
	}

	file {'/opt/hubot/package.json':
		source => 'puppet:///modules/hubot/package.json',
		require => Exec['unpack-hubot']
	}

	file {'/etc/init/hubot.conf':
		source => 'puppet:///modules/hubot/hubot.conf',	
		owner => 'root',
		group => 'root',
		mode => 644,
		require => Exec['unpack-hubot']
	}

	exec {'start-hubot':
		command => 'start hubot',
		path => ['/sbin'],
		logoutput => true,
		require => Exec['install-hubot']
	}

	#Hubot user
	file {'/home/hubot':
		ensure => directory
	}
	user { 'hubot':
		ensure => present,
		home => '/home/hubot',
		require => File['/home/hubot']
	}
}