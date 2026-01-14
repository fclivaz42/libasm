; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 17:16:17 by fclivaz           #+#    #+#              ;
;    Updated: 2026/01/14 12:04:00 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

section .text
	global ft_strlen

ft_strlen:
	push	rbp
	mov		rbp, rsp
	mov		r15, rdi
	cmp		[r15], 0
	je		.end
.loop:
	add		r15, 1
	cmp		[r15], 0
	jne		.loop
.end:
	sub		r15, rdi
	mov		rax, r15
	leave
	ret
