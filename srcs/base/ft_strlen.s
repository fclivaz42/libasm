; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 17:16:17 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/22 00:51:42 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

section .text
global ft_strlen

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
