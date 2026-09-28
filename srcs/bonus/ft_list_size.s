; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_size.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/26 21:40:56 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/28 03:35:12 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global	ft_list_size
default	rel

section .data

section .text
ft_list_size:
	push	rbp
	mov		rbp, rsp
	mov		rax, 0
	test	rdi, rdi
	jz		.end
.loop:
	add		rax, 1
	mov		rdi, [rdi + 8]
	test	rdi, rdi
	jz		.end
	jmp		.loop
.end:
	leave
	ret
