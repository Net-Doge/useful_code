#!/bin/bash
#This just curls a whole /24 network and makes the output pretty
i=1
while [ $i -le 255 ]
do
 echo "=================================================================================" >> ocurl.txt
 echo 10.50.26.$i >> ocurl.txt
 echo -n read_input | timeout 0.3 curl 10.50.26.$i >> ocurl.txt
  $((i++))
 echo "" >> ocurl.txt
 echo "" >> ocurl.txt
done
