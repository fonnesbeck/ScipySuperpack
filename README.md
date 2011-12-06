# Scipy Superpack

## Recent builds of fundamental Python scientific computing packages for OS X 

This shell script will install recent 64-bit builds of [Numpy](https://github.com/numpy/numpy) (2.0) and [Scipy](https://github.com/scipy/scipy) (0.11), [Matplotlib](https://github.com/matplotlib/matplotlib) (1.2), [iPython](https://github.com/ipython/ipython) (0.12), [Pandas](https://github.com/wesm/pandas) (0.6), as well as [PyMC](https://github.com/pymc-devs/pymc) (2.2 alpha) for OS X 10.7 (Lion) on Intel Macintosh. All builds are based on recent development code from each package, which means though some bugs may be fixed and features added, they also may be more unstable than the official releases. Distributing them together should improve interoperability, since the supporting packages (Scipy, Matplotlib, PyMC) were all built against the accompanying build of Numpy. These packages were compiled on OS X 10.7 using Apple’s Python 2.7.1, gFortran 4.2.3 and LLVM-GCC 4.2.1 (build 5658). To avoid compatibility issues, the installer also optionally downloads and installs the gFortran compiler that is compatible with Xcode 4.2. Before you install the Superpack, ensure that Xcode 4.2 is installed on your system.

Caveat emptor: These builds contain development (i.e. pre-release) code that may not be free of critical bugs. I encourage all users to run the appropriate unit tests on each package to ensure that any extant issues do not affect your work. Please report any errors that may be the result of build issues.

### Dependencies

OS X 10.7 (Lion), Python 2.7, Xcode 4.2

### Install

[Download Scipy Superpack Installer for OSX 10.7](https://raw.github.com/fonnesbeck/ScipySuperpack/master/install_superpack.sh) (Updated 30 November 2011)

To install, open a terminal in the directory that the script is located and call:

> sh install_superpack.sh

You will be prompted for your administrator password. If you have already installed the current gFortran, you can bypass that package during the install process. Similarly, the installation requires Git, so you will be prompted to install it if you are installing remotely.

### Contact

Contact [Chris Fonnesbeck](https://github.com/fonnesbeck) or follow me on Twitter ([@fonnesbeck](twitter.com/fonnesbeck))

