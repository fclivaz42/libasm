; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 17:16:17 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/21 02:21:13 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

section .text
global ft_strlen

ft_strlen:
	push	rbp
	mov		rbp, rsp
	mov		rax, rdi
	mov		bl, [rax]
	test	bl, bl
	jz		.end
.loop:
	inc		rax
	mov		bl, [rax]
	test	bl, bl
	jnz		.loop
.end:
	sub		rax, rdi
	leave
	ret
