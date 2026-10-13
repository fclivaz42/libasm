; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_write.s                                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:53:32 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/13 20:32:59 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	__errno_location

global	ft_write
default	rel

section .data
	sys_write dd	0x1

section .text
ft_write:
	mov		rax, [sys_write]
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
