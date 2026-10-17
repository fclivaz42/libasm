; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_simd_memchr.s                                   :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: fclivaz <fclivaz@student.42lausanne.ch>    +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2026/09/21 19:41:08 by fclivaz           #+#    #+#              ;
;    Updated: 2026/10/17 19:53:38 by fclivaz          ###   LAUSANNE.ch        ;
;                                                                              ;
; **************************************************************************** ;

global ft_simd_memchr
default rel

section .data
	avx_reg_size dq	0x20		; AVX register size

section .text
; void	*ft_simd_memchr(const void *mem, int c, size_t n);
; RDI: pointer to the memory location to analyze
; RSI: character to test against, as usigned char
; RDX: size of the memory buffer to analyze
; RAX: first occurence of c in mem, or NULL otherwise
ft_simd_memchr:
	xor				rax, rax			; clear rax
	test			rdx, rdx			; check if given size is zero
	jz				.end				; ...why should we run if it is?
	xor				r9, r9				; clear r9, which will be our accumulator
	vpbroadcastb	ymm2, sil			; broadcast to ymm2 the char we are looking for
	cmp				rdx, [avx_reg_size]	; compare if the given size >= 32
	jae				.full				; jump to 32-byte wide calculation if it is
	jmp				.tail				; jump to tail call if it is not

.full:
	vmovups			ymm1, [rdi + r9]	; move in ymm1 the 32 bytes that are at rdi + the accumulator
	vpcmpeqb 		ymm0, ymm1, ymm2	; avx packed compare equal bytes ymm1 == ymm2 => ymm0
	vpmovmskb		r10d, ymm0			; avx packed move masked bytes ymm0 -> r10d (clears 32 upper bits)
	bsf				r10d, r10d			; Bit Scan Forward r10d, storing result in r10d
	jnz				.ret				; if something was found, jump to ret
	add				r9, [avx_reg_size]	; increment r9 by 32
	sub				rdx, [avx_reg_size]	; subtract rdx by 32
	cmp				rdx, [avx_reg_size]	; compare rdx with 32
	jae				.full				; jump back to full scan if above or equal 32, fall through otherwise
	jz				.end				; leave if nothing was found and we reached the end of the buffer

.tail:
	push			r9					; save state of r9
	sub				rsp, [avx_reg_size]	; set stack frame up for copying into ymm0
	vxorps			ymm0, ymm0, ymm0	; avx xor packed singles ymm0
	vmovups			[rsp], ymm0			; avx move unaligned packed singles from ymm0 to [rsp]
	xor				r11, r11			; clear r11, our copy counter

.tailcpy:
	mov				r8b, [rdi + r9]		; move whatever is at rdi + r9 into r8b
	mov				[rsp + r11], r8b	; ...and move that back into rsp + r11
	inc				r11					; increment r11
	inc				r9					; increment r9
	cmp				r11, rdx			; compare r11 to rdx
	jb				.tailcpy			; continue copy as long as r11 != rdx

.tailcmp:
	vmovups			ymm1, [rsp]			; move 32 bytes from rsp into ymm1
	vpcmpeqb 		ymm0, ymm1, ymm2	; avx packed compare equal bytes ymm1 == ymm2 => ymm0
	vpmovmskb		r10d, ymm0			; avx packed move masked bytes ymm0 -> r10d (clears 32 upper bits)
	add				rsp, [avx_reg_size]	; restore stack frame
	pop				r9					; restore r9
	bsf				r10d, r10d			; Bit Scan Forward r10d, storing result in r10d
	jz				.end				; if no match found, do not update rax

.ret:
	add				r9, r10				; add to r9 the result of bit scan forward
	mov				rax, rdi			; move pointer in rdi to rax
	add				rax, r9				; add to rax the position of the byte that is in r9

.end:
	vzeroupper							; clear upper 16 bits of the AVX registers
	ret									; return!
