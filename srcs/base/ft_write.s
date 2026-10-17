; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_write.s                                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:53:32 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/17 02:52:53 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	__errno_location

global	ft_write
default	rel

section .data
	sys_write dd	0x1		; write system call

section .text
; size_t	ft_write(int fd, const void *buf, int count);
; RDI: file descriptor to write to
; RSI: buffer to write from
; RDX: amount of bytes to write
; RAX: amount of bytes actually written
ft_write:
	mov		rax, [sys_write]				; move the system call in rax
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
