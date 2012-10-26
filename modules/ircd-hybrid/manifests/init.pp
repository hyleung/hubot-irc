class ircd-hybrid {
	
	#irc
	package { 'ircd-hybrid':
		ensure => present
	}


	service { 'ircd-hybrid':
		ensure => running,
		enable => true,
		hasstatus => false,
		require => Package['ircd-hybrid']
	}
	package { 'ircii':
		ensure => present
	}

	file {'/etc/ircd-hybrid/ircd.conf':
		source => 'puppet:///modules/ircd-hybrid/ircd.conf',
		notify => Service['ircd-hybrid'],
		require => Package['ircd-hybrid']
	}
	
}