#!/bin/bash

sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2

MYIP=`ifconfig | grep -E '(inet addr:10)' | awk '{ print $2 }' | cut -d ':' -f 2`

echo 'Hello World this is my IP: '$MYIP > /var/www/html/index.html 

echo "The page was created by the user data" | sudo tee /var/www/html/index.html
