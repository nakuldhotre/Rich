#!/bin/bash
echo "RAR-JTR Decrypt Script";
if [ $# -ne 2 ]
then
echo "Usage $0 <rarfile> <wordlist>";
exit;
fi
rar l $1
for i in $(john --wordlist=$2 --rules --stdout) 
do
 echo -ne "\rtrying \"$i\" " 
 rar e -o+ -inul -p$i $1 >/dev/null 
 STATUS=$?
 if [ $STATUS -eq 0 ]; then
 echo -e "\nArchive password is: \"$i\"" 
 break
 fi
done
