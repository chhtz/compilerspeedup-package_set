printed = false

Autoproj.manifest.each_autobuild_package do |pkg|
    case pkg
    when Autobuild::CMake, Autobuild::Autotools
        if (Autoproj.user_config('ccache')) then
            pkg.depends_on 'ccache'
            Autobuild.env_add_path('PATH', '/usr/lib/ccache')
  
            if (Autoproj.user_config('ccacheDir')) then
                if Autoproj.user_config('ccacheDir') != 'default'
                    Autobuild.env_add('CCACHE_DIR', Autoproj.user_config('ccacheDir')) 
                end
            end
            
            if (Autoproj.user_config('ccacheSize')) then
                if !system('ccache', '-M', Autoproj.config.get('ccacheSize').to_s, out: '/dev/null') && !printed then 
                    Autoproj.error "Couldn't set ccache size"
                    printed = true
                end
            end

            #Autoproj.user_config('iceCC')
            #the actural settings if enabled
            if (Autoproj.user_config('iceCC')) then
                pkg.depends_on 'icecc'
                if (Autoproj.user_config('ccache')) then
                    Autobuild.env_add('CCACHE_PREFIX', 'icecc')
                else
                    Autobuild.env_add_path('PATH', '/usr/lib/icecc/bin')  
                end
      
                #set parallel build level
                # icecc recommentds 15, so lets use it, 20 created full CPU usage when all 20 are used, build time base/orogen/types 1:41m
                # 15 does not create full cpu usage, build time base/orogen/types 1:52m, but ledd memory used
                
                if (Autoproj.user_config('iceCC_parallel').to_i > 0) then
                    Autobuild.parallel_build_level = Autoproj.user_config('iceCC_parallel').to_i
                end
            end 
        end
    end
end
