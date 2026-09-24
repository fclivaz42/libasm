; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_calloc.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/21 19:41:10 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/24 03:24:48 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern malloc

global ft_calloc
default rel

section .data

section .text
ft_calloc:
	push	rbp
	mov		rbp, rsp
	mov		rax, rsi
	mul		rdi
	mov		rdi, rax
	xor		rax, rax
	test	rdx, rdx
	jnz		.end
	sub		rsp, 8
	push	rdi

	call	malloc WRT ..plt
	test	rax, rax
	jz		.end

	xor		rcx, rcx
	pop		rdi
.loop:
	mov		[rax + rcx], 0
	add		rcx, 1
	cmp		rcx, rdi
	jl		.loop
.end:
	leave
	ret
