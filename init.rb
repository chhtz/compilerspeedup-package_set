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

#enable iceCC ?
Autoproj.env_inherit 'CMAKE_PREFIX_PATH'

gitorious_long_doc = [
       "Enable icecc?",
       "icecc compiles distributed in the Network, when installed.",
       "If you have a slow machine, this speeds up compiling",
       "Do you want to use icecc for compiling sources [yes/no]"]

configuration_option 'iceCC', 'string',
:default => 'no',
:possible_values => ['yes', 'no'],
:doc => gitorious_long_doc do |value|
    #the actural settings if enabled
    if (value == 'yes') then
      Autobuild.env_add_path('PATH','/usr/lib/icecc/bin')
      Autoproj.change_option("iceCC", value)
      # icecc recommentds 15, so lets use it
      Autobuild.parallel_build_level = 50
      puts("You need to run source env.sh before changes take effect")
    else
      puts("You need to restart the console and source env.sh before changes take effect")
      Autoproj.change_option("iceCC", value)    
    end
    
    value
end

Autoproj.user_config('iceCC')



