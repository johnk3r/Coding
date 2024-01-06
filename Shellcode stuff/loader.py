#!/usr/bin/python3
# usage :: python3 loader.py '48b801010101010101015048b82e63686f2e726901483104244889e748b801010101010101015048b82e63686f2e7269014831042431f6566a085e4801e6564889e631d26a3b580f05'

import sys
from pwn import *

context(os="linux", arch="amd64", log_level="error")

run_shellcode(unhex(sys.argv[1])).interactive()
