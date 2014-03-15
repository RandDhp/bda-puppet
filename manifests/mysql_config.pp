	#This resource is designed to interact with MySQL trough the puppetlabs-mysql module

	include '::mysql::server'

	#Creates bugzilla user on localhost and manages it within MySQL.
	mysql_user { 'bugzilla@localhost':
		ensure                   	=> 'present',
		max_connections_per_hour 	=> '0',
		max_queries_per_hour     	=> '0',
		max_updates_per_hour     	=> '0',
		max_user_connections     	=> '0',
	}