; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 17:16:17 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/22 01:14:12 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global ft_strlen
default rel

section .data

section .text
ft_strlen:
	push	rbp
	mov		rbp, rsp
	mov		rax, rdi
.loop:
	mov		bl, [rax]
	test	bl, bl
	jz		.end
	add		rax, 1
	jmp		.loop
.end:
	sub		rax, rdi
	leave
	ret
