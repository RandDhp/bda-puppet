	#This module triggers all the scripts needed for Bugzilla´s instalation

	#Definition of the class
	class bda-puppet {		
		include mysql
		include apache
		include perl
		#include bugzilla
		#include ssl

		#Checar orden
	}

	#Declaration of the class	
	include bda-puppet