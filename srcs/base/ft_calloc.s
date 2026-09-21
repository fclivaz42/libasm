; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_calloc.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/21 19:41:10 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/21 19:42:22 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern malloc
global ft_calloc
default rel

section .data

section .text
ft_calloc:
	push	rbp
	mov		rbp, rsp

	leave
	ret
