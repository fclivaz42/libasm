; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_read.s                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:50:36 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/16 22:40:33 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	__errno_location

global	ft_read
default	rel

section .data
	sys_read dd	0x0		; read system call

section .text
; size_t	ft_read(int fd, void *buf, int count);
; RDI: file descriptor to read from
; RSI: buffer to fill
; RDX: amount of bytes to read
; RAX: amount of bytes actually read
ft_read:
	mov		rax, [sys_read]				; move the system call in rax
	syscall								; guess what
	cmp		rax, 0						; compare read amount of bytes against 0
	jl		.err						; jump to .err if read returns a negative number
	ret									; return otherwise
.err:
	neg		rax							; invert rax to get the actual error code
	mov		rdi, rax					; move it to rdi, which will be modified by...
	call	__errno_location WRT ..plt	; ... the call to errno_location
	mov		[rax], rdi					; set errno from what we saved in rdi
	mov		rax, -1						; set the return value to -1
	ret									; return
