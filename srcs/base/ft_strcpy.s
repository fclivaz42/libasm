; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:52:17 by fclivaz           #+#    #+#              ;
;    Updated: 2026/11/11 16:11:52 by fclivaz          ###   LAUSANNE.ch        ;
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
	cmp		rcx, 128			; check if buffer is bigger than 128 bytes
	jae		.movsb				; use rep movsb if it's the case

.loop:							; plain old scalar loop.
	mov		cl, [rsi]			; move whatever's in rsi to cl
	mov		[rdi], cl			; and move that back to whatever's in rdi
	test	cl, cl				; test if it's the NUL byte
	jz		.end				; leave if it's the case
	inc		rsi					; increase rsi
	inc		rdi					; increase rdi
	jmp		.loop				; jump back to start of the loop

.movsb:							; uses rep movsb which is faster on large strings
	rep		movsb				; repeat move string byte from rsi to rdi, rcx times.

.end:
	ret							; return
