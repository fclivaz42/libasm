; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcmp.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:50:45 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/24 03:10:12 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global	ft_strcmp
default	rel

section .data

section .text
ft_strcmp:
	push	rbp
	mov		rbp, rsp
	xor		rax, rax
.loop:
	mov		cl, [rdi]
	mov		dl, [rsi]
	cmp		cl, dl
	jnz		.end
	test	dl, dl
	jz		.end
	add		rdi, 1
	add		rsi, 1
	jmp		.loop
.end:
	sub		cl, dl
	movsx	rax, cl
	leave
	ret
