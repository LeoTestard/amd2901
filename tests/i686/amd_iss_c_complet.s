	.file	"amd_iss_c.c"
	.section	.rodata
.LC0:
	.string	"ZZZZ"
.LC1:
	.string	"%s"
.LC2:
	.string	"%u"
	.text
.globl amd_run
	.type	amd_run, @function
amd_run:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$88, %esp
	movl	8(%ebp), %eax
	movl	$4, 4(%esp)
	movl	%eax, (%esp)
	call	std2ui
	movl	%eax, -52(%ebp)
	movl	8(%ebp), %eax
	addl	$4, %eax
	movl	$4, 4(%esp)
	movl	%eax, (%esp)
	call	std2ui
	movl	%eax, -48(%ebp)
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	$4, 4(%esp)
	movl	%eax, (%esp)
	call	std2ui
	movl	%eax, -44(%ebp)
	movl	8(%ebp), %eax
	addl	$12, %eax
	movl	$9, 4(%esp)
	movl	%eax, (%esp)
	call	std2ui
	movl	%eax, -40(%ebp)
	movl	8(%ebp), %eax
	addl	$21, %eax
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	std2ui
	movl	%eax, -36(%ebp)
	movl	-40(%ebp), %eax
	andl	$7, %eax
	cmpl	$7, %eax
	ja	.L2
	movl	.L11(,%eax,4), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L11:
	.long	.L3
	.long	.L4
	.long	.L5
	.long	.L6
	.long	.L7
	.long	.L8
	.long	.L9
	.long	.L10
	.text
.L3:
	movl	-52(%ebp), %eax
	movl	ram.1269(,%eax,4), %eax
	movl	%eax, -64(%ebp)
	movl	accu.1270, %eax
	movl	%eax, -60(%ebp)
	jmp	.L2
.L4:
	movl	-52(%ebp), %eax
	movl	ram.1269(,%eax,4), %eax
	movl	%eax, -64(%ebp)
	movl	-48(%ebp), %eax
	movl	ram.1269(,%eax,4), %eax
	movl	%eax, -60(%ebp)
	jmp	.L2
.L5:
	movl	$0, -64(%ebp)
	movl	accu.1270, %eax
	movl	%eax, -60(%ebp)
	jmp	.L2
.L6:
	movl	$0, -64(%ebp)
	movl	-48(%ebp), %eax
	movl	ram.1269(,%eax,4), %eax
	movl	%eax, -60(%ebp)
	jmp	.L2
.L7:
	movl	$0, -64(%ebp)
	movl	-52(%ebp), %eax
	movl	ram.1269(,%eax,4), %eax
	movl	%eax, -60(%ebp)
	jmp	.L2
