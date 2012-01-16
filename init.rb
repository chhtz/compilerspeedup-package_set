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


    configuration_option 'ROCK_FLAVOR', 'string',
    :default => 'master',
    :values => ['stable', 'next', 'master'],
    :doc => [
        "TEST"]

    Autoproj.user_config('ROCK_FLAVOR')

#enable ccache 
#todo options at bootstrap
#    env_set 'CC',"/usr/lib/ccache/gcc"
#    env_set 'CXX',"/usr/lib/ccache/g++"###
#
#    env_set 'CMAKE_CXX_COMPILER_ARG1',"-m32"
#    env_set 'CMAKE_C_COMPILER_ARG1',"-m32"#
##
#
#    env_set 'CCACHE_PREFIX',"distcc"
#    env_set 'DISTCC_HOSTS',"CoHoN-3-u"

    #enable ccache
    Autobuild.parallel_build_level = 20

    env_set 'CC',"/usr/lib/ccache/gcc"
    env_set 'CXX',"/usr/lib/ccache/g++"

    env_set 'CCACHE_PREFIX',"distcc"
    #env_set 'DISTCC_HOSTS',"'localhost CoHoN-3-u aburchardt-u gaudig aduda-u uwdesktop fritsche'"
    #env_set 'DISTCC_HOSTS',"\"localhost CoHoN-3-u gaudig\""

    env_set 'CXXFLAGS',"-m32"
    env_set 'CFLAGS',"-m32"


