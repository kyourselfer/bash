#!/bin/bash
#
p=`pwd`
files=`ls $p`
echo -e "\nYou are here $p\n"
for x in $files
	do
		echo -e "\t$x"
done


