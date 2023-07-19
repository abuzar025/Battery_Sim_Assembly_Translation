	.file	"batt_update.c"
	.text
	.globl	set_batt_from_ports
	.type	set_batt_from_ports, @function
set_batt_from_ports:
.LFB0:
	.cfi_startproc
	endbr64
	movzwl	BATT_VOLTAGE_PORT(%rip), %edx
	testw	%dx, %dx
	js	.L7
	movl	%edx, %eax
	shrw	$15, %ax
	addl	%edx, %eax
	sarw	%ax
	movw	%ax, (%rdi)
	cmpw	$2999, %ax
	jg	.L3
	movb	$0, 2(%rdi)
.L4:
	testb	$16, BATT_STATUS_PORT(%rip)
	je	.L6
	movb	$1, 3(%rdi)
	movl	$0, %eax
	ret
.L3:
	cmpw	$3800, %ax
	jle	.L5
	movb	$100, 2(%rdi)
	jmp	.L4
.L5:
	cwtl
	leal	-2993(%rax), %edx
	subl	$3000, %eax
	cmovs	%edx, %eax
	sarl	$3, %eax
	movb	%al, 2(%rdi)
	jmp	.L4
.L6:
	movb	$2, 3(%rdi)
	movl	$0, %eax
	ret
.L7:
	movl	$1, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	set_batt_from_ports, .-set_batt_from_ports
	.globl	set_display_from_batt
	.type	set_display_from_batt, @function
set_display_from_batt:
.LFB1:
	.cfi_startproc
	endbr64
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movl	$0, (%rsi)
	movl	%edi, %eax
	sall	$8, %eax
	sarl	$24, %eax
	cmpb	$89, %al
	jle	.L9
	movl	$520093696, (%rsi)
.L10:
	movl	$63, (%rsp)
	movl	$6, 4(%rsp)
	movl	$91, 8(%rsp)
	movl	$79, 12(%rsp)
	movl	$102, 16(%rsp)
	movl	$109, 20(%rsp)
	movl	$125, 24(%rsp)
	movl	$7, 28(%rsp)
	movl	$127, 32(%rsp)
	movl	$111, 36(%rsp)
	movl	$0, 40(%rsp)
	movl	$64, 44(%rsp)
	movl	%edi, %r8d
	sarl	$24, %r8d
	cmpb	$1, %r8b
	je	.L27
	movswl	%di, %eax
	movswq	%di, %rdi
	imulq	$1717986919, %rdi, %rdi
	sarq	$34, %rdi
	cltd
	subl	%edx, %edi
	leal	(%rdi,%rdi,4), %edx
	addl	%edx, %edx
	movl	%eax, %edi
	subl	%edx, %edi
	cmpl	$4, %edi
	jle	.L20
	movslq	%eax, %rdx
	imulq	$1717986919, %rdx, %rdx
	sarq	$34, %rdx
	sarl	$31, %eax
	subl	%eax, %edx
	addl	$1, %edx
.L21:
	movslq	%edx, %rax
	imulq	$1374389535, %rax, %rdi
	sarq	$37, %rdi
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edi
	imulq	$1717986919, %rax, %rax
	sarq	$34, %rax
	subl	%ecx, %eax
	movslq	%eax, %rcx
	imulq	$1717986919, %rcx, %rcx
	sarq	$34, %rcx
	movl	%eax, %r9d
	sarl	$31, %r9d
	subl	%r9d, %ecx
	leal	(%rcx,%rcx,4), %ecx
	addl	%ecx, %ecx
	movl	%eax, %r10d
	subl	%ecx, %r10d
	leal	(%rax,%rax,4), %eax
	addl	%eax, %eax
	movl	%edx, %r11d
	subl	%eax, %r11d
	movl	%r11d, %eax
	cmpb	$2, %r8b
	je	.L28
