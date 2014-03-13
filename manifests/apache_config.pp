    
	#Sets up a virtual host with SSL and specific SSL certificates
    apache::vhost { '15.185.237.107':
      port     => '443',
      docroot  => '/var/www/bugzilla',
      ssl      => true,
      ssl_cert => '/etc/ssl/bugzilla_houston_hp_com.crt',
      ssl_key  => '/etc/ssl/bugzilla_houston_hp_com.key',
    }