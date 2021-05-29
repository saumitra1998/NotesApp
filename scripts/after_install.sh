#!/bin/bash
set -e
echo building
# here we just use npm to run the build
cd /home/ec2-user/notes-app
echo building frontend application...
cd client
sudo npm run build
cd ..
echo building backend application...
sudo npm run build