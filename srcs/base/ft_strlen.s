; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 17:16:17 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/17 03:04:38 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global	ft_strlen
default	rel

section .data

section .text
; size_t	ft_strlen(const char *str);
; RDI: pointer to NUL-terminated string
; RAX: amount of bytes from pointed string to NUL character
ft_strlen:
	mov		rax, rdi	; copy pointer to rax
.loop:
	mov		cl, [rax]	; move byte from rax to cl
	test	cl, cl		; check if it's the NUL character
	jz		.end		; exit if it's the case
	inc		rax			; increment rax if not
	jmp		.loop		; jump to start of loop
.end:
	sub		rax, rdi	; subtract the position of rax from rdi to get length
	ret					; return
