; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:52:17 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/16 21:21:06 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern ft_strlen

global	ft_strcpy
default	rel

section .data

section .text
ft_strcpy:
	xchg	rdi, rsi
	call	ft_strlen WRT ..plt
	mov		rcx, rax
	add		rcx, 1
	xchg	rdi, rsi
	mov		rax, rdi
	rep		movsb
	ret
