; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strdup.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/01/09 18:52:41 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/17 03:07:08 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	malloc
extern	ft_strcpy
extern	ft_strlen

global	ft_strdup
default	rel

section .data

section .text
; char	*ft_strdup(const char *s);
; RDI: pointer to NUL-terminated string to duplicate
; RAX: pointer to NUL-terminated copy of string s or NULL if malloc fails
ft_strdup:
	push	rdi					; save rdi since we are going to call a couple functioms

	call	ft_strlen WRT ..plt	; call strlen to get length of string
	inc		rax					; increment rax to make place for the NUL byte

	mov		rdi, rax			; move return of strlen + 1 to rdi
	call	malloc WRT ..plt	; call malloc
	test	rax, rax			; check for null return
	pop 	rsi					; pre-pop rsi since we're gonna use it later
	jz		.end				; if rax is NULL, get away from here

	mov		rdi, rax			; if it isnt, copy it to rdi in order to...
	call	ft_strcpy WRT ..plt	; call strcpy which will copy the source string to the new alloc.
.end:
	ret
