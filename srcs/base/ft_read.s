; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_read.s                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:50:36 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/24 03:27:02 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	__errno_location

global	ft_read
default	rel

section .data
	sys_read dd	0x0

section .text
ft_read:
	push	rbp
	mov		rbp, rsp
	mov		rax, [sys_read]
	syscall
	cmp		rax, 0
	jl		.err
	leave
	ret
.err:
	neg		rax
	mov		rdi, rax
	call	__errno_location WRT ..plt
	mov		[rax], rdi
	mov		rax, -1
	leave
	ret
