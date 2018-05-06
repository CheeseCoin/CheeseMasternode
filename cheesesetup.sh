#!/bin/bash
# This script will install all dependencies to run a CheeseCoin (CHEESE) Masternode.
# !! THIS SCRIPT NEED TO RUN AS ROOT WITH EXCECUTABLE PERMISSION !!
######################################################################
clear
echo "*********** Welcome to the CheeseCoin (CHEESE) Masternode Setup Script ***********"
echo 'This script will install all required updates & package for Ubuntu 16.04 !'
echo '**********************************************************************************'
echo -n "Please enter your masternode genkey and hit [ENTER]: "
read mngenkey
echo 'NO MORE USER INPUT IS REQUIRED! The entire process will take around 30 minutes.'
sleep 3
echo 'Creating 2GB Swapfile'
dd if=/dev/zero of=/mnt/mybtdxswap.swap bs=2M count=1000 >/dev/null 2>&1
mkswap /mnt/mybtdxswap.swap >/dev/null 2>&1
swapon /mnt/mybtdxswap.swap >/dev/null 2>&1
echo 'Running updates and install required packages'
sudo apt-get install software-properties-common -y >/dev/null 2>&1
sudo add-apt-repository ppa:bitcoin/bitcoin -y >/dev/null 2>&1
sudo apt-get update -y >/dev/null 2>&1
sudo apt-get install build-essential -y >/dev/null 2>&1
sudo apt-get install libtool -y >/dev/null 2>&1
sudo apt-get install autotools-dev -y >/dev/null 2>&1
sudo apt-get install automake -y >/dev/null 2>&1
sudo apt-get install pkg-config -y >/dev/null 2>&1
sudo apt-get install libssl-dev -y >/dev/null 2>&1
sudo apt-get install libevent-dev -y >/dev/null 2>&1
sudo apt-get install bsdmainutils -y >/dev/null 2>&1
sudo apt-get install libboost-all-dev -y >/dev/null 2>&1
sudo apt-get install libdb4.8-dev -y >/dev/null 2>&1
sudo apt-get install libdb4.8++-dev -y >/dev/null 2>&1
sudo apt-get install libminiupnpc-dev -y >/dev/null 2>&1
sudo apt-get install libzmq3-dev -y >/dev/null 2>&1
sudo apt-get install git -y >/dev/null 2>&1
sudo apt-get install nano -y >/dev/null 2>&1
sudo apt-get install tmux -y >/dev/null 2>&1
sudo apt-get install libgmp3-dev -y >/dev/null 2>&1
sleep 1
echo 'Downloading CheeseCoin Wallet'
git clone https://github.com/CheeseCoin/CheeseMasternode makefile.unix >/dev/null 2>&1
echo 'Cloning and Compiling CheeseCoin Wallet'
echo 'THIS PROCESS WILL TAKE A LONG TIME WITHOUT NOTIFICATIONS ON THIS SCREEN! PLEASE BE PATIENT!'
cd CheeseMasternode/src/leveldb && chmod 777 * && cd .. && make -f makefile.unix >/dev/null 2>&1
echo 'Configuring Cheese.conf'
echo "alias cheesed='~/CheeseMasternode/src/cheesed'" >> ~/.bashrc
./cheesed >/dev/null 2>&1
sleep 5
./cheesed stop >/dev/null 2>&1
touch ~/.Cheese/Cheese.conf >/dev/null 2>&1
usrnam=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
usrpas=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
vpsip=$(curl -s4 icanhazip.com)
echo -e "rpcuser=$usrnam \nrpcpassword=$usrpas \nlisten=1 \nserver=1 \ndaemon=1 \nrpcallowip=127.0.0.1 \n \nport=44700 \nmasternode=1 \nmasternodeaddr=$vpsip:44700 \nmasternodeprivkey=$mngenkey \n" > ~/.Cheese/Cheese.conf
echo 'Server Start'
./cheesed -daemon >/dev/null 2>&1
echo 'Wait until the blockchain is synced to start your alias. You can check the blockheight with the getinfo command'
sleep 1
echo 'Enjoy your Masternode!'
sleep 1
echo 'USEFUL CHEESED COMMANDS'
echo 'cheesed getinfo - This command can be used to check block height and other information'
echo 'cheesed masternode status - This command can be used to see the status of your masternode. status 9 means running without issue'
echo 'cheesed masternode debug - This command can be used if you do not get the status 9 from above. '
