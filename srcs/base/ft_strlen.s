; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 17:16:17 by fclivaz           #+#    #+#              ;
;    Updated: 2026/01/22 16:18:03 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

section .text
	global ft_strlen

ft_strlen:
	push	rbp
	mov		rbp, rsp
	mov		rbx, rdi
	cmp 	BYTE [rbx], 0
	je		.end
.loop:
	inc		rbx
	cmp 	BYTE [rbx], 0
	jne		.loop
.end:
	sub		rbx, rdi
	mov		rax, rbx
	leave
	ret
