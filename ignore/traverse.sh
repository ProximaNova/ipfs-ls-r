#!/bin/bash
#run: ./thisscript.sh [CID here]
level0c=$1
for x in {1..4}
do
  eval1+='fast=$(ipfs ls $level'"$(expr $x - 1)"'c | xxd -ps -)
    for a'"$(expr $x - 1)"' in $(eval echo {1..$(echo $fast | xxd -ps -r - | wc -l)})
      do
        level'"$x"'=$(echo $fast | xxd -ps -r - | tail +$a'"$(expr $x - 1)"' | head -n 1)
        level'"$x"'c=$(echo $fast | xxd -ps -r - | tail +$a'"$(expr $x - 1)"' | head -n 1 | sed "s/ .*//g")
        echo -n '$ev'; echo $level'"$x"'
    '
  ev+='-'
  evalend+='done; '
done
eval1="$eval1""$evalend"
eval "$eval1"
