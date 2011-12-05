#!/bin/sh
PYTHON='/usr/bin/python'
GIT_DMG='git-1.7.7.3-intel-universal-snow-leopard.dmg'
GIT_PKG='git-1.7.7.3-intel-universal-snow-leopard.pkg'
GIT_VOLUME='/Volumes/Git 1.7.7.3 Snow Leopard Intel Universal/'
GFORTRAN='gfortran-lion-5666-3.pkg'

echo 'Are you installing from a repository cloned to this machine (if unsure, answer no)? (y/n)'
read local
if  [ "$local" == "y" ] || [ "$local" == "Y" ]; then
    
    SUPERPACK_PATH='.'
    
elif [ "$local" == "n" ] || [ "$local" == "N" ]; then
    
    SUPERPACK_PATH='ScipySuperpack'
    
    echo 'The Scipy Superpack requires Git for installation. Would you like to install it now (say no if already installed)? (y/n)'
    read install_git
    if  [ "$install_git" == "y" ] || [ "$install_git" == "Y" ]; then
        echo 'Downloading Git for OS X ...'
        curl -o ${GIT_DMG} http://git-osx-installer.googlecode.com/files/${GIT_DMG}
        echo 'Installing Git ...'
        hdiutil mount ${GIT_DMG}
        sudo installer -pkg "${GIT_VOLUME}${GIT_PKG}" -target '/'
        hdiutil unmount "${GIT_VOLUME}"

    elif [ "$install_git" == "n" ] || [ "$install_git" == "N" ]; then
      echo 'Skipping Git install.'
    else
      echo 'Did not recognize input. Exiting'
      exit 0
    fi
    
    echo 'Cloning Scipy Superpack'
    git clone git://github.com/fonnesbeck/ScipySuperpack.git
else
    echo 'Did not recognize input. Exiting'
    exit 0
fi

echo 'Would you like to install gFortran (recommended, and required if not already installed)? (y/n)'
read install_gfortran
if  [ "$install_gfortran" == "y" ] || [ "$install_gfortran" == "Y" ]; then
    echo 'Downloading gFortran ...'
    curl -o ${GFORTRAN} http://r.research.att.com/${GFORTRAN}
    echo 'Installing gFortran ...'
    sudo installer -pkg ${GFORTRAN} -target '/'

elif [ "$install_gfortran" == "n" ] || [ "$install_gfortran" == "N" ]; then
    echo 'Skipping gFortran install.'
else
    echo 'Did not recognize input. Exiting'
    exit 0
fi

echo 'Downloading ez_setup ...'
curl -o ez_setup.py http://peak.telecommunity.com/dist/ez_setup.py
echo 'Installing ez_setup ...'
sudo "${PYTHON}" ez_setup.py

echo 'Installing Scipy Superpack ...'
sudo "${PYTHON}" -m easy_install -N -Z ${SUPERPACK_PATH}/*.egg

echo 'Installing readline ...'
sudo "${PYTHON}" -m easy_install -N -Z readline
echo 'Installing nose ...'
sudo "${PYTHON}" -m easy_install -N -Z nose
echo 'Installing DateUtils'
sudo "${PYTHON}" -m easy_install -N -Z DateUtils

echo 'Cleaning up'
rm ez_setup.py
if  [ "$local" == "n" ] || [ "$local" == "N" ]; then    
    rm -rf ${SUPERPACK_PATH}
fi

echo 'Done'