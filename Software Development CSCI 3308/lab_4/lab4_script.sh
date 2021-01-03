#!/bin/bash
# Authors : Kyle Moe
# Date: 09/17/2020

cp /var/log/syslog ~
egrep -i "error" ~/syslog | tee error_log_check.txt
mail kymo8133@colorado.edu < error_log_check.txt
