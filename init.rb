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
# Autoproj.shell_helpers = false



#todo
#use more options "wrapper path", ccache only
#option to replace /etc/default/distcc


#enable distcc
    configuration_option 'iceCC', 'string',
    :default => 'no',
    :values => ['yes', 'no'],
    :doc => ["Enable icecc?",
             "Distcc compiles distributed in the Network.",
             "If you have a slow machine, this speeds up compiling",
             "Do you want to use icecc for compiling sources [yes/no]"]

    Autoproj.user_config('iceCC')



#the actural settings


if (Autoproj.user_config('iceCC') == 'yes') then
        env_set 'PATH=/usr/lib/icecc/bin:$PATH'
    end
	puts("You need to run source env.sh before changes take effect")
    Autobuild.parallel_build_level = 10

else
    puts("You need to restart the console and source env.sh before changes take effect")    
end	

