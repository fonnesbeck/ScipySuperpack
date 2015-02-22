# Scipy Superpack for Homebrew

## Recent builds of fundamental Python scientific computing packages for OS X

This shell script will build and install the Python scientific stack, including [Numpy](https://github.com/numpy/numpy), [Scipy](https://github.com/scipy/scipy), [Matplotlib](https://github.com/matplotlib/matplotlib), [IPython](https://github.com/ipython/ipython), [Pandas](https://github.com/pydata/pandas), [Statsmodels](https://github.com/statsmodels/statsmodels), [Scikit-Learn](https://github.com/scikit-learn/scikit-learn), and [PyMC](https://github.com/pymc-devs/pymc) for OS X 10.10 (Yosemite) using the [Homebrew](http://brew.sh) package manager. The script will use recent development code from each package, which means that though some bugs may be fixed and features added, they also may be more unstable than the official releases. 

The SuperPack will install Python 2.7 or 3.2 from Homebrew and build all packages against it. 

### Dependencies

OS X 10.10 (Yosemite)

### Install

[Download Scipy Superpack Installer for OSX 10.10](https://raw.github.com/fonnesbeck/ScipySuperpack/master/install_superpack.sh)

To install, open a terminal in the directory that the script is located and call:

> sh install_superpack.sh

If you have not already installed the current Homebrew, Git, and the Xcode command line tools, these will be installed for you.

### Contact

Contact [Chris Fonnesbeck](https://github.com/fonnesbeck) or follow me on Twitter ([@fonnesbeck](http://twitter.com/fonnesbeck))

