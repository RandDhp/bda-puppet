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
 			onlyif  	=> "test `puppet module list | grep puppetlabs-mysql | wc -l` -eq 0"
		}
	}

	#Declaration of the class
	include mysql



