# plain-linpack
HPL Benchmark in a container

## Variants

### Dockerfile.amd
An image that aims to use the AMD libraries and compiles HPL from scratch.
Even though it works, it should have a lot of headroom to be optimized (as of 2019-07-25).

### Dockerfile.ihpl
To build the image downloading the [INTEL Optimized Linpack](https://software.intel.com/en-us/articles/intel-mkl-benchmarks-suite) is needed. Place the `tgz` in the `./src` folder.

### Dockerfile.intel
Like the amd one, this Dockerfile aims to compile everything from scratch.

