base_cmake = Autobuild::Package['base/cmake']

if (Autoproj.user_config('ccache')) then
  base_cmake.depends_on 'ccache'
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
  base_cmake.depends_on 'icecc'
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