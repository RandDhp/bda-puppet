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

	#Declaration of the class
	include apache