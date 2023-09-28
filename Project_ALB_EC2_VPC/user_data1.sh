#!/bin/bash


####
# NAME: PRADIP KUMAR
# THIS IS A SCRIPT TO GET RESPONSE FROM SERVER TO CKECK LOADEBALANCER IS WORKING.  
####

#Install apache2

apt-get update -y
apt-get install -y apache2

echo "<h1>Hello, this is a response from the server IP address - $(hostname -f)</h1>" > /var/www/html/index.html
