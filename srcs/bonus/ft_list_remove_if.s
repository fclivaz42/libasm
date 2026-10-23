; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_remove_if.s                                :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/26 21:40:29 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/23 19:34:43 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

extern	free

global	ft_list_remove_if
default	rel

section .data

section .text
ft_list_remove_if:
	push	r15
	push	rbx
	sub		rsp, 32
	mov		[rsp + 16], rcx		; void (*free_fct)(void *)
	mov		[rsp + 8], rdx		; int (*cmp)(void *, void *)
	mov		[rsp], rsi			; void *data_ref
	mov		r15, rdi			; t_list **begin_list
	mov		rbx, [r15]			; dereference r15 to get t_list* into rbx

	mov		rax, [rbx + 8]		; check t_list->next
	test	rax, rax			; test if NULL
	jz		.process			; process if it is, recursive call if not
	lea		rdi, [rbx + 8]		; pass the reference to t_list->next as parameter
	call	ft_list_remove_if	; recursive call

.process:
	mov		rdi, [rbx]		; move t_ist->data into 1st argument
	mov		rsi, [rsp]		; move data_ref into 2nd argument
	call	[rsp + 8]		; call cmp function from stack
	test	rax, rax		; check if the result is 0
	jnz		.no_match		; don't execute the freeing if the cmp fails

.match:						; label to figure out what we're doing
	mov		rax, [rbx + 8]	; mov t_list->next into rax...
	mov		[r15], rax		; ... to move it back into whatever r15 points to.
	mov		rdi, [rbx]		; prepare args for free_fct
	call	[rsp + 16]		; call free_fct from the stack
	mov		rdi, rbx		; prepare args for free
	call	free WRT ..plt	; call free
	jmp		.end			; don't execute non-matching code

.no_match:
	mov		[r15], rbx		; move t_list nto whatever r15 points to.

.end:
	add		rsp, 32
	pop		rbx
	pop		r15
	ret
