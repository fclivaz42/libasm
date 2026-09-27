; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_push_front.s                               :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/26 20:25:45 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/27 17:26:19 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	malloc

global	ft_list_push_front
default	rel

section .data
	lsize	dq	16

section .text
ft_list_push_front:
	push	rbp
	mov		rbp, rsp
	mov		rcx, rdi
	mov		rdx, rsi

	mov		rdi, [lsize]
	call	malloc WRT ..plt
	test	rax, rax
	jz		.end

	mov		[rax], rdx
	mov		rdx, [rcx]
	mov		[rax + 8], rdx
	mov		[rcx], rax

.end:
	leave
	ret
