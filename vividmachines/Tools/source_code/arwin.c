/*

Executable name : arwin.exe
Designed OS     : Windows
Version         : 1.0
Created date    : N/A
Last update     : N/A
Author          : steve hanna (shanna@uiuc.edu)
Wbsite		: vividmachines.com
GCC Version     : 6.3.0
Description     : win32 address resolution program by steve hanna v.01
                  this program finds the absolute address of a function
		  in a specified DLL.

Dependencies:
	apt-get install mingw-w64 -y

Build using these commands:
	i686-w64-mingw32-gcc arwin.c -lws2_32 -o arwin.exe

*/

#include <windows.h>
#include <stdio.h>

int main(int argc, char** argv)
{
	HMODULE hmod_libname;
	FARPROC fprc_func;

	printf("arwin - win32 address resolution program - by steve hanna - v.01\n");
	if(argc < 3)
	{
		printf("%s <Library Name> <Function Name>\n",argv[0]);
		exit(-1);
	}

	hmod_libname = LoadLibrary(argv[1]);
	if(hmod_libname == NULL)
	{
		printf("Error: could not load library!\n");
		exit(-1);
	}
	fprc_func = GetProcAddress(hmod_libname,argv[2]);

	if(fprc_func == NULL)
	{
		printf("Error: could find the function in the library!\n");
		exit(-1);
	}
	printf("%s is located at 0x%08x in %s\n",argv[2],(unsigned int)fprc_func,argv[1]);


}
