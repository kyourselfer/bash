#!/bin/bash
#
# Tells me everything
x=$(date)
y=`uptime -p`
echo -e "\nToday is $x \n\tand we are $y \n" | mail -s "Info" root


