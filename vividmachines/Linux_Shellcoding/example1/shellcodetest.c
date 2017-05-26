/*
Executable name : shellcodetest
Designed OS     : Linux
Version         : 1.0
Origin          : http://www.vividmachines.com/shellcode/shellcode.html
Description     : Simply used to test shellcode
*/

char code[] = "\x31\xc0\xb0\x01\x31\xdb\xcd\x80";

int main(int argc, char **argv)
{
	int (*func)();
	func = (int (*)()) code;
	(int)(*func)();
}
