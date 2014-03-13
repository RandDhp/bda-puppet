	
	define perl::cpan (
	#class perl::cpan (
		$ensure 	= 'installed',
		$timeout	= 120
	){
		if $ensure == installed {
			exec { "cpan_load_${name}":
		  		path 	=> ['/usr/bin/','/bin'],
		   		command => "cpan -i ${name}",
		   		unless 	=> "pmvers ${name}",
		   		timeout => $timeout,
		   		require => [Package[$perl::package,$perl::pmtools_package],Exec['configure_cpan']],
		  	}
		} elsif $ensure == absent {
			if $name != "App::pmuninstall" {
				exec { "cpan_unload_${name}":
			  		path 	=> ['/usr/bin/','/bin','/usr/local/bin'],
			   		command => "pm-uninstall ${name}",
			   		onlyif 	=> "pmvers ${name}",
			   		timeout => $timeout,
			   		require => [Package[$perl::package,$perl::pmtools_package],		Exec['configure_cpan','install_pmuninstall']],
			  	}
			} else {
				warning("App::pmuninstall is required, and will not be uninstalled on ${fqdn}")
			}
		}
	}

	notify {"I'm notifying you 2.":}