.L19:
	movq	56(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L29
	movl	$0, %eax
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L9:
	.cfi_restore_state
	leal	-70(%rax), %edx
	cmpb	$19, %dl
	ja	.L11
	movl	$251658240, (%rsi)
	jmp	.L10
.L11:
	leal	-50(%rax), %edx
	cmpb	$19, %dl
	ja	.L12
	movl	$117440512, (%rsi)
	jmp	.L10
.L12:
	leal	-30(%rax), %edx
	cmpb	$19, %dl
	ja	.L13
	movl	$50331648, (%rsi)
	jmp	.L10
.L13:
	leal	-5(%rax), %edx
	cmpb	$24, %dl
	ja	.L10
	movl	$16777216, (%rsi)
	jmp	.L10
.L27:
	movsbl	%al, %edi
	movsbq	%al, %rdx
	imulq	$1717986919, %rdx, %rdx
	sarq	$34, %rdx
	movl	%eax, %ecx
	sarl	$31, %ecx
	subl	%ecx, %edx
	leal	(%rdx,%rdx,4), %ecx
	addl	%ecx, %ecx
	movl	%eax, %r10d
	subl	%ecx, %r10d
	cmpb	$100, %al
	je	.L30
	movsbl	%al, %r8d
	leal	-10(%rax), %eax
	cmpl	$89, %eax
	ja	.L17
	movslq	%edx, %rdx
	movl	(%rsp,%rdx,4), %eax
	sall	$10, %eax
	orl	(%rsi), %eax
	movslq	%r10d, %rcx
	movl	(%rsp,%rcx,4), %edx
	sall	$3, %edx
	orl	%edx, %eax
	orl	$1, %eax
	movl	%eax, (%rsi)
	jmp	.L19
.L30:
	movl	(%rsi), %eax
	orl	$851449, %eax
	movl	%eax, (%rsi)
	jmp	.L19
.L17:
	cmpl	$9, %r8d
	ja	.L18
	movslq	%r10d, %rcx
	movl	(%rsp,%rcx,4), %eax
	sall	$3, %eax
	orl	(%rsi), %eax
	orl	$1, %eax
	movl	%eax, (%rsi)
	jmp	.L19
.L18:
	testl	%edi, %edi
	jg	.L19
	movl	(%rsi), %eax
	orl	$505, %eax
	movl	%eax, (%rsi)
	jmp	.L19
.L20:
	movslq	%eax, %rdx
	imulq	$1717986919, %rdx, %rdx
	sarq	$34, %rdx
	sarl	$31, %eax
	subl	%eax, %edx
	jmp	.L21
.L28:
	testl	%edx, %edx
	jne	.L22
	movl	(%rsi), %eax
	orl	$8322558, %eax
	movl	%eax, (%rsi)
	jmp	.L19
.L22:
	leal	-1(%rdx), %r8d
	cmpl	$7, %r8d
	ja	.L23
	cltq
	movl	(%rsp,%rax,4), %eax
	sall	$3, %eax
	orl	(%rsi), %eax
	orl	$6, %eax
	movl	%eax, (%rsi)
	jmp	.L19
.L23:
	subl	$11, %edx
	cmpl	$87, %edx
	ja	.L24
	movslq	%r10d, %rcx
	movl	(%rsp,%rcx,4), %edx
	sall	$10, %edx
	orl	(%rsi), %edx
	cltq
	movl	(%rsp,%rax,4), %eax
	sall	$3, %eax
	orl	%edx, %eax
	orl	$6, %eax
	movl	%eax, (%rsi)
	jmp	.L19
.L24:
	movslq	%edi, %rdi
	movl	(%rsp,%rdi,4), %edx
	sall	$17, %edx
	orl	(%rsi), %edx
	movslq	%r10d, %rcx
	movl	(%rsp,%rcx,4), %ecx
	sall	$10, %ecx
	orl	%ecx, %edx
	cltq
	movl	(%rsp,%rax,4), %eax
	sall	$3, %eax
	orl	%edx, %eax
	orl	$6, %eax
	movl	%eax, (%rsi)
	jmp	.L19
.L29:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1:
	.size	set_display_from_batt, .-set_display_from_batt
	.globl	batt_update
	.type	batt_update, @function
batt_update:
.LFB2:
	.cfi_startproc
	endbr64
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	4(%rsp), %rdi
	call	set_batt_from_ports
	testl	%eax, %eax
	js	.L32
	leaq	4(%rsp), %rdi
	call	set_batt_from_ports
	cmpl	$1, %eax
	je	.L32
	leaq	BATT_DISPLAY_PORT(%rip), %rsi
	movl	4(%rsp), %edi
	call	set_display_from_batt
	movl	$0, %eax
	jmp	.L31
.L32:
	movl	$1, %eax
.L31:
	movq	8(%rsp), %rdx
	xorq	%fs:40, %rdx
	jne	.L37
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L37:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE2:
	.size	batt_update, .-batt_update
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
