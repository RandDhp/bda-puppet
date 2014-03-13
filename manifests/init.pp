	#This module triggers all the scripts needed for Bugzilla´s instalation.

	#Definition of the class
	class bda-puppet {		
		#include db
		#include web_server
		#include perl
		#include bugzilla
		#include ssl
	}

	#Declaration of the class	
	include bda-puppet