
#enable iceCC 
configuration_option 'iceCC', 'boolean',
:default => 'no',
:doc => ["Enable Icecc?",
     "Icecc compiles distributed in the Network.",
     "If you have a slow machine, this speeds up compiling",
     "Do you want to use icecc for compiling sources [yes/no]"]
       

Autoproj.user_config('iceCC')
#the actural settings if enabled
if (Autoproj.user_config('iceCC')) then
	Autobuild.env_add_path('PATH','/usr/lib/icecc/bin')
	# icecc recommentds 15, so lets use it
	Autobuild.parallel_build_level = 50
	puts("You need to run source env.sh before changes take effect")
else
    puts("You need to restart the console and source env.sh before changes take effect")    
end	

