; Executable name : msgbox
; Designed OS     : Windows XP
; Version         : 1.0
; Origin          : http://www.vividmachines.com/shellcode/shellcode.html
; Description     : This example does nothing more than pop up a message box and say
;                   "You Got Pwned", demonstrating absolute addressing as well as the
;                   dynamic addressing using LoadLibrary and GetProcAddress. The library
;                   functions we will be using are LoadLibraryA, GetProcAddress,
;                   MessageBoxA, and ExitProcess (note: the A after the function name
;                   specifies we will be using a normal character set, as opposed to a W
;                   which would signify a wide character set; such as unicode).
;
; Found Using:
;	arwin.exe kernel32.dll LoadLibraryA	-> 0x7c801d77
;	arwin.exe kernel32.dll GetProcAddress	-> 0x7c80ac28
;	arwin.exe kernel32.dll ExitProcess	-> 0x7c81caa2
;
; Build using these commands && extract shellcode:
;	nasm -f elf msgbox.asm; ld -o msgbox msgbox.o; objdump -d msgbox
;

SECTION .text

global _start

_start:
	; ------------COMMENTS------------
	; eax holds return value
	; ebx will hold function addresses
	; ecx will hold string pointers
	; edx will hold NULL
	;---------------------------------

	xor eax,eax		; ^
	xor ebx,ebx		; |
	xor ecx,ecx		; | zero out
	xor edx,edx		; |

	jmp short GetLibrary	; short jump to GetLibrary

LibraryReturn:
	pop ecx			; get the library string
	mov [ecx+10],dl		; insert NULL
	mov ebx,0x7c801d77	; LoadLibraryA(libraryname)
	push ecx		; beginning of user32.dll
	call ebx		; eax will hold the module handle

	jmp short FunctionName	; short jmp to FunctionName

FunctionReturn:
	pop ecx			; get the address of the Function string
	xor edx,edx		; zero out
	mov [ecx+11],dl		; insert NULL
	push ecx		; push ecx onto stack
	push eax		; push eax onto stack
	mov ebx,0x7c80ac28	; GetProcAddress(hmodule,functionname)
	call ebx		; eax now holds the address of MessageBoxA

	jmp short Message	; short jump to Message

MessageReturn:
	pop ecx			; get the massage string
	xor edx,edx		; zero out
	mov [ecx+13],dl		; insert the NULL
	xor edx,edx		; zero out
	push edx		; MB_OK
	push ecx		; title
	push ecx		; message
	push edx		; NULL window handle

	call eax		; MessageBoxA(windowhandle,msg,title,type); Address

ender:
	xor edx,edx		; zero out
	push eax		; push eax onto the stack
	mov eax,0x7c81caa2	; exitprocess(exitcode)
	call eax		; exit cleanly so we don't crash the parent program

	;-----------------------------COMMENTS-----------------------------
	;the N at the end of each string signifies the location of the NULL
	;character that needs to be inserted
	;------------------------------------------------------------------

GetLibrary:
	call LibraryReturn
	db 'user32.dllN'

FunctionName:
	call FunctionReturn
	db 'MessageBoxAN'

Message:
	call MessageReturn
	db 'You Got PwnedN'
