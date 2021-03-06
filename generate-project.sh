#!/bin/bash

project_name=${PWD##*/}

echo Updating Anaconda...
conda update -y -n base conda >/dev/null

echo Creating Virtual Environment...
conda create -y --name $project_name python=3.6 >/dev/null

echo Activating Virtual Environment...
source activate $project_name >/dev/null

echo Adding project name to yml file...
echo "$(tail -n +2 environment.yml)" > environment.yml #remove first line of yml file
A="name: "
A+=$project_name

echo "$A" | cat - environment.yml > temp && mv temp environment.yml # replace first line

echo Installing Libraries in Virtual Environment
conda env update --file environment.yml >/dev/null

echo Cloning xutils...
git clone https://github.com/kevinmcinerney/xutils.git >/dev/null

echo Installing xutils...
cd xutils
pip install . >/dev/null
cd ..
chown $USER:$USER xutils
chmod 777 xutils
rm -rf xutils

echo Entering virtual environment...
source activate $project_name >/dev/null
