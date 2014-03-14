	#This class is designed to install Apache Web-Server through the puppetlabs-apache module

	#Definition of the class
	class apache(
		$apache = 'puppet module install puppetlabs-apache',		
		$path 	= '/usr/bin:/usr/sbin:/bin'
		#Vagrant users $path 	= '/bin:/usr/bin'
	){
		exec { 'puppetlabs-apache':
			command 	=> $apache,
  			path 		=> $path,
  			user 		=> root,  			
 			onlyif  	=> "test `puppet module list | grep puppetlabs-apache | wc -l` -eq 0"
		}
	}

	#This resource is designed to interact with Apache trough the puppetlabs-apache module

	#Sets up a virtual host with SSL and specific SSL certificates
    #apache::vhost { '15.185.237.107':
	#	port 			=> '443',
	#	docroot  		=> '/var/www/bugzilla',
		#ssl      		=> true,
		#ssl_cert 		=> '/etc/ssl/bugzilla_houston_hp_com.crt',
		#ssl_key  		=> '/etc/ssl/bugzilla_houston_hp_com.key',
    #}

	#Declaration of the class
	#include apache