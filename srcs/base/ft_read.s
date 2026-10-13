; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_read.s                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:50:36 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/13 20:32:17 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	__errno_location

global	ft_read
default	rel

section .data
	sys_read dd	0x0

section .text
ft_read:
	mov		rax, [sys_read]
	syscall
	cmp		rax, 0
	jl		.err
	ret
.err:
	neg		rax
	mov		rdi, rax
	call	__errno_location WRT ..plt
	mov		[rax], rdi
	mov		rax, -1
	ret
