; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_simd_memchr.s                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/21 19:41:08 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/15 18:19:05 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global ft_simd_memchr
default rel

section .data

section .text
ft_simd_memchr:
	xor		rax, rax

.loop:
	cmp		rax, rdx
	jge		.bad
	mov		cl, [rdi + rax]
	movzx	rcx, cl
	cmp		rcx, rsi
	jne		.cont
	add		rax, rdi
	jmp		.end
.cont:
	add		rax, 1
	jmp		.loop

.bad:
	xor		rax, rax
.end:
	ret
