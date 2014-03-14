	#This module triggers all the scripts needed for Bugzilla´s instalation.

	#Definition of the class
	class bda-puppet {		
		#include db - good with config - config after what?
		#include web_server - good without config - config after installing bugzilla?
		#include perl - good - fix order - modules too slow
		#include bugzilla
		#include ssl
	}

	#Declaration of the class	
	include bda-puppet