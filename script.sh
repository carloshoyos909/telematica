#!/bin/bash

apt update
apt install docker-compose -y
apt install unzip -y
mkdir Pelicula 
cd Pelicula 
unzip ../Pelicula.zip
docker-compose up -d --bulid