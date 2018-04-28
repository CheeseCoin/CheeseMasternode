#!/bin/bash
# This script will install all dependencies to run a CheeseCoin (CHEESE) Masternode.
# CheeseCoin Repo : https://github.com/CheeseCoin/CheeseMasternode
# !! THIS SCRIPT NEED TO RUN AS ROOT !!
######################################################################
clear
echo "*********** Welcome to the CheeseCoin (CHEESE) Masternode Setup Script ***********"
echo 'This script will install all required updates & package for Ubuntu 16.04 !'
echo '**********************************************************************************'
sleep 2
echo '*** Step 1/5 ***'
sleep 1
echo '*** Creating 2GB Swapfile ***'
sleep 1
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
sleep 1
echo '*** Done 1/5 ***'
echo '*** Step 2/5 ***'
echo '*** Running updates and install required packages ***'
sleep 1
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:bitcoin/bitcoin
sudo apt-get update -y
sudo apt-get install build-essential -y
sudo apt-get install libtool -y
sudo apt-get install autotools-dev -y
sudo apt-get install automake -y
sudo apt-get install pkg-config -y
sudo apt-get install libssl-dev -y
sudo apt-get install libevent-dev -y
sudo apt-get install bsdmainutils -y
sudo apt-get install libboost-all-dev -y
sudo apt-get install libdb4.8-dev -y
sudo apt-get install libdb4.8++-dev -y
sudo apt-get install libminiupnpc-dev -y
sudo apt-get install libzmq3-dev -y
sudo apt-get install git -y
sudo apt-get install nano -y
sudo apt-get install tmux -y
sudo apt-get install libgmp3-dev -y
echo '*** Done 2/5 ***'
sleep 1
echo '*** Step 3/5 ***'
sleep 1
echo '*** Cloning and Compiling CheeseCoin Wallet ***'
sleep 1
echo '*** THIS PROCESS WILL TAKE A LONG TIME ***'
sleep 1
git clone https://github.com/CheeseCoin/CheeseMasternode
cd CheeseMasternode/src/leveldb && chmod 777 * && cd .. && make -f makefile.unix
echo '*** Done 3/5 ***'
sleep 1
echo '*** Step 4/5 ***'
sleep 1
echo '*** Configure Cheese.conf ***'
sleep 1
./cheesed
echo 'Please wait'
sleep 10
./cheesed stop
touch /root/.Cheese/Cheese.conf
echo -n "Please enter a username and hit [ENTER]: "
read usrnam
echo -n "Please enter a password and hit [ENTER]: "
read usrpas
echo -n "Please enter your vps ip respond and hit [ENTER]: "
read vpsip
echo -n "Please enter your masternode genkey and hit [ENTER]: "
read mngenkey
echo -e "rpcuser=$usrnam \nrpcpassword=$usrpas \nlisten=1 \nserver=1 \ndaemon=1 \nrpcallowip=127.0.0.1 \n \nport=44700 \nmasternode=1 \nmasternodeaddr=$vpsip:44700 \nmasternodeprivkey=$mngenkey \n" > /root/.Cheese/Cheese.conf
echo '*** Done 4/5 ***'
sleep 1
echo '*** Step 5/5 ***'
sleep 1
echo '*** Server Start also Wallet Sync ***'
sleep 1
./cheesed -daemon
echo 'Wait until the blockchain is synced to start your alias. This script will end in 5 minutes...'
sleep 60
echo '4 minutes left...'
sleep 60
echo '3 minutes left...'
sleep 60
echo '2 minutes left...'
sleep 60
echo '1 minutes left...'
sleep 60
./cheesed getinfo
echo 'Check the block number above to the current block height of the CheeseCoin blockchain to make sure your daemon is fully synced'
sleep 1
echo 'Enjoy your Masternode!'
sleep 1
echo '*** Done 5/5 ***'
