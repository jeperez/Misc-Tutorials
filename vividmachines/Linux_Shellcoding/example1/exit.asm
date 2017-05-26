; Executable name : exiter
; Designed OS     : Linux
; Version         : 1.0
; Origin          : http://www.vividmachines.com/shellcode/shellcode.html
; Description     : demonstrate the exit syscall. Notice the al and XOR
;                   trick to ensure that no NULL bytes will get into
;                   our code
;
; Build using these commands:
;	nasm -f elf exit.asm
;	ld -o exiter exit.o
;
; Extract shellcode using:
;	objdump -d exiter

SECTION .text

global _start

_start:
	xor eax,eax	; zero out eax
	mov al,1	; exit is syscall 1
	xor ebx,ebx	; zero out ebx
	int 80h		; make kernel call
