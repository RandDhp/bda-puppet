	#This module triggers all the scripts needed for Bugzilla´s instalation.

	#Definition of the class
	class bda-puppet {
		include perl
		#include db
		#include web_server
		#include bugzilla
		#include ssl
	}

	#Declaration of the class	
	include bda-puppet