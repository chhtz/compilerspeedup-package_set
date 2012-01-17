# Write in this file customization code that will get executed before 
# autoproj is loaded.

# Set the path to 'make'
# Autobuild.commands['make'] = '/path/to/ccmake'

# Set the parallel build level (defaults to the number of CPUs)
# Autobuild.parallel_build_level = 10

# Uncomment to initialize the environment variables to default values. This is
# useful to ensure that the build is completely self-contained, but leads to
# miss external dependencies installed in non-standard locations.
#
# set_initial_env
#
# Additionally, you can set up your own custom environment with calls to env_add
# and env_set:
#
# env_add 'PATH', "/path/to/my/tool"
# env_set 'CMAKE_PREFIX_PATH', "/opt/boost;/opt/xerces"
# env_set 'CMAKE_INSTALL_PATH', "/opt/orocos"
#
# NOTE: Variables set like this are exported in the generated 'env.sh' script.
#

require 'autoproj/gitorious'
Autoproj.gitorious_server_configuration('GITORIOUS', 'gitorious.org')
Autoproj.gitorious_server_configuration('SPACEGIT', 'spacegit.dfki.uni-bremen.de')

Autoproj.env_inherit 'CMAKE_PREFIX_PATH'
Autoproj.shell_helpers = false



#todo
#use more options "wrapper path", ccache only
#option to replace /etc/default/distcc

#enable ccache
    configuration_option 'CCache', 'string',
    :default => 'no',
    :values => ['yes', 'no'],
    :doc => ["Do you want to use ccache for compiling sources [yes/no]"]

    Autoproj.user_config('CCache')

#enable distcc
    configuration_option 'DistCC', 'string',
    :default => 'no',
    :values => ['yes', 'no'],
    :doc => ["Do you want to use distcc for compiling sources [yes/no]"]

    Autoproj.user_config('DistCC')








#the actural settings

if (Autoproj.user_config('CCache') == 'yes') then
	puts "CCache config"
    Autobuild.parallel_build_level = 20

    env_set 'CC',"/usr/lib/ccache/gcc"
    env_set 'CXX',"/usr/lib/ccache/g++"

end


if (Autoproj.user_config('DistCC') == 'yes') then
	
    if (Autoproj.user_config('CCache') == 'yes') then
    	env_set 'CCACHE_PREFIX',"distcc"
    	puts "Ditscc + ccache config"
    else
    	puts "Ditscc only config"
        env_set 'CC',"/usr/lib/distcc/gcc"
        env_set 'CXX',"/usr/lib/distcc/g++"
    end
    
    #env_set 'DISTCC_HOSTS',"'localhost CoHoN-3-u aburchardt-u gaudig aduda-u uwdesktop fritsche'"
    #env_set 'DISTCC_HOSTS',"\"localhost CoHoN-3-u gaudig\""


   configuration_option 'DistCCArch', 'string',
    :default => '32',
    :values => ['32', '64'],
    :doc => ["Which Architecture do you use? [gcc opttion for -m like [32,64]]"]
    Autoproj.user_config('DistCCArch')
    env_set 'CXXFLAGS',"-m" + Autoproj.user_config('DistCCArch')
    env_set 'CFLAGS',"-m" + Autoproj.user_config('DistCCArch')

#   configuration_option 'DistCCBuildLevel', 'fixnum',
#    :default => '20',
#    :values => [],
#    :doc => ["How many parallel builds should be preferred?"]
#    Autoproj.user_config('DistCCBuildLevel')
#
#    Autobuild.parallel_build_level = Autoproj.user_config('DistCCBuildLevel')
    Autobuild.parallel_build_level = 20

   configuration_option 'useDistCCDir', 'string',
    :default => 'yes',
    :values => ['yes','no'],
    :doc => ["Should a different host list be used ? (the DFKI host list needs the package 'compilerspeedup')"]
    Autoproj.user_config('useDistCCDir')

	if (Autoproj.user_config('useDistCCDir') == 'yes') then
        configuration_option 'DistCCDir', 'string',
        :default => Autoproj.root_dir() + '/external/compilerspeedup',
        :values => [],
        :doc => ["Set your distcc directory (where the hosts file is located)",
                 "in case of DFKI host list the compilerspeedup package folder"]
        Autoproj.user_config('DistCCDir')
    
		env_set 'DISTCC_DIR', Autoproj.user_config('DistCCDir')

    end
	
#	env_set 'DISTCC_HOSTS','"localhost gaudig"'

else
    env_set 'CXXFLAGS',""
    env_set 'CFLAGS',""	
    
end	

if (Autoproj.user_config('DistCC') == 'no' && Autoproj.user_config('CCache') == 'no') then
    env_set 'CXX',""
    env_set 'CC',""	
end


