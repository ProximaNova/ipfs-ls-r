# ipfs-ls-r
Recursively make a directory listing of an IPFS CID in Linux by using ipfs, vim, and perl

This is currently a ~low-effort thing. Important: you might be better off using `ipfs refs`. While this thing ("ipfs-ls-r") creates a nice directory listing in a specific format, it probably does not work in all situations. Some concerns over ipfs-ls-r: bugs, not working in different operating systems like Windows, not listing everything in a folder with deep subfolders. `ipfs refs` is an ipfs built-in command, and one could use something like `ipfs refs -r --format="<src> -> <dst> = <linkname>" [cid]` to get a recursive directory listing.

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
- Info: `cidtoexclude` is optional; `0` as `depthnumber` goes deeper than `1`

## Todo
- Make it able to traverse all folders, with any max depth
- Replace perl command(s) with sed command(s)

## See also:
Larger codebases which should do the same thing, but probably work better than this script:
- https://github.com/search?q=ipfs+traverse
- -> https://github.com/ipfs-examples/js-ipfs-traverse-ipld-graphs
- https://github.com/search?q=ipfs+recursive
- -> https://github.com/ajruckman/ipfs-indexer
