; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_sort.s                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/26 21:41:15 by fclivaz           #+#    #+#              ;
;    Updated: 2026/11/10 20:26:58 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global	ft_list_sort
default	rel

extern print_list

section .data

section .text
; void	ft_list_sort(t_list **begin_list, int (*cmp)(void *, void *));
; RDI: address of the start of the list to sort
; RSI: comparing function
ft_list_sort:
	push	rbx					; will act as swap check
	push	r15					; will hold list pointer
	sub		rsp, 16
	mov		[rsp + 8], rsi		; int (*cmp)(void *, void *)
	mov		[rsp], rdi			; t_list **begin_list
	mov		rdi, [rdi]			; deref **begin_list
	mov		rax, [rdi + 8]		; check t_list->next
	test	rax, rax			; test if NULL
	jz		.end				; leave if it is, nothing to sort here

.mainloop:
	xor		rbx, rbx			; clear rbx for run
	mov		r15, [rsp]			; **begin_list
	mov		r15, [r15]			; deref **begin_list

.loop:
	mov		rdi, [r15]			; move t_list->data in rdi
	mov		rsi, [r15 + 8]		; move t_list->next in rsi
	mov		rsi, [rsi]			; move t_list->next->data in rsi
	call	[rsp + 8]			; call cmp
	test	eax, eax			; test if result was 0
	jle		.noswap				; Jump if Less or Equal to noswap
	mov		rax, [r15]			; move t_list->data in rax
	mov		rdi, [r15 + 8]		; move t_list->next in rdi
	mov		rsi, [rdi]			; move t_list->next->data in rsi
	mov		[rdi], rax			; move t_list->data in next->data
	mov		[r15], rsi			; move t_list->next->data in t_list->data
	mov		rbx, 1				; flag swap

.noswap:
	mov		r15, [r15 + 8]		; load t_list->next
	mov		rsi, [r15 + 8]		; load t_list->next
	test	rsi, rsi			; test if NULL
	jnz		.loop				; jump to inner loop if NULL

.outloop:
	test	rbx, rbx			; test if we swapped anything
	jnz		.mainloop			; re-run the algorithm if we did

.end:
	add		rsp, 16
	pop		r15
	pop		rbx
	ret
