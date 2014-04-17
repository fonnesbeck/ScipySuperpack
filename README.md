# Scipy Superpack

## Recent builds of fundamental Python scientific computing packages for OS X

This shell script will install recent 64-bit builds of [Numpy](https://github.com/numpy/numpy) (1.8) and [Scipy](https://github.com/scipy/scipy) (0.13), [Matplotlib](https://github.com/matplotlib/matplotlib) (1.4), [IPython](https://github.com/ipython/ipython) (1.0), [Pandas](https://github.com/pydata/pandas) (0.12), [Statsmodels](https://github.com/statsmodels/statsmodels) (0.5.0), [Scikit-Learn](https://github.com/scikit-learn/scikit-learn) (0.14), and [PyMC](https://github.com/pymc-devs/pymc) (2.2 alpha) for OS X 10.9 (Lion) on Intel Macintosh. All builds are based on recent development code from each package, which means though some bugs may be fixed and features added, they also may be more unstable than the official releases. Distributing them together should improve interoperability, since the supporting packages (Scipy, Matplotlib, PyMC) were all built against the accompanying build of Numpy. These packages were compiled on OS X 10.9 using Apple’s Python 2.7.5, gFortran 4.2.4 and GCC 4.2.1. To avoid compatibility issues, the installer also optionally downloads and installs the gFortran compiler that is compatible with Xcode 4.2. Before you install the Superpack, ensure that Xcode command line tools are installed on your system.

Caveat emptor: These builds contain development (i.e. pre-release) code that may not be free of critical bugs. I encourage all users to run the appropriate unit tests on each package to ensure that any extant issues do not affect your work. Please report any errors that may be the result of build issues.

### Dependencies

OS X 10.9 (Mavericks), Python 2.7.5, Xcode 5.1 command line tools

### Install

[Download Scipy Superpack Installer for OSX 10.7](https://raw.github.com/fonnesbeck/ScipySuperpack/master/install_superpack.sh)

To install, open a terminal in the directory that the script is located and call:

> sh install_superpack.sh

You will be prompted for your administrator password. If you have already installed the current gFortran, you can bypass that package during the install process. Similarly, the installation requires Git, so you will be prompted to install it if you are installing remotely.

### Contact

Contact [Chris Fonnesbeck](https://github.com/fonnesbeck) or follow me on Twitter ([@fonnesbeck](http://twitter.com/fonnesbeck))

