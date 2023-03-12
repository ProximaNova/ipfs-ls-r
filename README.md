# ipfs-ls-r
Recursively make a directory listing of an IPFS CID

This is currently a low-effort thing.

## Requirements
In order to recurse an IPFS folder with this script, you will first need:
- GNU/Linux
- Bash shell
- ipfs
- vim
- perl

## Usage
In order to show the contents of a folder in recursive way, do this:
- Run the IPFS daemon before running this script
- Download the script and run `chmod a+x ipfs-ls-r.sh`

Run the script like this:
- `./ipfs-ls-r.sh [depthnumber] [cid] [cidtoexclude]`
- Note: `cidtoexclude` is optional

## Todo
- Make it able to traverse all folders, with any max depth
- Replace perl command(s) with sed command(s)

## See also:
Larger codebases which should do the same thing, but probably work better than this script:
- https://github.com/search?q=ipfs+traverse
- -> https://github.com/ipfs-examples/js-ipfs-traverse-ipld-graphs
- https://github.com/search?q=ipfs+recursive
- -> https://github.com/ajruckman/ipfs-indexer
