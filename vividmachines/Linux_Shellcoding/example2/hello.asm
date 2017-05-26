; Executable name : hello
; Designed OS     : Linux
; Version         : 1.0
; Origin          : http://www.vividmachines.com/shellcode/shellcode.html
; Description     : This block of code loads the address of a string in
;                   a piece of our code at runtime. This is important
;		    because while running shellcode in an unknown enviroment,
;                   the address will be unknown becuase the program is not
;                   running in its normal address space.
;
; Build using these commands:
;	nasm -f elf hello.asm
;	ld -o hello hello.o
;
; Extract shellcode using:
;	objdump -d hello

SECTION .text

global _start

_start:
	jmp short ender	; jump to ender

starter:
	xor eax,eax	; zero out registers
	xor ebx,ebx	; ^
	xor edx,edx	; |
	xor ecx,ecx	; |

	mov al,4	; syscall write
	mov bl,1	; stdout
	pop ecx		; get the address of the string from the stack
	mov dl,6	; length of the string
	int 80h		; make kernel call

	xor eax,eax	; zero out eax
	mov al,1	; exit the shellcode
	xor ebx,ebx
	int 80h

ender:
	call starter	; put the address of the string on the stack
	db 'hello'	; message (no newline or 10)
