#!/bin/bash

# Derrow rPI setup


# Pre-Setup
sudo raspi-config
# Interface Options > enable SSH
# if Using CC1101 Module > enable SPI Interface.

# Install WiringPi
wget https://github.com/WiringPi/WiringPi/releases/download/2.61-1/wiringpi-2.61-1-armhf.deb
sudo dpkg -i wiringpi-2.61-1-armhf.deb


# Install RPITX
mkdir rpitx
cd rpitx
mkdir src
cd src
git clone https://github.com/F5OEO/librpitx
cd librpitx/src
make



cd ~



# Install Blootooth Libraries
sudo apt-get install libbluetooth-dev -y


# Install Rtl-sdr Libraries
sudo apt-get install librtlsdr-dev rtl-sdr build-essential autoconf cmake pkg-config -y


cd ~

# Install Soapy
git clone https://github.com/pothosware/SoapySDR.git
cd SoapySDR && mkdir build && cd build && cmake ..
make -j4
sudo make install
sudo ldconfig #needed on debian systems
sudo cp /home/pi/SoapySDR/build/lib/libSoapySDR.so.0.8.1 /usr/lib/libSoapySDR.so.0.8


cd ~


# If you have a HackRF One, install the HackRF library:

# sudo apt-get install hackrf libhackrf-dev
# git clone https://github.com/pothosware/SoapyHackRF.git
# cd SoapyHackRF
# mkdir build
# cd build
# cmake ..
# make
# sudo make install
# cd ~



# Install Derrow's module - RPi 4
mkdir rf
cd rf
wget -O rfcomm-server_v146PiPi4.tar https://www.dropbox.com/s/53ytn4lp0segaww/rfcomm-server_v146PiPi4.tar?dl=1
tar xvf rfcomm-server_v146PiPi4.tar


# RPi 3-
# wget -O rfcomm-server_v146.tar https://www.dropbox.com/s/tdmtaoi0crc73x9/rfcomm-server_v146.tar?dl=1
# tar xvf rfcomm-server_v146.tar


# Run!
sudo ./rfcomm-server -f 433920000


# if you get this error
# ./rfcomm-server: /lib/arm-linux-gnueabihf/libm.so.6: version `GLIBC_2.29' not found (required by ./rfcomm-server)
# ./rfcomm-server: /lib/arm-linux-gnueabihf/libstdc++.so.6: version `GLIBCXX_3.4.26' not found (required by ./rfcomm-server)
# check the GLIBC version with
# ldd --version



# ___________


### Hint: If the Anroid App will no longer connect with the Pi
### then following part has sometimes to be repeated after you have used
### sudo apt-get upgrade

 
# sudo nano /lib/systemd/system/bluetooth.service


### go to the line: ExecStart=/usr/lib/bluetooth/bluetoothd
### and append -C at the end:


# ExecStart=/usr/lib/bluetooth/bluetoothd -C


### Save and exit with: Ctrl+o -> Enter -> Ctrl+x
### restart


# systemctl daemon-reload
# sudo /etc/init.d/bluetooth restart




