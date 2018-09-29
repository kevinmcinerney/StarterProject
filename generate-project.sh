#!/bin/bash

echo Updating Anaconda
conda update -y -n base conda

echo Creating Virtual Environment...
conda create -y --name $1 python=3.6

echo Activating Virtual Environment...
source activate $1

echo Adding project name to yml file
echo "$(tail -n +2 environment.yml)" > environment.yml #remove first line of yml file
A="name: "
A+=$1

echo "$A" | cat - environment.yml > temp && mv temp environment.yml # replace first line

echo Installing Libraries in Virtual Environment
conda env update --file environment.yml

mkdir $1


