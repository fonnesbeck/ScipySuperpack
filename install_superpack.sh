#!/bin/sh
PIP_PATH='/usr/local/bin'

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
echo 'Would you like to use Python 2.7 or Python 3.4? (2/3)'
read pyversion
if  [ "$pyversion" == "2" ]; then
    
    brew install python
    PIP=$PIP_PATH/pip2
    
elif [ "$pyversion" == "3" ]; then
    
    brew install python3
    PIP=$PIP_PATH/pip3
    
else
    echo "Invalid selection. Quitting."
    exit 0
fi
echo $PIP
brew install gcc
"${PIP}" install -U nose
"${PIP}" install -U six
"${PIP}" install -U patsy
"${PIP}" install -U pygments
"${PIP}" install -U sphinx
"${PIP}" install -U cython

# IPython
brew install zeromq
"${PIP}" install -U jinja2
"${PIP}" install -U tornado
"${PIP}" install -U pyzmq
"${PIP}" install -U jsonschema
"${PIP}" install -U git+git://github.com/ipython/ipython.git

# OpenBLAS for NumPy/SciPy
brew install openblas
export BLAS=/usr/local/opt/openblas/lib/libopenblas.a
export LAPACK=/usr/local/opt/openblas/lib/libopenblas.a

# Build from cloned repo to avoid SciPy build issue
git clone https://github.com/numpy/numpy.git numpy_temp
cd numpy_temp
python setupegg.py bdist_egg
easy_install dist/*egg
cd ..
rm -rf numpy_temp

# SciPy
"${PIP}" install -U git+git://github.com/scipy/scipy#egg=scipy-dev

# Matplotlib
brew install freetype
"${PIP}" install -U git+git://github.com/matplotlib/matplotlib.git

# Rest of the stack
"${PIP}" install -U git+git://github.com/pydata/pandas.git 
"${PIP}" install -U git+git://github.com/scikit-learn/scikit-learn.git
"${PIP}" install -U git+git://github.com/pymc-devs/pymc.git@2.3
"${PIP}" install -U git+git://github.com/statsmodels/statsmodels.git
"${PIP}" install -U git+git://github.com/Theano/Theano.git

# Release version of Bokeh
"${PIP}" install -U bokeh
