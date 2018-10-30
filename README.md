## compilerspeedup-package_set

Including this package set in your buildconf will aks you questions about enabling programs that can speed up compiling.

* Adds support for disdtributed compiling 
* Adds support ccache
 * system wide cache for preprocessed headers to the resulting objects. (if found, no compilation is done, very useful for multiple checkouts)
* The gold linker (ldgold) can be selected to be used.

Ccache (compiler cache) and icecc (a.k.a. icecream distributed compiler) can be enabled both at the same time, but for only the buidlconf including this package set (enabled via env.sh). 

## Configuration Options

WARNING: To really change the enabled/disables setting a `amake --force-build` is required because the full compiler path is cached by cmake (e.g. /opt/icecc/g++)

### Icecc
* enable/disable distributed compiling
* number of parallel builds

### Ccache
* enable/disable ccache
* cache storage location
* cache size
 * WARNING: the cache size is stored globally in the os, compiling another checkout with lesser setting may delete cache contents

### ldgold
* enable/disable