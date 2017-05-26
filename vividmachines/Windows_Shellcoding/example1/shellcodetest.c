/*
Executable name : shellcodetest
Designed OS     : Windows XP SP3
Version         : 1.0
Origin          : http://www.vividmachines.com/shellcode/shellcode.html
Description     : Simply used to test shellcode

Build using these commands:
        i686-w64-mingw32-gcc shellcodetest.c -lws2_32 -o shellcodetest.exe

*/

char code[]= "\x31\xc0\xbb\x42\x24\x80\x7c\x66\xb8\x30\x75\x50\xff\xd3";

int main(int argc, char **argv)
{
        int (*func)();
        func = (int (*)()) code;
        (int)(*func)();
}
 