.L8:
	movl	-44(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	-52(%ebp), %eax
	movl	ram.1269(,%eax,4), %eax
	movl	%eax, -60(%ebp)
	jmp	.L2
.L9:
	movl	-44(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	accu.1270, %eax
	movl	%eax, -60(%ebp)
	jmp	.L2
.L10:
	movl	-44(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	$0, -60(%ebp)
.L2:
	movl	-40(%ebp), %eax
	shrl	$3, %eax
	andl	$7, %eax
	cmpl	$7, %eax
	ja	.L12
	movl	.L21(,%eax,4), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L21:
	.long	.L13
	.long	.L14
	.long	.L15
	.long	.L16
	.long	.L17
	.long	.L18
	.long	.L19
	.long	.L20
	.text
.L13:
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	leal	(%edx,%eax), %eax
	addl	-36(%ebp), %eax
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L22
	movl	$3, %eax
	jmp	.L23
.L22:
	movl	$2, %eax
.L23:
	movl	8(%ebp), %edx
	movb	%al, 31(%edx)
	jmp	.L12
.L14:
	cmpl	$0, -36(%ebp)
	je	.L24
	movl	-64(%ebp), %eax
	movl	-60(%ebp), %edx
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	jmp	.L25
.L24:
	movl	-64(%ebp), %eax
	movl	-60(%ebp), %edx
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	subl	$1, %eax
.L25:
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L26
	movl	$2, %eax
	jmp	.L27
.L26:
	movl	$3, %eax
.L27:
	movl	8(%ebp), %edx
	movb	%al, 31(%edx)
	jmp	.L12
.L15:
	cmpl	$0, -36(%ebp)
	je	.L28
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	jmp	.L29
.L28:
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	subl	$1, %eax
.L29:
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L30
	movl	$2, %eax
	jmp	.L31
.L30:
	movl	$3, %eax
.L31:
	movl	8(%ebp), %edx
	movb	%al, 31(%edx)
	jmp	.L12
.L16:
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	orl	%edx, %eax
	movl	%eax, -56(%ebp)
	jmp	.L12
.L17:
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	andl	%edx, %eax
	movl	%eax, -56(%ebp)
	jmp	.L12
.L18:
	movl	-64(%ebp), %eax
	notl	%eax
	andl	-60(%ebp), %eax
	movl	%eax, -56(%ebp)
	jmp	.L12
.L19:
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	xorl	%edx, %eax
	movl	%eax, -56(%ebp)
	jmp	.L12
.L20:
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	xorl	%edx, %eax
	notl	%eax
	movl	%eax, -56(%ebp)
.L12:
	movl	-40(%ebp), %eax
	shrl	$3, %eax
	andl	$7, %eax
	cmpl	$7, %eax
	ja	.L32
	movl	.L41(,%eax,4), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L41:
	.long	.L33
	.long	.L34
	.long	.L35
	.long	.L36
	.long	.L37
	.long	.L38
	.long	.L39
	.long	.L40
	.text
.L33:
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	orl	%edx, %eax
	andl	$15, %eax
	movl	%eax, -16(%ebp)
	cmpl	$15, -16(%ebp)
	jne	.L42
	movl	$2, %eax
	jmp	.L43
.L42:
	movl	$3, %eax
.L43:
	movl	8(%ebp), %edx
	movb	%al, 32(%edx)
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	andl	%edx, %eax
	andl	$15, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L44
	movl	-12(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L45
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L44
.L45:
	movl	-12(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L46
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L46
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	jne	.L44
.L46:
	movl	-12(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L47
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L47
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L47
	movl	-16(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L47
.L44:
	movl	$2, %eax
	jmp	.L48
.L47:
	movl	$3, %eax
.L48:
	movl	8(%ebp), %edx
	movb	%al, 33(%edx)
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	xorl	%edx, %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L49
	movl	-64(%ebp), %eax
	movl	-56(%ebp), %edx
	xorl	%edx, %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L49
	movl	$3, %eax
	jmp	.L50
.L49:
	movl	$2, %eax
.L50:
	movl	8(%ebp), %edx
	movb	%al, 36(%edx)
	jmp	.L32
.L34:
	movl	-64(%ebp), %eax
	notl	%eax
	orl	-60(%ebp), %eax
	andl	$15, %eax
	movl	%eax, -16(%ebp)
	cmpl	$15, -16(%ebp)
	jne	.L51
	movl	$2, %eax
	jmp	.L52
.L51:
	movl	$3, %eax
.L52:
	movl	8(%ebp), %edx
	movb	%al, 32(%edx)
	movl	-64(%ebp), %eax
	notl	%eax
	andl	-60(%ebp), %eax
	andl	$15, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L53
	movl	-12(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L54
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L53
.L54:
	movl	-12(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L55
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L55
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	jne	.L53
.L55:
	movl	-12(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L56
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L56
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L56
	movl	-16(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L56
.L53:
	movl	$2, %eax
	jmp	.L57
.L56:
	movl	$3, %eax
.L57:
	movl	8(%ebp), %edx
	movb	%al, 33(%edx)
	movl	-64(%ebp), %eax
	notl	%eax
	xorl	-60(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L58
	movl	-60(%ebp), %eax
	movl	-56(%ebp), %edx
	xorl	%edx, %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L58
	movl	$3, %eax
	jmp	.L59
.L58:
	movl	$2, %eax
.L59:
	movl	8(%ebp), %edx
	movb	%al, 36(%edx)
	jmp	.L32
.L35:
	movl	-60(%ebp), %eax
	notl	%eax
	orl	-64(%ebp), %eax
	andl	$15, %eax
	movl	%eax, -16(%ebp)
	cmpl	$15, -16(%ebp)
	jne	.L60
	movl	$2, %eax
	jmp	.L61
.L60:
	movl	$3, %eax
.L61:
	movl	8(%ebp), %edx
	movb	%al, 32(%edx)
	movl	-60(%ebp), %eax
	notl	%eax
	andl	-64(%ebp), %eax
	andl	$15, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L62
	movl	-12(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L63
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L62
.L63:
	movl	-12(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L64
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L64
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	jne	.L62
.L64:
	movl	-12(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L65
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L65
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L65
	movl	-16(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L65
.L62:
	movl	$2, %eax
	jmp	.L66
.L65:
	movl	$3, %eax
.L66:
	movl	8(%ebp), %edx
	movb	%al, 33(%edx)
	movl	-60(%ebp), %eax
	notl	%eax
	xorl	-64(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L67
	movl	-64(%ebp), %eax
	movl	-56(%ebp), %edx
	xorl	%edx, %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L67
	movl	$3, %eax
	jmp	.L68
.L67:
	movl	$2, %eax
.L68:
	movl	8(%ebp), %edx
	movb	%al, 36(%edx)
	jmp	.L32
.L36:
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	orl	%edx, %eax
	andl	$15, %eax
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	movb	$2, 32(%eax)
	cmpl	$15, -16(%ebp)
	jne	.L69
	movl	$3, %eax
	jmp	.L70
.L69:
	movl	$2, %eax
.L70:
	movl	8(%ebp), %edx
	movb	%al, 33(%edx)
	cmpl	$15, -16(%ebp)
	jne	.L71
	cmpl	$0, -36(%ebp)
	je	.L72
.L71:
	movl	$3, %eax
	jmp	.L73
.L72:
	movl	$2, %eax
.L73:
	movl	8(%ebp), %edx
	movb	%al, 31(%edx)
	cmpl	$15, -16(%ebp)
	jne	.L74
	cmpl	$0, -36(%ebp)
	je	.L75
.L74:
	movl	$3, %eax
	jmp	.L76
.L75:
	movl	$2, %eax
.L76:
	movl	8(%ebp), %edx
	movb	%al, 36(%edx)
	jmp	.L32
.L37:
	movl	8(%ebp), %eax
	movb	$2, 32(%eax)
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	andl	%edx, %eax
	andl	$15, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	.L77
	movl	$2, %eax
	jmp	.L78
.L77:
	movl	$3, %eax
.L78:
	movl	8(%ebp), %edx
	movb	%al, 33(%edx)
	cmpl	$0, -12(%ebp)
	jne	.L79
	cmpl	$0, -36(%ebp)
	je	.L80
.L79:
	movl	$3, %eax
	jmp	.L81
.L80:
	movl	$2, %eax
.L81:
	movl	8(%ebp), %edx
	movb	%al, 31(%edx)
	cmpl	$0, -12(%ebp)
	je	.L82
	cmpl	$0, -36(%ebp)
	jne	.L83
.L82:
	movl	$3, %eax
	jmp	.L84
.L83:
	movl	$2, %eax
.L84:
	movl	8(%ebp), %edx
	movb	%al, 36(%edx)
	jmp	.L32
.L38:
	movl	8(%ebp), %eax
	movb	$2, 32(%eax)
	movl	-64(%ebp), %eax
	notl	%eax
	andl	-60(%ebp), %eax
	andl	$15, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	.L85
	movl	$2, %eax
	jmp	.L86
.L85:
	movl	$3, %eax
.L86:
	movl	8(%ebp), %edx
	movb	%al, 33(%edx)
	cmpl	$0, -12(%ebp)
	jne	.L87
	cmpl	$0, -36(%ebp)
	je	.L88
.L87:
	movl	$3, %eax
	jmp	.L89
.L88:
	movl	$2, %eax
.L89:
	movl	8(%ebp), %edx
	movb	%al, 31(%edx)
	cmpl	$0, -12(%ebp)
	je	.L90
	cmpl	$0, -36(%ebp)
	jne	.L91
.L90:
	movl	$3, %eax
	jmp	.L92
.L91:
	movl	$2, %eax
.L92:
	movl	8(%ebp), %edx
	movb	%al, 36(%edx)
	jmp	.L32
.L39:
	movl	-64(%ebp), %eax
	notl	%eax
	orl	-60(%ebp), %eax
	andl	$15, %eax
	movl	%eax, -16(%ebp)
	movl	-64(%ebp), %eax
	notl	%eax
	andl	-60(%ebp), %eax
	andl	$15, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	.L93
	movl	$3, %eax
	jmp	.L94
.L93:
	movl	$2, %eax
.L94:
	movl	8(%ebp), %edx
	movb	%al, 32(%edx)
	movl	-12(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L95
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L96
.L95:
	movl	-12(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L97
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L97
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	jne	.L96
.L97:
	movl	-12(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L98
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L98
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L98
	movl	-16(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	jne	.L96
.L98:
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L99
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L99
	movl	-16(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L99
	movl	-16(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L99
.L96:
	movl	$3, %eax
	jmp	.L100
.L99:
	movl	$2, %eax
.L100:
	movl	8(%ebp), %edx
	movb	%al, 33(%edx)
	movl	-12(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L101
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L102
.L101:
	movl	-12(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L103
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L103
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	jne	.L102
.L103:
	movl	-12(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L104
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L104
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L104
	movl	-16(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	jne	.L102
.L104:
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L105
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L105
	movl	-16(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L105
	movl	-16(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L105
	movl	-12(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	jne	.L102
	cmpl	$0, -36(%ebp)
	jne	.L105
.L102:
	movl	$3, %eax
	jmp	.L106
.L105:
	movl	$2, %eax
.L106:
	movl	8(%ebp), %edx
	movb	%al, 31(%edx)
	movl	8(%ebp), %eax
	movzbl	31(%eax), %eax
	cmpb	$2, %al
	jne	.L107
	movl	$3, %eax
	jmp	.L108
.L107:
	movl	$2, %eax
.L108:
	movl	8(%ebp), %edx
	movb	%al, 36(%edx)
	jmp	.L32
.L40:
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	orl	%edx, %eax
	andl	$15, %eax
	movl	%eax, -16(%ebp)
	movl	-60(%ebp), %eax
	movl	-64(%ebp), %edx
	andl	%edx, %eax
	andl	$15, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	.L109
	movl	$3, %eax
	jmp	.L110
.L109:
	movl	$2, %eax
.L110:
	movl	8(%ebp), %edx
	movb	%al, 32(%edx)
	movl	-12(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L111
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L112
.L111:
	movl	-12(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L113
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L113
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	jne	.L112
.L113:
	movl	-12(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L114
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L114
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L114
	movl	-16(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	jne	.L112
.L114:
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L115
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L115
	movl	-16(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L115
	movl	-16(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L115
.L112:
	movl	$3, %eax
	jmp	.L116
.L115:
	movl	$2, %eax
.L116:
	movl	8(%ebp), %edx
	movb	%al, 33(%edx)
	movl	-12(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L117
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	.L118
.L117:
	movl	-12(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L119
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L119
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	jne	.L118
.L119:
	movl	-12(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L120
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L120
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L120
	movl	-16(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	jne	.L118
.L120:
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L121
	movl	-16(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L121
	movl	-16(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L121
	movl	-16(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L121
	movl	-12(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	jne	.L118
	cmpl	$0, -36(%ebp)
	jne	.L121
.L118:
	movl	$3, %eax
	jmp	.L122
.L121:
	movl	$2, %eax
.L122:
	movl	8(%ebp), %edx
	movb	%al, 31(%edx)
	movl	8(%ebp), %eax
	movzbl	31(%eax), %eax
	cmpb	$2, %al
	jne	.L123
	movl	$3, %eax
	jmp	.L124
.L123:
	movl	$2, %eax
.L124:
	movl	8(%ebp), %edx
	movb	%al, 36(%edx)
.L32:
	andl	$15, -56(%ebp)
	movl	-56(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L125
	movl	$3, %eax
	jmp	.L126
.L125:
	movl	$2, %eax
.L126:
	movl	8(%ebp), %edx
	movb	%al, 34(%edx)
	cmpl	$0, -56(%ebp)
	je	.L127
	movl	$2, %eax
	jmp	.L128
.L127:
	movl	$3, %eax
.L128:
	movl	8(%ebp), %edx
	movb	%al, 35(%edx)
	movl	8(%ebp), %eax
	movzbl	26(%eax), %eax
	cmpb	$3, %al
	jne	.L129
	movl	8(%ebp), %eax
	addl	$27, %eax
	movl	$.LC0, 12(%esp)
	movl	$.LC1, 8(%esp)
	movl	$4, 4(%esp)
	movl	%eax, (%esp)
	call	slv_setv
	jmp	.L130
.L129:
	movl	-40(%ebp), %eax
	shrl	$6, %eax
	andl	$7, %eax
	cmpl	$2, %eax
	jne	.L131
	movl	-52(%ebp), %eax
	movl	ram.1269(,%eax,4), %eax
	movl	8(%ebp), %edx
	addl	$27, %edx
	movl	%eax, 12(%esp)
	movl	$.LC2, 8(%esp)
	movl	$4, 4(%esp)
	movl	%edx, (%esp)
	call	slv_setv
	jmp	.L130
.L131:
	movl	8(%ebp), %eax
	leal	27(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	$.LC2, 8(%esp)
	movl	$4, 4(%esp)
	movl	%edx, (%esp)
	call	slv_setv
.L130:
	movl	-40(%ebp), %eax
	shrl	$6, %eax
	andl	$7, %eax
	cmpl	$7, %eax
	ja	.L156
	movl	.L139(,%eax,4), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L139:
	.long	.L133
	.long	.L156
	.long	.L134
	.long	.L134
	.long	.L135
	.long	.L136
	.long	.L137
	.long	.L138
	.text
.L133:
	movl	-56(%ebp), %eax
	movl	%eax, accu.1270
	jmp	.L156
.L134:
	movl	-48(%ebp), %eax
	movl	-56(%ebp), %edx
	movl	%edx, ram.1269(,%eax,4)
	jmp	.L156
.L135:
	movl	8(%ebp), %eax
	addl	$25, %eax
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	std2ui
	movl	%eax, -24(%ebp)
	movl	8(%ebp), %eax
	addl	$23, %eax
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	std2ui
	movl	%eax, -20(%ebp)
	movl	accu.1270, %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L140
	movl	$3, %eax
	jmp	.L141
.L140:
	movl	$2, %eax
.L141:
	movl	8(%ebp), %edx
	movb	%al, 24(%edx)
	movl	-56(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L142
	movl	$3, %eax
	jmp	.L143
.L142:
	movl	$2, %eax
.L143:
	movl	8(%ebp), %edx
	movb	%al, 22(%edx)
	movl	accu.1270, %eax
	movl	%eax, %edx
	shrl	%edx
	movl	-24(%ebp), %eax
	sall	$3, %eax
	orl	%edx, %eax
	andl	$15, %eax
	movl	%eax, accu.1270
	movl	-48(%ebp), %eax
	movl	-56(%ebp), %edx
	movl	%edx, %ecx
	shrl	%ecx
	movl	-20(%ebp), %edx
	sall	$3, %edx
	orl	%ecx, %edx
	andl	$15, %edx
	movl	%edx, ram.1269(,%eax,4)
	jmp	.L156
.L136:
	movl	8(%ebp), %eax
	addl	$23, %eax
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	std2ui
	movl	%eax, -20(%ebp)
	movl	accu.1270, %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L144
	movl	$3, %eax
	jmp	.L145
.L144:
	movl	$2, %eax
.L145:
	movl	8(%ebp), %edx
	movb	%al, 24(%edx)
	movl	-56(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	.L146
	movl	$3, %eax
	jmp	.L147
.L146:
	movl	$2, %eax
.L147:
	movl	8(%ebp), %edx
	movb	%al, 22(%edx)
	movl	-48(%ebp), %eax
	movl	-56(%ebp), %edx
	movl	%edx, %ecx
	shrl	%ecx
	movl	-20(%ebp), %edx
	sall	$3, %edx
	orl	%ecx, %edx
	andl	$15, %edx
	movl	%edx, ram.1269(,%eax,4)
	jmp	.L156
.L137:
	movl	8(%ebp), %eax
	addl	$24, %eax
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	std2ui
	movl	%eax, -32(%ebp)
	movl	8(%ebp), %eax
	addl	$22, %eax
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	std2ui
	movl	%eax, -28(%ebp)
	movl	accu.1270, %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L148
	movl	$3, %eax
	jmp	.L149
.L148:
	movl	$2, %eax
.L149:
	movl	8(%ebp), %edx
	movb	%al, 25(%edx)
	movl	-56(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L150
	movl	$3, %eax
	jmp	.L151
.L150:
	movl	$2, %eax
.L151:
	movl	8(%ebp), %edx
	movb	%al, 23(%edx)
	movl	accu.1270, %eax
	addl	%eax, %eax
	orl	-32(%ebp), %eax
	andl	$15, %eax
	movl	%eax, accu.1270
	movl	-48(%ebp), %eax
	movl	-56(%ebp), %edx
	addl	%edx, %edx
	orl	-28(%ebp), %edx
	andl	$15, %edx
	movl	%edx, ram.1269(,%eax,4)
	jmp	.L156
.L138:
	movl	8(%ebp), %eax
	addl	$22, %eax
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	std2ui
	movl	%eax, -28(%ebp)
	movl	accu.1270, %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L152
	movl	$3, %eax
	jmp	.L153
.L152:
	movl	$2, %eax
.L153:
	movl	8(%ebp), %edx
	movb	%al, 25(%edx)
	movl	-56(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L154
	movl	$3, %eax
	jmp	.L155
.L154:
	movl	$2, %eax
.L155:
	movl	8(%ebp), %edx
	movb	%al, 23(%edx)
	movl	-48(%ebp), %eax
	movl	-56(%ebp), %edx
	addl	%edx, %edx
	orl	-28(%ebp), %edx
	andl	$15, %edx
	movl	%edx, ram.1269(,%eax,4)
.L156:
	leave
	ret
	.size	amd_run, .-amd_run
	.data
	.align 32
	.type	ram.1269, @object
	.size	ram.1269, 64
ram.1269:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.long	8
	.long	9
	.long	10
	.long	11
	.long	12
	.long	13
	.long	14
	.long	15
	.align 4
	.type	accu.1270, @object
	.size	accu.1270, 4
accu.1270:
	.long	15
	.ident	"GCC: (GNU) 4.4.6 20120305 (Red Hat 4.4.6-4)"
	.section	.note.GNU-stack,"",@progbits
