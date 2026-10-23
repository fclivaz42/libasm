; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_size.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/26 21:40:56 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/17 03:04:57 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global	ft_list_size
default	rel

section .data

section .text
ft_list_size:
	xor		rax, rax
	test	rdi, rdi
	jz		.end
.loop:
	inc		rax
	mov		rdi, [rdi + 8]
	test	rdi, rdi
	jz		.end
	jmp		.loop
.end:
	ret
