#!/bin/bash

# this file is being executed in /opt/codedeploy-agent/deployment-root/47../<deployment_id>/

#stdout logs of this process executing can be found in /opt/codedeploy-agent/deployment-root/47../<deployment_id>/logs/scripts.log

# here we update the server and install node and npm
echo installing dependencies
sudo yum update -y
curl -fsSL https://rpm.nodesource.com/setup_14.x | sudo bash -
sudo yum install nodejs -y

# check to make sure the symbolic link for nodejs node exists
echo checking for nodejs symlink
file="/usr/bin/node"
if [ -f $file ] && [ ! -L $file ] ; then
  echo "$file exists and is not a symlink"
  sudo ln -s /usr/bin/nodejs
else
  echo "$file exists and is already a symlink"
fi

# install the application using npm
# we need to traverse to where the application bundle is copied too.
echo installing backend dependencies with npm
cd /home/ec2-user/notes-app
sudo npm install

echo installing pm2
sudo npm install pm2 -g

echo installing frontend dependencies with npm
cd client
sudo npm install
cd ..
