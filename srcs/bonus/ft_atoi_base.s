; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_atoi_base.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/26 21:40:05 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/14 03:07:03 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern ft_strlen

global	ft_atoi_base
default	rel

section .data

section .text

check_base:
	sub		rsp, 16
	test	rdi, rdi
	jz		.bad

	call	ft_strlen WRT ..plt
	cmp		rax, 1
	jle		.bad

	mov		[rsp], rax
	xor		rax, rax

.loop:
	mov		rsi, [rdi + rax]
	test	sil, sil
	jz		.end
	cmp		sil, 32
	jle		.bad
	cmp		sil, 43
	je		.bad
	cmp		sil, 45
	je		.bad
	;		TODO: CALL SIMD_MEMCHR HERE WITH [RSP] - RAX AS LEN PARAMETER FOR DUPE CHECK
	add		rax, 1
	jmp		.loop

.bad:
	xor		rax, rax
.end:
	add		rsp, 16
	ret

ft_atoi_base:
	sub		rsp, 16
	mov		[rsp], rdi			; stirng to convert
	mov		[rsp + 8], rsi		; base

	mov		rdi, rsi			; pre-emtpively move the base in rdi
	call	check_base
	test	rax, rax
	jz		.end
	mov		rax, 1

.end:
	add		rsp, 16
	ret
