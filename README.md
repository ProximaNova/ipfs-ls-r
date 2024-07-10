# ipfs-ls-r
Recursively make a directory listing of an IPFS CID by using various methods

## How-to
While running a repo in read-only mode (to avoid downloading a lot), do this:
<br>(a) `ipfs refs -r --format="<src> -> <dst> = <linkname>" [cid]`

or this (in Bash in GNU/Linux):
<br>(b) `$ find /ipfs/$cid -printf "%Y %F %s %p\n" | xargs -d "\n" sh -c 'for args do
cid=$(echo "$args" | sed "s/^\S \S* \S* //g"); echo -n $(ipfs resolve "$cid" | sed
"s/\/ipfs\///g"); echo " $args"; done' _`

To run a repo in read-only mode, you can mount your file system as read only (RO).
Then symlink a different writeable IPFS repo to the RO IPFS repo. The read-write (RW) repo
might get messy so use one you don't really care about. Set the RW repo to `$IPFS_PATH`.
With method (b) you first must FUSE-mount IPFS. Soon ater publishing something to you
IPNS name, run this command: `ipfs daemon --mount`.

## See also
- READMEv2.md in https://github.com/ProximaNova/ipfs-ls-r/tree/main/ignore
- https://github.com/search?q=ipfs+traverse
- -> https://github.com/ipfs-examples/js-ipfs-traverse-ipld-graphs
- https://github.com/search?q=ipfs+recursive
- -> https://github.com/ajruckman/ipfs-indexer
