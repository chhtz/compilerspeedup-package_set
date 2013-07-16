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

Autoproj.env_inherit 'CMAKE_PREFIX_PATH'
#enable iceCC 
configuration_option 'iceCC', 'string',
:default => 'no',
:values => ['yes', 'no'],
:doc => ["Enable icecc?",
     "Distcc compiles distributed in the Network.",
     "If you have a slow machine, this speeds up compiling",
     "Do you want to use icecc for compiling sources [yes/no]"]

Autoproj.user_config('iceCC')
#the actural settings if enabled
if (Autoproj.user_config('iceCC') == 'yes') then
	Autobuild.env_add_path('PATH','/usr/lib/icecc/bin')
	# icecc recommentds 15, so lets use it
	Autobuild.parallel_build_level = 15
	puts("You need to run source env.sh before changes take effect")
else
    puts("You need to restart the console and source env.sh before changes take effect")    
end	


