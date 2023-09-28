#!/bin/bash

#install apache2
apt-get update -y
apt-get install -y apache2

echo "<h1>Hello, this is a response from the server IP address - $(hostname -f)</h1>" > /var/www/html/index.html
