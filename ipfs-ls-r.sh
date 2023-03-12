#!/bin/bash
#usage: ./thisscript.sh $depthnumber $cid $cidtoexclude
x20=" "
echo "INFO - Run the ipfs daemon before running this script."
ipfs ls $2 > output1.txt

if [ -z ${3+x} ]
then
    # var is unset
    echo -n ''
else
    # Exlude a folder via adding " " to the end of the line.
    echo "INFO - Excluding $3"
    vim -c "%s/\($3.*\)/\1 /g | wq" output1.txt
fi

if [ $1 -eq 1 ]
then
    echo 'INFO - Max depth is 1, exiting.'
    exit 0
elif [ $1 -eq 0 ]
then
    # shows only the contents of one folder
    # todo: should show the contents of multiple folders
    cid1=$(grep "/$" output1.txt | head -n 1 | sed "s/ .*//g")
    cids=$(grep "/$" output1.txt | wc -l)
    cid_ls=$(ipfs ls $cid1 | sed "s/\//\x5c\//g" | sed "s/^/ /g" | perl -pE "s/\n/\\\r/g")
    vim -c "%s/\($cid1.*\)/\1 \r$cid_ls/g | %s/\n\n/\r/g | wq" output1.txt
    if [ $(grep "^ .*/$" output1.txt | wc -l) -gt 0 ]
    then
        cids=$(grep "/$" output1.txt | wc -l)
	x=0
	while [ $x -lt $cids ]
        do
            cid1=$(grep "^ \S.*/$" output1.txt | head -n 1 | sed "s/^ //g" | sed "s/ .*//g")
            cid_ls=$(ipfs ls $cid1 | sed "s/\//\x5c\//g" | sed "s/^/ $x20/g" | perl -pE "s/\n/\\\r/g")
            vim -c "%s/\($cid1.*\)/\1 \r$cid_ls/g | %s/\n\n/\r/g | wq" output1.txt
            x=$(( $x + 1 ))
        done
    fi
    if [ $(grep "^ $x20\S.*/$" output1.txt | wc -l) -gt 0 ]
    then
        cids=$(grep "/$" output1.txt | wc -l)
        x=0
        while [ $x -lt $cids ]
        do
            cid1=$(grep "^ $x20\S.*/$" output1.txt | head -n 1 | sed "s/^ $x20//g" | sed "s/ .*//g")
            cid_ls=$(ipfs ls $cid1 | sed "s/\//\x5c\//g" | sed "s/^/ $x20$x20/g" | perl -pE "s/\n/\\\r/g")
            vim -c "%s/\($cid1.*\)/\1 \r$cid_ls/g | %s/\n\n/\r/g | wq" output1.txt
            x=$(( $x + 1 ))
        done
    fi
    if [ $(grep "^ $x20$x20\S.*/$" output1.txt | wc -l) -gt 0 ]
    then
        cids=$(grep "/$" output1.txt | wc -l)
        x=0
        while [ $x -lt $cids ]
        do
            cid1=$(grep "^ $x20$x20\S.*/$" output1.txt | head -n 1 | sed "s/^ $x20$x20//g" | sed "s/ .*//g")
            cid_ls=$(ipfs ls $cid1 | sed "s/\//\x5c\//g" | sed "s/^/ $x20$x20$x20/g" | perl -pE "s/\n/\\\r/g")
            vim -c "%s/\($cid1.*\)/\1 \r$cid_ls/g | %s/\n\n/\r/g | wq" output1.txt
            x=$(( $x + 1 ))
        done
    fi
fi
