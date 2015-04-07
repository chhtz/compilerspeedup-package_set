
#enable iceCC 
Autoproj.configuration_option 'iceCC', 'boolean',
:default => 'no',
:doc => ["Enable IceCC?",
     "IceCC compiles distributed in the Network.",
     "If you have a slow machine, this speeds up compiling",
     "Do you want to use icecc for compiling sources [yes/no]"]
       
Autoproj.configuration_option 'iceCC_parallel', 'string',
:default => '15',
:doc => ["Parallel build processes for IceCC?",
     "Sets default number of parallel builds",
     "More parallelism leads to more memory usage",
     "0 means no value (no. of processes can be set autoproj -p)",
     "15 is recommended by the IceCC developers"]
  
Autoproj.configuration_option 'ccache', 'boolean',
:default => 'no',
:doc => ["Enable ccache (compatible with icecc)?",
     "ccache caches build .o files",
     "it avoids rebuilding unchanged code",
     "Do you want to use ccache for compiling sources [yes/no]"]

Autoproj.configuration_option 'ccacheDir', 'string',
:default => 'default',
:doc => ["ccache cache directory (for this bootstrap)?",
     "A shared directory for several bootstraps is better",
     "Please set the directory, 'default' sets os default "]
          
Autoproj.configuration_option 'ccacheSize', 'string',
:default => '10G',
:doc => ["maximum ccache cache size?",
     "available suffixes: G, M and K",
     "Please set the size of the cache"]


     
if (Autoproj.user_config('ccache')) then
  Autoproj.add_build_system_dependency 'ccache'
  Autobuild.env_add_path('PATH','/usr/lib/ccache')
  
  if (Autoproj.user_config('ccacheDir')) then
      if Autoproj.user_config('ccacheDir') != 'default'
          Autobuild.env_add('CCACHE_DIR',Autoproj.user_config('ccacheDir')) 
      end
  end
  
  if (Autoproj.user_config('ccacheSize')) then
    cmd = "ccache -M #{Autoproj.user_config('ccacheSize')} > /dev/null"
    system(cmd)
  end
end

#Autoproj.user_config('iceCC')
#the actural settings if enabled
if (Autoproj.user_config('iceCC')) then
  Autoproj.add_build_system_dependency 'icecc'
  if (Autoproj.user_config('ccache')) then
    Autobuild.env_add('CCACHE_PREFIX','icecc')
  else
    Autobuild.env_add_path('PATH','/usr/lib/icecc/bin')  
  end
  
  #set parallel build level
	# icecc recommentds 15, so lets use it, 20 created full CPU usage when all 20 are used, build time base/orogen/types 1:41m
  # 15 does not create full cpu usage, build time base/orogen/types 1:52m, but ledd memory used
  
  if (Autoproj.user_config('iceCC_parallel').to_i > 0) then
    Autobuild.parallel_build_level = Autoproj.user_config('iceCC_parallel').to_i
  end
	Autoproj.message "You need to run source env.sh before changes take effect"
else
  Autoproj.message "You need to restart the console and source env.sh before changes take effect, in case iceCC was active before"
end	

