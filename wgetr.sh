#!/bin/bash
#This just curls a whole /24 network and makes the output pretty
mkdir wgetr
i=1
echo "First 3 octets of network?"
read net
echo "Port#"
read p
echo "" > wgetr.txt
while [ $i -le 254 ]
do
    cmd=$(echo -n read_input | timeout 0.7 curl $net\.$i:$p > otxt.txt)
    if [ -s otxt.txt ] #if the file exists and has a size greater than 0
    then
        echo "==========================================================================$
        echo "$net.$i port $p" >> wgetr.txt
        cat otxt.txt >> wgetr.txt
        echo -n read_input | wget -P ./wgetr/$net\.$ip -r $net\.$i:$p
        echo "" >> wgetr.txt
    else
        echo "false"
    fi
    $((i++))
done
cat wgetr.txt
