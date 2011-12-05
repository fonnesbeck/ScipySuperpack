#!/bin/sh
PYTHON=/usr/bin/python
GIT_DMG=git-1.7.7.3-intel-universal-snow-leopard.dmg
GIT_PKG='git-1.7.7.3-intel-universal-snow-leopard.pkg'
GIT_VOLUME='/Volumes/Git 1.7.7.3 Snow Leopard Intel Universal/'
GFORTRAN=gfortran-lion-5666-3.pkg

echo 'The Scipy Superpack requires Git for installation. Would you like to install it now (say no if already installed)? (y/n)'
read install
if  [ "$install" == "y" ] || [ "$install" == "Y" ]; then
  echo 'Downloading Git for OS X ...'
  curl -o ${GIT_DMG} http://git-osx-installer.googlecode.com/files/${GIT_DMG}
  echo 'Installing Git ...'
  hdiutil mount ${GIT_DMG}
  sudo installer -pkg "${GIT_VOLUME}${GIT_PKG}" -target '/'
  hdiutil unmount "${GIT_VOLUME}"

elif [ "$install" == "n" ] || [ "$install" == "N" ]; then
  echo 'Skipping Git install.'
else
  echo 'Did not recognize input. Exiting'
  exit 0
fip

echo 'Would you like to install gFortran (recommended, and required if not already installed)? (y/n)'
read install
if  [ "$install" == "y" ] || [ "$install" == "Y" ]; then
  echo 'Downloading gFortran ...'
  curl -o ${GFORTRAN} http://r.research.att.com/${GFORTRAN}
  echo 'Installing gFortran ...'
  sudo installer -pkg ${GFORTRAN} -target '/'

elif [ "$install" == "n" ] || [ "$install" == "N" ]; then
  echo 'Skipping gFortran install.'
else
  echo 'Did not recognize input. Exiting'
  exit 0
fi
  
echo 'Cloning Scipy Superpack'
git clone git://github.com/fonnesbeck/ScipySuperpack.git

echo 'Downloading ez_setup ...'
curl -o ez_setup.py http://peak.telecommunity.com/dist/ez_setup.py
echo 'Installing ez_setup ...'
sudo "${PYTHON}" ez_setup.py

echo 'Installing numpy ...'
sudo "${PYTHON}" -m easy_install -N -Z ScipySuperpack/numpy-*.egg
echo 'Installing matplotlib ...'
sudo "${PYTHON}" -m easy_install -N -Z ScipySuperpack/matplotlib-*.egg
echo 'Installing scipy ...'
sudo "${PYTHON}" -m easy_install -N -Z ScipySuperpack/scipy-*.egg
echo 'Installing pandas ...'
sudo "${PYTHON}" -m easy_install -N -Z ScipySuperpack/pandas-*.egg
echo 'Installing pymc ...'
sudo "${PYTHON}" -m easy_install -N -Z ScipySuperpack/pymc-*.egg
echo 'Installing ipython ...'
sudo "${PYTHON}" -m easy_install -N -Z ScipySuperpack/ipython-*.egg

echo 'Installing readline ...'
sudo "${PYTHON}" -m easy_install -N -Z readline
echo 'Installing nose ...'
sudo "${PYTHON}" -m easy_install -N -Z nose
echo 'Installing DateUtils'
sudo "${PYTHON}" -m easy_install -N -Z DateUtils

echo 'Cleaning up'
rm -rf ScipySuperpack

echo 'Done'