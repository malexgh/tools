#!/bin/bash

if [ -z "$USER_EMAIL" ] || [ -z "$USER_NAME" ] || [ -z "$GH_USER_NAME" ]
then
  echo "USER_EMAIL=$USER_EMAIL"
  echo "USER_NAME=$USER_NAME"
  echo "GH_USER_NAME=$GH_USER_NAME"
  echo "SET VARIABLES FIRST for Git/GitHub config"
  exit 1
fi

exec > install_ubuntu_env.log
exec 2>&1

sudo apt-get update

# Curl
sudo apt-get -y install curl

# Git
sudo apt-get -y install git
git config --global user.email "$USER_EMAIL"
git config --global user.name "$USER_NAME"
ssh-keygen -t rsa -b 4096 -C "$USER_EMAIL"
# add this new key on GitHub to use SSH

# GitHub Public Repos
curl "https://api.github.com/users/$GH_USER_NAME/repos?page=1&per_page=100" |
  grep -e 'git_url*' |
  cut -d \" -f 4 |
  xargs -L1 git clone

# Node.js
# sudo snap install node --classic --channel=10
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
source ~/.nvm/nvm.sh
source ~/.profile
source ~/.bashrc
nvm install --lts
npm install -g expo-cli
npm install -g react-native-cli

# Google Chrome
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# sudo dpkg -i google-chrome-stable_current_amd64.deb
# rm google-chrome-stable_current_amd64.deb

# Chromium
sudo snap install chromium

# Postman
sudo snap install postman

# Insomnia
# sudo snap install insomnia

# Android Studio
sudo snap install android-studio --classic
# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools

# MongoDB Compass *** CHECK LATEST VERSION
sudo apt-get -y install libgconf-2-4
wget https://downloads.mongodb.com/compass/mongodb-compass_1.19.12_amd64.deb
sudo dpkg -i mongodb-compass_1.19.12_amd64.deb
# rm mongodb-compass_1.19.12_amd64.deb

# Robo3t
# 

# Meld
sudo apt-get -y install meld

# VSCode
sudo snap install code --classic

# Docker
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
sudo docker version
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Kubernets
sudo apt-get -y install virtualbox
VBoxManage -version
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo install minikube /usr/local/bin
# rm minikube
minikube version
export CHANGE_MINIKUBE_NONE_USER=true
sudo -E minikube start --vm-driver=none
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
chmod +x skaffold
sudo mv skaffold /usr/local/bin
