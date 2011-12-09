#!/bin/sh
PYTHON='/usr/bin/python'
GIT_DMG='git-1.7.7.3-intel-universal-snow-leopard.dmg'
GIT_PKG='git-1.7.7.3-intel-universal-snow-leopard.pkg'
GIT_VOLUME='/Volumes/Git 1.7.7.3 Snow Leopard Intel Universal/'
GFORTRAN='gfortran-lion-5666-3.pkg'


if [ -z "$VIRTUAL_ENV" ]; then
    # Standard Python env
    PYTHON=/usr/bin/python
    SUDO=${SUDO}
else
    # Virtualenv
    PYTHON=python
    SUDO="" #${SUDO} is not required in a virtualenv
fi

echo 'Are you installing from a repository cloned to this machine (if unsure, answer no)? (y/n)'
read local
if  [ "$local" == "y" ] || [ "$local" == "Y" ]; then
    
    SUPERPACK_PATH='.'
    
elif [ "$local" == "n" ] || [ "$local" == "N" ]; then
    
    SUPERPACK_PATH='ScipySuperpack'
    
    hash git &> /dev/null
    if [ $? -eq 1 ]; then
        echo 'Downloading Git for OS X ...'
        curl -o ${GIT_DMG} http://git-osx-installer.googlecode.com/files/${GIT_DMG}
        echo 'Installing Git ...'
        hdiutil mount ${GIT_DMG}
        ${SUDO} installer -pkg "${GIT_VOLUME}${GIT_PKG}" -target '/'
        hdiutil unmount "${GIT_VOLUME}"
        echo 'Cleaning up'
        rm ${GIT_DMG}
    fi
    
    echo 'Cloning Scipy Superpack'
    git clone git://github.com/fonnesbeck/ScipySuperpack.git
else
    echo 'Did not recognize input. Exiting'
    exit 0
fi

hash gfortran &> /dev/null
if [ $? -eq 1 ]; then
    echo 'Downloading gFortran ...'
    curl -o ${GFORTRAN} http://r.research.att.com/${GFORTRAN}
    echo 'Installing gFortran ...'
    ${SUDO} installer -pkg ${GFORTRAN} -target '/'
fi

hash easy_install &> /dev/null
if [ $? -eq 1 ]; then
    echo 'Downloading ez_setup ...'
    curl -o ez_setup.py http://peak.telecommunity.com/dist/ez_setup.py
    echo 'Installing ez_setup ...'
    ${SUDO} "${PYTHON}" ez_setup.py
fi

echo 'Installing Scipy Superpack ...'
${SUDO} "${PYTHON}" -m easy_install -N -Z ${SUPERPACK_PATH}/*.egg

echo 'Installing readline ...'
${SUDO} "${PYTHON}" -m easy_install -N -Z readline
echo 'Installing nose ...'
${SUDO} "${PYTHON}" -m easy_install -N -Z nose
echo 'Installing DateUtils'
${SUDO} "${PYTHON}" -m easy_install -N -Z DateUtils

echo 'Cleaning up'
if [ -z "$VIRTUAL_ENV" ]; then
    rm ez_setup.py
fi

if  [ "$local" == "n" ] || [ "$local" == "N" ]; then    
    rm -rf ${SUPERPACK_PATH}
fi

echo 'Done'