# ipfs-ls-r
Recursively make a directory listing of an IPFS CID by using Python

## Before installing
This is currently a ~medium-effort thing, and depending on your situation, running something like `ipfs refs -r --format="<src> -> <dst> = <linkname>" [cid]` to get a recursive directory listing might be better. Comparing `ipfs refs` with this script:
- `ipfs refs` tries to download all of the data when you are creating a listing, so, for example, if you only have a 1 TB HDD and want to make an index of a 4 TB CID/folder, I'm thinking you couldn't do that; or, if you can, you may not want to download around 1 TB in one month (especially if using a metered connection)
- This script "does not download anything", or downloads very little, so you can create a recursive directory listing of a large remote CID without worrying about that
- `ipfs refs` does not show the size in bytes of each CID in whatever CID; this script does. The only concern with putting the filesize before the filename is with filenames that start with whitespace, like " file.mlp", though this is rare
- This script probably wastes time running `ipfs object links [leaf node CID]`; I guess `ipfs refs` can somehow detect leaf nodes, so it doesn't try to look for more CIDs in them

## Requirements
In order to recurse an IPFS folder with this script, you will first need:
- ipfs - a version that supports `ipfs object links` (which is currently all/most of the versions)
- python - doesn't have to be python3

## Usage
In order to show the contents of a folder in recursive way, run the script like this:
- If needed, run the IPFS daemon before running this script
- If wanted, run `chmod a+x ipfs-ls-r.py` in Linux
- If wanted, delete folder "ignore/" (or don't download it in the first place), since nothing in "ignore/" is used by "ipfs-ls-r.py"
- run `python ipfs-ls-r.py [cid]` or `./ipfs-ls-r.py [cid]`

## Considerations
- The output is, on each line, `[src cid] -> [dest cid] [filesize] [filename if it has one]`. There should be a thing/way to convert that data into a tree view, like how running `tree /f` in "cmd.exe" (Windows) shows the working/current directory in a tree view
- See https://github.com/ProximaNova/ipfs-ls-r/tree/main/ignore for older/worse versions of this script. Folder "ignore/" has various implementations, features (like tree view), and limitations not seen in the current ipfs-ls-r

## Code
Here is the code; it is simple in terms of length, but maybe not so simple in regards to what it does (ipfs-ls-r uses a recursive function):
```
#!/usr/bin/env python3

# -- usage: run "python thisfile.py [CID]"
# -- it recursively lists the contents of a CID

import sys
import subprocess
import re

def obj_links(start):
    command1 = subprocess.Popen(['ipfs', 'object', 'links', start], shell=False, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = command1.communicate()
    errcode = command1.returncode
    if len(str(out)) == 3:
        return
    output1 = re.sub("\\\\n", "\\\\n" + start + " -> ", re.sub("\\\\n.$", "", re.sub(r"^..", start + " -> ", str(out))))
    output2 = output1.split("\\n")
    for x in output2:
        print(x)
    cids2 = []
    for x in output2:
        # -- remove "src to" part, remove non-CID part, so only the dest CID remains
        cids2.append(str(re.sub(" .*", "", re.sub("^Qm................................................|^ba.............................................................", "", x))))
    for n in cids2:
        obj_links(n)

obj_links(sys.argv[1])
```

## See also
- https://github.com/search?q=ipfs+traverse
- -> https://github.com/ipfs-examples/js-ipfs-traverse-ipld-graphs
- https://github.com/search?q=ipfs+recursive
- -> https://github.com/ajruckman/ipfs-indexer
