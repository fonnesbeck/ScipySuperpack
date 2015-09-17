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

# Add Python tap
"${BREW}" tap homebrew/python

# Python tools and utilities
echo 'Would you like to use Python 2.7 or Python 3.5? (2/3)'
read -p '> ' PYVERSION
readonly PYVERSION

if [[ "${PYVERSION}" == "2" ]]; then
    "${BREW}" install python
    readonly PYTHON="${BREW_PATH}/python"
    readonly EASY_INSTALL="${BREW_PATH}/easy_install"
    readonly PIP="${BREW_PATH}/pip"
    readonly FLAGS="--with-python"
elif [[ "${PYVERSION}" == "3" ]]; then
    "${BREW}" install python3
    readonly PYTHON="${BREW_PATH}/python3"
    readonly EASY_INSTALL="${BREW_PATH}/easy_install-3.5"
    readonly PIP="${BREW_PATH}/pip3"
    readonly FLAGS="--with-python3 --without-python"
else
    echo "Invalid selection. Quitting."
    exit 1
fi

"${PIP}" install --upgrade pip setuptools

"${BREW}" install gcc
"${PIP}" install -U pygments
"${PIP}" install -U sphinx
"${PIP}" install -U cython

# Jupyter
"${BREW}" install zeromq
"${PIP}" install -U jupyter

# NumPy and SciPy
"${BREW}" install numpy "${FLAGS}"
"${BREW}" link --overwrite numpy
"${BREW}" install scipy --default-fortran-flags "${FLAGS}"

# Numba
"${BREW}" install numba "${FLAGS}"

# Matplotlib
"${BREW}" install freetype
"${BREW}" install matplotlib "${FLAGS}"

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

