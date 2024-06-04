#!/bin/bash
# Creates an LZMA compressed Whitebar.ps1 (including decompressed size)

lzma -kf Whitebar.ps1
# The 'lzma' utility does not add the uncompressed size, so we must add it manually. And yes, this whole
# gymkhana is what one must actually go through to insert a 64-bit little endian size into a binary file...
printf "00: %016X" `stat -c "%s" Whitebar.ps1` | xxd -r | xxd -p -c1 | tac | xxd -p -r | dd of=Whitebar.ps1.lzma seek=5 bs=1 status=none conv=notrunc