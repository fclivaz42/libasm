; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_atoi_base.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/26 21:40:05 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/26 21:40:25 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global	ft_atoi_base
default	rel

section .data

section .text
ft_atoi_base:
	push	rbp
	mov		rbp, rsp

.end:
	leave
	ret
