; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_sort.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/26 21:41:15 by fclivaz           #+#    #+#              ;
;    Updated: 2026/09/26 21:41:23 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global	ft_list_sort
default	rel

section .data

section .text
ft_list_sort:
	push	rbp
	mov		rbp, rsp

.end:
	leave
	ret
