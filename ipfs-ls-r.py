#!/usr/bin/env python3

import argparse
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
        cids2.append(str(re.sub(" .*", "", re.sub("^Qm................................................", "", x))))
    for n in cids2:
        obj_links(n)

# obj_links("Qm... CID here")
