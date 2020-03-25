#!/bin/bash
#install nmap if absent
for package in nmap ;
do dpkg -s "$package" > /dev/null 2>&1 &&  echo "$package is installed"  ||
if ping -c 2 -q -W 3 google.com > /dev/null 2>&1 ;
then
echo "Downloading packages" && if [ "$EUID" -ne 0 ] ;
then sudo apt-get install $package
else
apt-get install $package
fi
else
echo "My guy, hauna net.This is as far as  we can go"
exit
fi
done
#receive variables
echo -n "What is the IP : "
read my_var
echo -n "What is the start port No : "
read my_var2
echo -n "What is the end port No  : "
read my_var3
clear
printf "%+1s %-3s %-9s %-8s\n" port prot state service
#startPort gotta be lesser than the endPort
if [ $my_var2 -gt $my_var3 ]; then
echo "exiting coz startPort is greater than endport"
exit
else
b=0
while [ $b -lt $my_var3 ]
do  
if ping -c 2 -q -W 3 google.com > /dev/null 2>&1 ;
#internetcheck,if connectivity present,run nmap and display port,service and state
then 
nmap -Pn -p$my_var2 $my_var | awk 'NR==6'
else
#if no connectivity, target must be localhost
if [ $my_var = "127.0.0.1" ];
then
nmap --system-dns -p$my_var2 $my_var | awk 'NR==6'
elif [ $my_var = "localhost" ]
then 
nmap --system-dns -p$my_var2 $my_var | awk 'NR==7'
else
echo "Can't run online search offline"
exit
fi
fi
my_var2=`expr $my_var2 + 1`
b=`expr $b + 1`
done
fi