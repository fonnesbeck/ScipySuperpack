#!/bin/sh
PYTHON=/usr/bin/python
SERVER=https://github.com/fonnesbeck/ScipySuperpack/raw/master

echo 'Would you like to install gFortran (recommended, and required if not already installed)? (y/n)'
read install
if  [ "$install" == "y" ] || [ "$install" == "Y" ]; then
  echo 'Downloading gFortran ...'
  curl -o gfortran-lion-5666-3.pkg http://r.research.att.com/gfortran-lion-5666-3.pkg
  echo 'Installing gFortran ...'
  sudo installer -pkg 'gfortran-lion-5666-3.pkg' -target '/'

elif [ "$install" == "n" ] || [ "$install" == "N" ]; then
  echo 'Skipping gFortran install.'
else
  echo 'Did not recognize input. Exiting'
  exit 0
fi
echo 'Downloading ez_setup ...'
curl -o ez_setup.py http://peak.telecommunity.com/dist/ez_setup.py
echo 'Installing ez_setup ...'
sudo "${PYTHON}" ez_setup.py
echo 'Installing numpy ...'
sudo "${PYTHON}" -m easy_install -N -Z ${SERVER}/numpy-2.0.0.dev_eb46577_20111130-py2.7-macosx-10.7-x86_64.egg
echo 'Installing matplotlib ...'
sudo "${PYTHON}" -m easy_install -N -Z ${SERVER}/matplotlib-1.2.x-py2.7-macosx-10.7-intel.egg
echo 'Installing scipy ...'
sudo "${PYTHON}" -m easy_install -N -Z ${SERVER}/scipy-0.11.0.dev_f47d2f1_20111130-py2.7-macosx-10.7-x86_64.egg
echo 'Installing pandas ...'
sudo "${PYTHON}" -m easy_install -N -Z ${SERVER}/pandas-0.6.1_20111130-py2.7-macosx-10.7-x86_64.egg
echo 'Installing pymc ...'
sudo "${PYTHON}" -m easy_install -N -Z ${SERVER}/pymc-2.2alpha-py2.7-macosx-10.7-intel.egg
echo 'Installing readline ...'
sudo "${PYTHON}" -m easy_install -N -Z readline
echo 'Installing ipython ...'
sudo "${PYTHON}" -m easy_install -N -Z ${SERVER}/ipython-0.12.beta-py2.7.egg
echo 'Installing nose ...'
sudo "${PYTHON}" -m easy_install -N -Z nose
echo 'Installing DateUtils'
sudo "${PYTHON}" -m easy_install -N -Z DateUtils
echo 'Done'