	#This class is designed to install MySQL through the puppetlabs-mysql module

	#Definition of the class
	class mysql(
		$mysql 	= 'puppet module install puppetlabs-mysql',		
		$path 	= '/usr/bin:/usr/sbin:/bin'
		#Vagrant users $path 	= '/bin:/usr/bin'
	){
		exec { 'puppetlabs-mysql':
			command 	=> $mysql,
  			path 		=> $path,
  			user 		=> root,  			
 			onlyif  	=> "test `puppet module list | grep puppetlabs-mysql | wc -l` -eq 0",
		}
	}

	#This resource is designed to interact with MySQL trough the puppetlabs-mysql module

	#include '::mysql::server'

	#Creates bugzilla user on localhost and manages it within MySQL.
	#mysql_user { 'bugzilla@localhost':
	#	ensure                   	=> 'present',
	#	max_connections_per_hour 	=> '0',
	#	max_queries_per_hour     	=> '0',
	#	max_updates_per_hour     	=> '0',
	#	max_user_connections     	=> '0',
	#}

	#Declaration of the class
	#include mysql



