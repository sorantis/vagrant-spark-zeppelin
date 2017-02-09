#!/usr/bin/env bash

echo "Cleaning up ..."
apt-get clean
rm -rf /var/lib/apt/lists/*

rm /home/vagrant/spark-2.1.0-bin-hadoop2.6.tgz
