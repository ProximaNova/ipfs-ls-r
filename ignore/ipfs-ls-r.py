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
