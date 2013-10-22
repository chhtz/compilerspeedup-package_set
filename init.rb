
#enable iceCC 
Autoproj.configuration_option 'iceCC', 'boolean',
:default => 'no',
:doc => ["Enable Icecc?",
     "Icecc compiles distributed in the Network.",
     "If you have a slow machine, this speeds up compiling",
     "Do you want to use icecc for compiling sources [yes/no]"]
       

#Autoproj.user_config('iceCC')
#the actural settings if enabled
if (Autoproj.user_config('iceCC')) then
	Autobuild.env_add_path('PATH','/usr/lib/icecc/bin')
  Autoproj.add_build_system_dependency 'icecc'
	# icecc recommentds 15, so lets use it, 20 created full CPU usage when all 20 are used, build time base/orogen/types 1:41m
  # 15 does not create full cpu usage, build time base/orogen/types 1:52m, but ledd memory used
	Autobuild.parallel_build_level = 15
	puts("You need to run source env.sh before changes take effect")
else
    puts("You need to restart the console and source env.sh before changes take effect, in case iceCC was active before")    
end	

