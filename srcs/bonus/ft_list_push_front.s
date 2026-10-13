; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_push_front.s                               :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/26 20:25:45 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/13 20:42:45 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	malloc

global	ft_list_push_front
default	rel

section .data
	lsize	dq	16

section .text
ft_list_push_front:
	push	rdi
	push	rsi

	mov		rdi, [lsize]
	sub		rsp, 8
	call	malloc WRT ..plt
	add		rsp, 8
	test	rax, rax
	jz		.end

	pop		rdx
	pop		rcx
	mov		[rax], rdx
	mov		rdx, [rcx]
	mov		[rax + 8], rdx
	mov		[rcx], rax

.end:
	ret
