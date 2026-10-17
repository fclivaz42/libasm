; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_calloc.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/21 19:41:10 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/17 03:01:04 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	malloc

global	ft_calloc
default	rel

section .data

section .text
; void	*ft_calloc(size_t n, size_t size);
; RDI: amount of elements to allocate for, i64
; RSI: size of an element, i64
; RAX: allocated, zeroed pointer on success, NULL on failure
ft_calloc:
	xor		rax, rax			; clear rax
	push	rax					; push rax onto the stack
	mov		rax, rsi			; prepare multiplication by moving size in rax
	mul		rdi					; multiply
	mov		rdi, rax			; pre-emtively move result in rdi for malloc
	test	rdx, rdx			; check if multiplication has overflown
	jnz		.end				; get the hell away if it did
	push	rdi					; save rdi for zeroing loop

	call	malloc WRT ..plt	; call malloc
	test	rax, rax			; check for NULL
	pop		rcx					; pre-pop rcx to make sure we are aligned
	jz		.end				; get the hell away if rax is NULL

	pop		rsi					; get rid of useless push
	push	rax					; save rax for the end
	mov		rdi, rax			; prepare rdi
	xor		al, al				; clear al (again)
	rep		stosb				; repeat store string byte rcx times

.end:
	pop		rax					; restore rax as result
	ret							; return
