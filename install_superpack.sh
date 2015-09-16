#!/bin/bash

# set -euvx

cd "$(mktemp -d -t install_superpack)"

readonly BREW_PATH="/usr/local/bin"
readonly BREW="${BREW_PATH}/brew"
readonly GIT="${BREW_PATH}/git"

if ! [[ -x "${BREW}" ]]; then
    if [[ "${BREW_PATH}" == /usr/local/bin ]]; then
        # Installing Homebrew...
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo 'You are using a custom homebrew location and I could not find the brew binary.'
        exit 1
    fi
fi

if ! [[ -x /usr/bin/clang ]]; then
    # No clang detected; Installing XCode Command Line Tools...
    xcode-select --install
fi

export PATH="${BREW_PATH}:${PATH}"

# Ensure Homebrew formulae are updated
"${BREW}" update

if ! [[ -x "${GIT}" ]]; then
    "${BREW}" install git
fi

# Add science tap
"${BREW}" tap homebrew/science

# Python tools and utilities
echo 'Would you like to use Python 2.7 or Python 3.5? (2/3)'
read -p '> ' PYVERSION
readonly PYVERSION

if [[ "${PYVERSION}" == "2" ]]; then
    "${BREW}" install python
    readonly PYTHON="${BREW_PATH}/python"
    readonly EASY_INSTALL="${BREW_PATH}/easy_install"
    readonly PIP="${BREW_PATH}/pip"
elif [[ "${PYVERSION}" == "3" ]]; then
    "${BREW}" install python3
    readonly PYTHON="${BREW_PATH}/python3"
    readonly EASY_INSTALL="${BREW_PATH}/easy_install-3.5"
    readonly PIP="${BREW_PATH}/pip3"
else
    echo "Invalid selection. Quitting."
    exit 1
fi

"${BREW}" install gcc
"${PIP}" install -U nose
"${PIP}" install -U six
"${PIP}" install -U pygments
"${PIP}" install -U sphinx
"${PIP}" install -U cython

# Jupyter
"${BREW}" install zeromq
"${PIP}" install -U jupyter

# Build from cloned repo to avoid SciPy build issue
"${GIT}" clone https://github.com/numpy/numpy.git numpy_temp
cd numpy_temp
"${PYTHON}" setupegg.py bdist_egg
"${EASY_INSTALL}" dist/*egg
cd ..
rm -rf numpy_temp

# SciPy
"${PIP}" install -U git+git://github.com/scipy/scipy

# Matplotlib
"${BREW}" install freetype
"${PIP}" install -U git+git://github.com/matplotlib/matplotlib.git

# Rest of the stack
"${PIP}" install -U git+git://github.com/pydata/pandas.git 
"${PIP}" install -U git+git://github.com/scikit-learn/scikit-learn.git
"${PIP}" install -U git+git://github.com/pymc-devs/pymc.git
"${PIP}" install -U git+git://github.com/statsmodels/statsmodels.git
"${PIP}" install -U git+git://github.com/Theano/Theano.git

# Release version of Bokeh and Seaborn
"${PIP}" install -U bokeh seaborn

# Install patsy
"${PIP}" install -U patsy

