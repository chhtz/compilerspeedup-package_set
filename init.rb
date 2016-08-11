
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

Autoproj.configuration_option 'ldgold', 'boolean',
:default => 'no',
:doc => ["Use gold linker ? [yes/no]"]


Autoproj.configuration_option 'ccacheDir', 'string',
:default => 'default',
:doc => ["ccache cache directory (for this bootstrap)?",
     "A shared directory for several bootstraps is better",
     "Please set the directory, 'default' sets os default "]
          
Autoproj.configuration_option 'ccacheSize', 'string',
:default => '10G',
:doc => ["maximum ccache cache size?",
     "available suffixes: G (default), M and K",
     "Please set the size of the cache"]


if (Autoproj.user_config('ldgold')) then
  Autobuild.env_add('CXXFLAGS',' -fuse-ld=gold')
end

