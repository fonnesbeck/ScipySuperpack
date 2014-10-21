#!/bin/sh

hash brew &> /dev/null
if [ $? -eq 1 ]; then
    echo 'Installing Homebrew ...'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Ensure Homebrew formulae are updated
brew update

hash git &> /dev/null
if [ $? -eq 1 ]; then
    echo 'Installing Git ...'
    brew install git
fi

hash gcc &> /dev/null
if [ $? -eq 1 ]; then
    echo 'No gcc detected; Installing XCode Command Line Tools ...'
    xcode-select --install
fi

# Add science tap
brew tap homebrew/science

# Python tools and utilities
brew install python
brew install gcc
pip install -U nose
pip install -U six
pip install -U patsy
pip install -U pygments
pip install -U sphinx
pip install -U cython

# IPython
brew install zeromq
pip install -U jinja2
pip install -U tornado
pip install -U pyzmq
pip install -U git+git://github.com/ipython/ipython.git

# OpenBLAS for NumPy/SciPy
brew install openblas
export BLAS=/usr/local/opt/openblas/lib/libopenblas.a
export LAPACK=/usr/local/opt/openblas/lib/libopenblas.a

# Build from cloned repo to avoid SciPy build issue
git clone git@github.com:numpy/numpy.git numpy_temp
cd numpy_temp
python setupegg.py bdist_egg
easy_install dist/*egg
cd ..
rm -rf numpy_temp

# SciPy
pip install -U git+git://github.com/scipy/scipy#egg=scipy-dev

# Matplotlib
brew install freetype
pip install -U git+git://github.com/matplotlib/matplotlib.git

# Rest of the stack
pip install -U git+git://github.com/pydata/pandas.git 
pip install -U git+git://github.com/scikit-learn/scikit-learn.git
pip install -U git+git://github.com/pymc-devs/pymc.git@2.3
pip install -U git+git://github.com/statsmodels/statsmodels.git
pip install -U git+git://github.com/Theano/Theano.git

# Release version of Bokeh
pip install -U bokeh
