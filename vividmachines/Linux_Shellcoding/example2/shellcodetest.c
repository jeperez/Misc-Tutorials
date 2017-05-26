/*
Executable name : shellcodetest
Designed OS     : Linux
Version         : 1.0
Origin          : http://www.vividmachines.com/shellcode/shellcode.html
Description     : Simply used to test shellcode
*/

char code[] = "\xeb\x19\x31\xc0\x31\xdb\x31\xd2\x31\xc9\xb0\x04\xb3\x01\x59\xb2\x06\xcd"
	"\x80\x31\xc0\xb0\x01\x31\xdb\xcd\x80\xe8\xe2\xff\xff\xff\x68\x65\x6c\x6c\x6f\0a";

int main(int argc, char **argv)
{
	int (*func)();
	func = (int (*)()) code;
	(int)(*func)();
}
