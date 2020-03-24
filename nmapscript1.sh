#!/bin/bash
echo -n "What is the IP?"
read my_var
echo -n "What is the start port No ?"
read my_var2
b=0
while [ $b -lt 101 ]
do   nmap -Pn -p$my_var2 $my_var | awk 'NR==6'
my_var2=`expr $my_var2 + 1`
b=`expr $b + 1`
done
