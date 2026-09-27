; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_simd_memchr.s                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/21 19:41:08 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/26 21:41:32 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global ft_simd_memchr
default rel

section .data

section .text
ft_simd_memchr:
	push	rbp
	mov		rbp, rsp

.end:
	leave
	ret
