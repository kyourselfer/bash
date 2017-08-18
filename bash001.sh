#!/bin/bash
echo -e "Are hungry?\n YES or NO\n"
read VAL01
if [ $VAL01 = ["YES"||"yes"] ];
	then
		echo "Make a meal pls."
else
	echo "Continue working"
fi
