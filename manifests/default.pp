
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
	
	#irc
	package { 'ircd-hybrid':
		ensure => present
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
	exec {'clone-hubot':
		command => 'git clone https://github.com/github/hubot.git',
		cwd => '/opt',
		path => ['/usr/bin'],
		require => File['/opt']
	}
}

include 'hubot'