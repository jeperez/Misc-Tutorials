; Executable name : sleep
; Designed OS     : Windows XP
; Version         : 1.0
; Origin          : http://www.vividmachines.com/shellcode/shellcode.html
; Description     : For this example we just want a thread to sleep for an
;                   allotted amount of time. Remember, the only module guaranteed
;                   to be mapped into the processes address space is kernel32.dll.
;                   So for this example, Sleep seems to be the simplest function,
;                   accepting the amount of time the thread should suspend as its
;                   only argument.
;
; Found Using:
;	arwin.exe kernel32.dll Sleep
;
; Note		  : When this code is inserted it will cause the parent thread to
;                   suspend for five seconds (note: it will then probably crash
;                   because the stack is smashed at this point).
;
; Build using these commands && extract shellcode:
;	nasm -f elf sleep.asm; ld -o sleep sleep.o; objdump -D sleep
;

SECTION .data

global _start

_start:
	xor eax,eax		; zero out
	mov ebx,0x7c802442	; address of Sleep (Windows XP SP3)
	mov ax,30000		; pause for 30sec (Millisecond -> Second)
	push eax		; push eax to stack
	call ebx		; Sleep(ms)
