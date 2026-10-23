; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:52:17 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/23 15:46:33 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	ft_strlen

global	ft_strcpy
default	rel

section .data

section .text
; char	*ft_strcpy(char *restrict dst, const char *restrict src);
; RDI: destination buffer to copy to.
; RSI: source buffer to copy from.
; RAX: the destination buffer.
ft_strcpy:
	xchg	rdi, rsi			; switch rsi and rdi since
	call	ft_strlen WRT ..plt	; rdi used to get the buffer size.
	mov		rcx, rax			; move result to rcx
	inc		rcx					; increment it by one
	xchg	rdi, rsi			; restore rdi and rsi
	mov		rax, rdi			; set return value already
	rep		movsb				; repeat move string byte from rsi to rdi, rcx times.
	ret							; return
