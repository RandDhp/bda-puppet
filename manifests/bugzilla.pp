	#This class is designed to install and set up Bugzilla

	#Definition of the class
	class bugzilla(
		$admin_email		= 'diego.denova@hp.com',
		$admin_password		= '123456789',	
		$admin_realname		= 'Diego De Nova',
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
		$tarball			= "wget -O /tmp/bugzilla.tar.gz http://ftp.mozilla.org/pub/mozilla.org/webtools/bugzilla-4.4.2.tar.gz",
		$untar 				= "tar -C /var/www/html -zxvf /tmp/bugzilla.tar.gz",
		$name_change 		= "mv /var/www/html/bugzilla-4.4.2/ bugzilla",
		$httpd_change		= "echo $'PerlSwitches -I/var/www/html/bugzilla -I/var/www/html/bugzilla/lib -w -T\nPerlConfigRequire /var/www/html/bugzilla/mod_perl.pl'"
		$path 				= '/usr/bin:/usr/sbin:/bin',
		$bugzilla_dir 		= '/var/www/html/bugzilla/',
		#$answer_config_file = '/var/www/html/bugzilla/localconfig'
		$answer_config_file = "${bugzilla_dir}localconfig"
	){
		#Download Bugzilla's tarball and untar it
		exec { 'bugzilla_tar':
			command 	=> $tarball,
  			path 		=> $path,
  			user 		=> root,  			
 			onlyif  	=> "test `ls /tmp | grep bugzilla-4.4.2.tar.gz | wc -l` -eq 0",
 			before 		=> Exec['bugzilla_untar']
		}	
		exec { 'bugzilla_untar':
			command 	=> $untar,
  			path 		=> $path,
  			user 		=> root,  			
 			onlyif  	=> "test `ls /usr/local | grep bugzilla-4.4.2/ | wc -l` -eq 0",
 			before 		=> Exec['bugzilla_name_change']
		}	
		exec { 'bugzilla_name_change':
			command 	=> $name_change,
  			path 		=> $path,
  			user 		=> root,  			
 			before 		=> Exec['httpd_conf_file_change']			
		}	
		exec { 'httpd_conf_file_change':
			command 	=> $httpd_change,
  			path 		=> $path,
  			user 		=> root,  			
 			before 		=> File["${answer_config_file}"]			
		}		

		#Perform configuration and run checksetup.pl which will build the database if required.
		file { $answer_config_file:
			owner 		=> root,
			group 		=> root,
			mode 		=> '0644',
			content 	=> template('bda-puppet/answer.erb'),
			notify 		=> Exec['bugzilla_checksetup']
		}
		exec { 'bugzilla_checksetup':
			command 	=> "${bugzilla_dir}checksetup.pl ${answer_config_file}",
			logoutput 	=> true,
			refreshonly => true,			
		}		
	}

	#Declaration of the class
	#include bugzilla
