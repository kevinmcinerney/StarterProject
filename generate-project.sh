#!/bin/bash

project_name=${PWD##*/}

echo Updating Anaconda...
echo 
conda update -y -n base conda >/dev/null

echo Creating Virtual Environment...
echo 
conda create -y --name $project_name python=3.6 >/dev/null

echo Activating Virtual Environment...
echo 
source activate $project_name >/dev/null

echo Adding project name to yml file...
echo "$(tail -n +2 environment.yml)" > environment.yml #remove first line of yml file
A="name: "
A+=$project_name

echo "$A" | cat - environment.yml > temp && mv temp environment.yml # replace first line
echo 

echo Installing Libraries in Virtual Environment
echo 
conda env update --file environment.yml >/dev/null

echo Cloning xutils...
echo 
git clone https://github.com/kevinmcinerney/xutils.git

echo Installing xutils...
echo 
cd xutils
pip install . >dev/null

echo Entering virtual environment...
echo 
subprocess.run('source activate '$project_name, shell=True) >dev/null

