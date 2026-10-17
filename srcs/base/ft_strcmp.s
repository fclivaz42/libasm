; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcmp.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:50:45 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/17 03:17:00 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global	ft_strcmp
default	rel

section .data

section .text
; int		ft_strcmp(const char *s1, const char *s2);
; RDI: pointer to NUL-terminated string to compare
; RSI: pointer to other NUL-terminated string to compare
; RAX: difference between s1 and s2 at the first differing byte. ASCII difference.
ft_strcmp:
	xor		rax, rax	; clear rax
.loop:
	mov		cl, [rdi]	; move whatever is in rdi in cl
	mov		dl, [rsi]	; move whatever is in rsi in dl
	cmp		cl, dl		; compare both characters
	jnz		.end		; exit if they are different
	test	dl, dl		; check if we reached a NUL byte on rsi
	jz		.end		; exit if we did (both strings are the same)
	inc		rdi			; increment rdi to check next character
	inc		rsi			; increment rsi to check next character
	jmp		.loop		; jump back to start of loop
.end:
	sub		cl, dl		; subtract the byte in cl with the byte in dl
	movsx	rax, cl		; move result to return value while sign extending it
	ret
