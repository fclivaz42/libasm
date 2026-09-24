; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strdup.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:52:41 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/24 03:27:35 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	malloc
extern	ft_strcpy
extern	ft_strlen

global	ft_strdup
default	rel

section .data

section .text
ft_strdup:
	push	rbp
	mov		rbp, rsp
	sub		rsp, 8
	push	rdi

	call	ft_strlen WRT ..plt
	inc		rax

	mov		rdi, rax
	call	malloc WRT ..plt
	test	rax, rax
	jz		.end

	pop 	rsi
	mov		rdi, rax
	call	ft_strcpy WRT ..plt
.end:
	leave
	ret
