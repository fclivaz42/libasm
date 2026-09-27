; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_remove_if.s                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/26 21:40:29 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/26 22:32:17 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	free

global	ft_list_remove_if
default	rel

section .data

section .text
ft_list_remove_if:
	push	rbp
	mov		rbp, rsp

.end:
	leave
	ret
