gitorious_long_doc = [
       "icecc compiles distributed in the Network, when installed.",
       "If you have a slow machine, this speeds up compiling",
       "Do you want to use icecc for compiling sources [yes/no]"]

configuration_option 'iceCC', 'string',
    :default => 'no',
    :possible_values => ['yes', 'no'],
    :doc => gitorious_long_doc do |value|
    #the actural settings if enabled
    if value == "yes" then
      Autoproj.change_option("iceCC", value)
      Autobuild.env_add_path('PATH','/usr/lib/icecc/bin')
      #increase parallel build level
      Autobuild.parallel_build_level = 50
      puts("You need to run source env.sh before changes take effect")
    else
      puts("You need to restart the console and source env.sh before changes take effect")
      Autoproj.change_option("iceCC", value)    
    end
    
    value
end

#Autoproj.user_config('iceCC')



