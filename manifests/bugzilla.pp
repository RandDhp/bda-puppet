
	class bugzilla(
		#Creates a directory for puppet to work with configuration
		file {"/etc/bugzilla/.puppet":
			ensure => directory,
			mode => 0755,
			owner => "root",
			group => "root"
		}
	)

	define bugzilla::project (
		$admin_email,
		$admin_password,
		$admin_realname,
		$create_htaccess = false,
		$webservergroup = 'apache',
	  	$db_driver = 'mysql',
	  	$db_host = 'localhost',
	 	$db_name = 'bugzilla',
	  	$db_user = 'bugzilla',
	  	$db_pass = '',
	  	$db_port = 0,
	  	$db_sock = '',
	  	$db_check = true,
	  	$index_html = false,
	  	$cvsbin = '/usr/bin/cvs',
	  	$interdiffbin = '/usr/bin/interdiff',
	  	$diffpath = '/usr/bin',
	  	$site_wide_secret = '',
		$smtp_server = 'localhost'
	){

		require("bugzilla")

		$bz_confdir = "/etc/bugzilla/"
		case $name {
			"main": {
				$localconfigfile = "${bz_confdir}localconfig"
				$backupconfigfile = "${bz_confdir}.puppet/localconfig"
				$answerconfigfile = "${bz_confdir}.puppet/answer"
				$envexport = "DUMMY=foo"
			}
			/(.*)/: {
				$localconfigfile = "${bz_confdir}localconfig.${name}"
				$backupconfigfile = "${bz_confdir}.puppet/localconfig.${name}"
				$answerconfigfile = "${bz_confdir}.puppet/answer.${name}"
				$envexport = "PROJECT=${name}"
			}
		}