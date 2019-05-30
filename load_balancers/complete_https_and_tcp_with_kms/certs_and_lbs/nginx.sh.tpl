#!/bin/bash

sudo yum install nginx -y
sudo chkconfig nginx on 
sudo service nginx start