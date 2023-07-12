#!/bin/bash
#usage: ./thisscript.sh $depthnumber $cid $cidtoexclude
echo "INFO - You may want to run the ipfs daemon before running this script."
ipfs ls $2 > output1.txt

if [ -z ${3+x} ]
then
    # var is unset
    echo -n ''
else
    # Exclude a folder via adding " " to the end of the line.
    echo "INFO - /ipfs/$3 has been excluded."
    vim -c "%s/\($3.*\)/\1 /g | wq" output1.txt
fi

if [ $1 -eq 1 ]
then
    echo 'INFO - Max depth is 1, exiting.'
    exit 0
elif [ $1 -eq 0 ]
then
    # done: shows the contents of multiple folders
    # todo: handle filenames with ampersands properly
    cids=$(grep "/$" output1.txt | wc -l)
    x=0
    while [ $x -lt $cids ]
    do
        cid1=$(grep "/$" output1.txt | head -n 1 | sed "s/ .*//g")   
        cid_ls=$(ipfs ls $cid1 | sed "s/\//\x5c\x5c\//g" | sed "s/^/ /g" | perl -pE "s/\n/\\\\\\r/g" | perl -pE "s/&/\\\\\\\\\&/g")
	echo $cid_ls >> output4.txt
        echo 'execute "%s/\\('$cid1'.*\\)/\\1 \\r'$cid_ls'/g"' > output2.txt
       	echo 'execute "%s/\\n\\n/\\r/g"' >> output2.txt
	echo 'execute "wq"' >> output2.txt
	vim "output1.txt" -c 'execute "so output2.txt"'
	x=$(( $x + 1 ))
    done
    echo 'INFO - Level 2 done.'
    if [ $(grep "^ .*/$" output1.txt | wc -l) -gt 0 ]
    then
        cids=$(grep "/$" output1.txt | wc -l)
	x=0
	while [ $x -lt $cids ]
        do
            cid1=$(grep "^ \S.*/$" output1.txt | head -n 1 | sed "s/^ //g" | sed "s/ .*//g")
            cid_ls=$(ipfs ls $cid1 | sed "s/\//\x5c\x5c\//g" | sed "s/^/| /g" | perl -pE "s/\n/\\\\\\r/g" | perl -pE "s/&/\\\\\\\\\&/g")
            echo 'execute "%s/\\('$cid1'.*\\)/\\1 \\r'$cid_ls'/g"' > output2.txt
            echo 'execute "%s/\\n\\n/\\r/g"' >> output2.txt
            echo 'execute "wq"' >> output2.txt
            vim "output1.txt" -c 'execute "so output2.txt"'
            x=$(( $x + 1 ))
        done
        echo 'INFO - Level 3 done.'
    fi
    if [ $(grep "^| \S.*/$" output1.txt | wc -l) -gt 0 ]
    then
        cids=$(grep "/$" output1.txt | wc -l)
        x=0
        while [ $x -lt $cids ]
        do
            cid1=$(grep "^| \S.*/$" output1.txt | head -n 1 | sed "s/^| //g" | sed "s/ .*//g")
            cid_ls=$(ipfs ls $cid1 | sed "s/\//\x5c\x5c\//g" | sed "s/^/|| /g" | perl -pE "s/\n/\\\\\\r/g" | perl -pE "s/&/\\\\\\\\\&/g")
            echo 'execute "%s/\\('$cid1'.*\\)/\\1 \\r'$cid_ls'/g"' > output2.txt
            echo 'execute "%s/\\n\\n/\\r/g"' >> output2.txt
            echo 'execute "wq"' >> output2.txt
	    vim "output1.txt" -c 'execute "so output2.txt"'
            x=$(( $x + 1 ))
        done
	echo 'INFO - Level 4 done.'
    fi
    if [ $(grep "^|| \S.*/$" output1.txt | wc -l) -gt 0 ]
    then
        cids=$(grep "/$" output1.txt | wc -l)
        x=0
        while [ $x -lt $cids ]
        do
            cid1=$(grep "^|| \S.*/$" output1.txt | head -n 1 | sed "s/^|| //g" | sed "s/ .*//g")
            cid_ls=$(ipfs ls $cid1 | sed "s/\//\x5c\x5c\//g" | sed "s/^/||| /g" | perl -pE "s/\n/\\\\\\r/g" | perl -pE "s/&/\\\\\\\\\&/g")
            echo 'execute "%s/\\('$cid1'.*\\)/\\1 \\r'$cid_ls'/g"' > output2.txt
            echo 'execute "%s/\\n\\n/\\r/g"' >> output2.txt
            echo 'execute "wq"' >> output2.txt
            vim "output1.txt" -c 'execute "so output2.txt"'
            x=$(( $x + 1 ))
        done
        echo 'INFO - Level 5 done.'
    fi
fi
