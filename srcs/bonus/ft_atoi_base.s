; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_atoi_base.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/26 21:40:05 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/23 18:47:28 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	ft_strlen
extern	ft_simd_memchr

global	ft_atoi_base
default	rel

section .data
	char_space	dq	' '
	char_plus	dq	'+'
	char_minus	dq	'-'
	char_del	dq	127

section .text

check_base:							; returns the length of the base
	push	r15
	push	r14
	test	rdi, rdi
	jz		.bad

	call	ft_strlen WRT ..plt
	cmp		rax, 1
	jle		.bad

	mov		r15, rax				; length of base
	xor		r14, r14				; accumulator

.loop:
	mov		sil, [rdi]
	movzx	rsi, sil
	test	sil, sil
	jz		.end
	cmp		sil, [char_space]
	jle		.bad
	cmp		sil, [char_plus]
	je		.bad
	cmp		sil, [char_minus]
	je		.bad
	cmp		sil, [char_del]
	je		.bad
	mov		rdx, rax
	sub		rdx, r14
	inc		rdi
	inc		r14
	call	ft_simd_memchr WRT ..plt
	test	rax, rax
	jnz		.bad
	mov		rax, r15
	jmp		.loop

.bad:
	xor		rax, rax
.end:
	pop		r14
	pop		r15
	ret

ft_atoi_base:
	push	rbx
	push	r15
	sub		rsp, 32
	mov		[rsp], rdi			; stirng to convert
	mov		[rsp + 8], rsi		; base

	mov		rdi, rsi			; move the base in rdi
	call	check_base			; ...to check if its valid.
	test	rax, rax			; test if check_base returned len or 0
	jz		.end				; 0 means base is invalid, leave!

	mov		[rsp + 16], rax		; save len of base for simd_memchr

	xor		rax, rax
	xor		rcx, rcx
	mov		rdi, [rsp]
	mov		r15, 1
	xor		rbx, rbx			; xor rbx now before the checks. it'll be our result register

.skip_spaces:					; lil label to know where we are
	mov		cl, [rdi]
	cmp		cl, [char_space]
	jg		.check_signs
	inc		rdi
	jmp		.skip_spaces

.check_signs:
	cmp		cl, [char_minus]
	jne		.test_plus
	mov		r15, -1
	inc		rdi
	jmp		.convert
.test_plus:
	cmp		cl, [char_plus]
	sete	r10b
	add		rdi, r10

.convert:
	mov		sil, [rdi]			; pick character at [rdi] in 2nd ard
	movzx	esi, sil			; clear the register
	test	sil, sil			; check for \0
	jz		.finalize			; don't call simd_memchr if sil is NUL...
	mov		[rsp], rdi			; save our index in the string
	mov		rdi, [rsp + 8]		; place base in 1st arg
	mov		rdx, [rsp + 16]		; place len in 3rd arg
	call	ft_simd_memchr WRT ..plt
	test	rax, rax			; test if simd_memchr found the current byte in base
	jz		.finalize			; get the hellouttahere if current char is NOT in base
	imul	rbx, [rsp + 16]		; multiply rbx by the length of the base
	mov		rsi, [rsp + 8]		; place base ptr in rsi
	sub		rax, rsi			; subtract rax from rsi to get index of char in base
	add		rbx, rax
	mov		rdi, [rsp]			; restore rdi
	inc		rdi					; increment it
	jmp		.convert			; jump back to start of loop

.finalize:
	mov		rax, rbx
	imul	r15

.end:
	pop		r15
	pop		rbx
	add		rsp, 32
	ret
