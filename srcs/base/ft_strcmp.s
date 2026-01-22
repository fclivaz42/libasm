; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcmp.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:50:45 by fclivaz           #+#    #+#              ;
;    Updated: 2026/01/22 16:19:37 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

section .text
	global ft_strcmp

ft_strcmp:
	push	rbp
	mov		rbp, rsp
	mov		r15, rdi
	mov		r14, rsi
	xor		eax, eax
.loop:
	cmp		r15, r14
	lahf
	mov		al, ah
	cmp		[r15], 0
	cmp		[r14], 0
	sahf
	je		.loop
	leave
	ret
