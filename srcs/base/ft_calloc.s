; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_calloc.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/21 19:41:10 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/13 20:32:00 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	malloc

global	ft_calloc
default	rel

section .data

section .text
ft_calloc:
	mov		rax, rsi
	mul		rdi
	mov		rdi, rax
	xor		rax, rax
	test	rdx, rdx
	jnz		.end
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
	ret
