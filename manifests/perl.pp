	#This class is designed to install perl, pmtools, cpanminus and some perl modules. All of this in their last versions.

	#Definition of the class
	class perl(
		$version 	= false,
		$ensure 	= installed,
		$perl 		= 'perl',
		$pmtools 	= 'pmtools',
		$cpanminus 	= 'cpanminus',
		$module		= ['CGI', 'Date::Format', 'DateTime'],
						#'DAteTime::TimeZone',
						#'DBI',
						#'DBD::mysql',
						#'Digest::SHA',
						#'Email::Send',
						#'Email::MIME',
						#'Template',
						#'URI',
						#'List::MoreUtils',
						#'Math::Random::ISAAC'
						#],		
		$path 		= '/usr/bin:/usr/sbin:/bin'
		#Vagrant users $path 	= '/bin:/usr/bin'
	){
		package { $perl:
			ensure 	=> $ensure,
		}
		package { $pmtools:
			ensure 	=> $ensure,
		}
		package { $cpanminus:
			ensure 	=> $ensure,
		}
		exec { 'perl-modules':
			command 	=> "cpanm {$module[0]}",
  			path 		=> $path,
  			user 		=> root,
 			#onlyif  	=> "test `puppet module list | grep puppetlabs-mysql | wc -l` -eq 0"
		}		
	}
	
	#Declaration of the class
	include perl