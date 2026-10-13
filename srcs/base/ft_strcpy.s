; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:52:17 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/13 20:32:36 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global	ft_strcpy
default	rel

section .data

section .text
ft_strcpy:
	mov		rax, rdi
.loop:
	mov		cl, [rsi]
	mov		[rdi], cl
	test	cl, cl
	jz		.end
	add		rsi, 1
	add		rdi, 1
	jmp		.loop
.end:
	ret
