	#This class is designed to install perl, pmtools, cpanminus and some perl modules. All of this in their last versions

	#Definition of the class
	class perl(
		$version 	= false,
		$ensure 	= installed,
		$perl 		= 'perl',
		$pmtools 	= 'pmtools',
		$cpanminus 	= 'cpanminus',
		#$module		= ['CGI',- 'Date::Format', 'DateTime'-],
						#'DateTime::TimeZone',-
						#'DBI',-
						#'DBD::mysql',
						#'Digest::SHA',-
						#'Email::Send',-
						#'Email::MIME',-
						#'Template',-
						#'URI',-
						#'List::MoreUtils',-
						#'Math::Random::ISAAC'-
						#],		
		$path 		= '/usr/bin:/usr/sbin:/bin'
		#Vagrant users $path 	= '/bin:/usr/bin'
	){
		#Installation of perl, pmtools and cpanminus
		package { $perl:
			ensure 		=> $ensure,
			before 		=> Package["${pmtools}"]
		}
		package { $pmtools:
			ensure 		=> $ensure,
			before 		=> Package["${cpanminus}"]
		}
		package { $cpanminus:
			ensure 		=> $ensure,
			before 		=> Exec['CGI']
		}
		#exec { 'perl_modules':
		#	command 	=> "cpanm ${module[0]}",
  		#	path 		=> $path,
  		#	user 		=> root,
 		#	#onlyif  	=> "test `puppet module list | grep ${module[0]} | wc -l` -eq 0"
		#}	
		#Installation of perl modules	
		exec { 'CGI':
			command 	=> "cpanm CGI",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep CGI | wc -l` -eq 0",
 			before 		=> Exec['Date_Format']
		}		
		exec { 'Date_Format':
			command 	=> "cpanm Date::Format'",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep Date::Format' | wc -l` -eq 0",
 			before 		=> Exec['DateTime']
		}	
		exec { 'DateTime':
			command 	=> "cpanm DateTime",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep DateTime | wc -l` -eq 0",
 			before 		=> Exec['DateTime_TimeZone']			
		}			
		exec { 'DateTime_TimeZone':
			command 	=> "cpanm DateTime::TimeZone",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep DateTime::TimeZone | wc -l` -eq 0",
 			before 		=> Exec['DBI']
		}	
		exec { 'DBI':
			command 	=> "cpanm DBI",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep DBI | wc -l` -eq 0",
 			before 		=> Exec['DBD_mysql']
		}
		#MySQL has to be already installed
		exec { 'DBD_mysql':
			command 	=> "cpanm DBD::mysql",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep DBD::mysql | wc -l` -eq 0",
 			before 		=> Exec['Digest_SHA']
		}		
		exec { 'Digest_SHA':
			command 	=> "cpanm Digest::SHA",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep Digest::SHA | wc -l` -eq 0",
 			before 		=> Exec['Email_Send'],
		}
		exec { 'Email_Send':
			command 	=> "cpanm Email::Send",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep Email::Send | wc -l` -eq 0"
 			before 		=> Exec['Email_MIME']
		}		
		exec { 'Email_MIME':
			command 	=> "cpanm Email::MIME",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep Email::MIME | wc -l` -eq 0",
 			before 		=> Exec['Template']
		}	
		exec { 'Template':
			command 	=> "cpanm Template",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep Template | wc -l` -eq 0",
 			before 		=> Exec['URI']
		}	
		exec { 'URI':
			command 	=> "cpanm URI",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep URI | wc -l` -eq 0",
 			before 		=> Exec['List_MoreUtils']
		}		
		exec { 'List_MoreUtils':
			command 	=> "cpanm List::MoreUtils",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep List::MoreUtils | wc -l` -eq 0",
 			before 		=> Exec['Math_Random_ISAAC']
		}
		exec { 'Math_Random_ISAAC':
			command 	=> "cpanm Math::Random::ISAAC",
  			path 		=> $path,
  			user 		=> root,
 			onlyif  	=> "test `puppet module list | grep Math::Random::ISAAC | wc -l` -eq 0"
		}
	}

	#Declaration of the class
	#include perl
