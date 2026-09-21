; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_write.s                                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:53:32 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/21 03:23:24 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global ft_write
section .text

extern __errno_location

ft_write:
	push	rbp
	mov		rbp, rsp
	mov		rax, 0x1
	syscall
	cmp rax, 0
	jl .err
	leave
	ret
.err:
	neg rax
	mov rdi, rax
	call __errno_location WRT ..plt
	mov [rax], rdi
	mov rax, -1
	leave
	ret
