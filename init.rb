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
    :doc => ["Enable ccache?",
             "CCache chaches your preprocessor output and according binaries.",
             "It can speed up recompiling",
             "To clear the buffer call \"ccache -C\"",
             "Do you want to use ccache for compiling sources [yes/no]"]

    Autoproj.user_config('CCache')

#enable distcc
    configuration_option 'DistCC', 'string',
    :default => 'no',
    :values => ['yes', 'no'],
    :doc => ["Enable distcc?",
             "Distcc compiles distributed in the Network.",
             "If you have a slow machine, this speeds up compiling",
             "Do you want to use distcc for compiling sources [yes/no]"]

    Autoproj.user_config('DistCC')



#the actural settings

if (Autoproj.user_config('CCache') == 'yes') then
    env_set 'CC',"/usr/lib/ccache/gcc"
    env_set 'CXX',"/usr/lib/ccache/g++"

end


if (Autoproj.user_config('DistCC') == 'yes') then
	
    if (Autoproj.user_config('CCache') == 'yes') then
    	env_set 'CCACHE_PREFIX',"distcc"
    else
        env_set 'CC',"/usr/lib/distcc/gcc-4.4"
        env_set 'CXX',"/usr/lib/distcc/g++-4.4"
    end
    
    #env_set 'DISTCC_HOSTS',"'localhost CoHoN-3-u aburchardt-u gaudig aduda-u uwdesktop fritsche'"
    #env_set 'DISTCC_HOSTS',"\"localhost CoHoN-3-u gaudig\""


#   configuration_option 'DistCCArch', 'string',
#    :default => '32',
#    :values => ['32', '64'],
#    :doc => ["Which Architecture do you use? [gcc opttion for -m like [32,64]]"]
#    Autoproj.user_config('DistCCArch')
#    env_set 'CXXFLAGS',"-m" + Autoproj.user_config('DistCCArch')
#    env_set 'CFLAGS',"-m" + Autoproj.user_config('DistCCArch')

#   configuration_option 'DistCCBuildLevel', 'fixnum',
#    :default => '20',
#    :values => [],
#    :doc => ["How many parallel builds should be preferred?"]
#    Autoproj.user_config('DistCCBuildLevel')
#
#    Autobuild.parallel_build_level = Autoproj.user_config('DistCCBuildLevel')
    Autobuild.parallel_build_level = 30

   configuration_option( 'useDistCCDir', 'string',
    :default => 'yes',
    :values => ['yes','no'],
    :doc => [   "Use DFKI distcc Server List?",
                "There is a list of DFKI distcc servers.",
                "The servers are checked for availability on sourcing env.sh",
                "(the DFKI host list needs the package 'distcc_conf')",
                 "Add this to your manifest:",
                 "layout:\n    - external:\n        - distcc_conf",
                "Should the DFKI host list be used?",
                "(if no, you need to set up /etc/distcc/hosts manually) ? [yes/no]"])
    Autoproj.user_config('useDistCCDir')

	if (Autoproj.user_config('useDistCCDir') == 'yes') then
        configuration_option 'DistCCDir', 'string',
        :default => Autoproj.root_dir() + '/external/distcc_conf',
        :values => [],
        :doc => ["Set the location of the distcc_conf package",
                 "(where the hosts file and updatedistcchosts.sh is located)"]
        Autoproj.user_config('DistCCDir')
    
	env_set 'DISTCC_DIR', Autoproj.user_config('DistCCDir')
        env_set 'CC',Autoproj.user_config('DistCCDir') + "/ccache_gcc"
        env_set 'CXX',Autoproj.user_config('DistCCDir') + "/ccache_g++"
	env_set 'CCACHE_PREFIX',"distcc"
	
        Autobuild.env_source_file(Autoproj.user_config('DistCCDir') + "/updatedistcchosts.sh")

    end
	
#	env_set 'DISTCC_HOSTS','"localhost gaudig"'

else
    puts("You need to restart the console and source env.sh before changes take effect")
#    STDIN.readline
#    system("unset CXXFLAGS")
#    system("unset CFLAGS")
    #env_set 'CXXFLAGS',""
    #env_set 'CFLAGS',""	
    
end	

if (Autoproj.user_config('DistCC') == 'no' && Autoproj.user_config('CCache') == 'no') then
    puts("You need to restart the console and source env.sh before changes take effect")
#    STDIN.readline
#    system("unset CXX")
#    system("unset CC")
#    env_set 'CXX',""
#    env_set 'CC',""	
end


