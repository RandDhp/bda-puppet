	#This class is designed to install and set up Bugzilla

	#Definition of the class
	class bugzilla(
		#$admin_email		= 'diego.denova@hp.com',
		#$admin_password	= '123456789',	
		#$admin_realname	= 'Diego De Nova',
		$create_htaccess 	= false,
		$webservergroup 	= 'apache',
		$use_suexec			= false,
	  	$db_driver 			= 'mysql',
	  	$db_host 			= 'localhost',
	 	$db_name 			= 'bugzilla',
	  	$db_user 			= 'bugzilla',
	  	$db_pass 			= '',
	  	$db_port 			= 0,
	  	$db_sock 			= '',
	  	$db_check 			= true,
	  	$index_html 		= false,
	  	$cvsbin 			= '/usr/bin/cvs',
	  	$interdiffbin 		= '/usr/bin/interdiff',
	  	$diffpath 			= '/usr/bin',
	  	$site_wide_secret 	= '',
		$smtp_server 		= 'localhost',
		$tarball			= "wget -O /tmp/bugzilla-4.4.2.tar.gz http://ftp.mozilla.org/pub/mozilla.org/webtools/bugzilla-4.4.2.tar.gz",
		$untar 				= "tar -C /usr/local -zxvf /tmp/bugzilla-4.4.2.tar.gz",
		$path 				= '/usr/bin:/usr/sbin:/bin',
		$bugzilla_dir 		= '/usr/local/bugzilla-4.4.2/',	
	){
		#Download Bugzilla's tarball and untar it
		exec { 'bugzilla-tar':
			command 	=> $tarball,
  			path 		=> $path,
  			user 		=> root,  			
 			onlyif  	=> "test `ls /tmp | grep bugzilla-4.4.2.tar.gz | wc -l` -eq 0"
		}	
		exec { 'bugzilla-untar':
			command 	=> $untar,
  			path 		=> $path,
  			user 		=> root,  			
 			onlyif  	=> "test `ls /usr/local | grep bugzilla-4.4.2/ | wc -l` -eq 0"
		}	

		$answer_config_file = "${bugzilla_dir}localconfig"	

		#Perform configuration and run checksetup.pl which will build the database if required.
		file { $answer_config_file:
			owner 		=> root,
			group 		=> root,
			mode 		=> '0644',
			content 	=> template('~/bda-puppet/templates/answer.erb'),
			notify 		=> Exec['bugzilla_checksetup']
		}
		exec { 'bugzilla_checksetup':
			command 	=> "${bugzilla_dir}checksetup.pl ${answer_config_file}",
			logoutput 	=> true,
			refreshonly => true,
			#notify 	=> Exec["backup_localconfigfile_${name}"]
		}		
	}

	#Declaration of the class
	include bugzilla