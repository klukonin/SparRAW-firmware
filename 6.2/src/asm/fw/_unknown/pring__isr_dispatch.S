/* pring__isr_dispatch @ 0x8ebf00, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_08
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_dma__uses_rgf_881c00_8d07f8, hwd_dma__uses_rgf_881c00_8d0b74, u_schd__add, vring__reg_write_locked_28
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pring__isr_dispatch
pring__isr_dispatch:
	.global L_8ebf00
L_8ebf00:
	push_s blink
L_8ebf02:
	bl L_8c01d8
L_8ebf06:
	bl L_8d07f8
L_8ebf0a:
	mov_s r16,r0
L_8ebf0c:
	bmsk r14,r0,0x0
L_8ebf10:
	lsr r13,r0,0x4
L_8ebf14:
	bmsk_s r13,r13,0x0
L_8ebf16:
	lsr r15,r0,0x8
L_8ebf1a:
	bmsk_s r15,r15,0x0
L_8ebf1c:
	b_s L_8ebf3a
	.global L_8ebf1e
L_8ebf1e:
	norm r0,r14
L_8ebf22:
	rsub r17,r0,0x1e
L_8ebf26:
	mov_s r0,L_8e0eec-0x8c0000
L_8ebf2c:
	mov_s r1,r17
L_8ebf2e:
	mov_s r2,0x0
L_8ebf30:
	bl.d L_8c3248
L_8ebf34:
	mov_s r3,0x2
L_8ebf36:
	bclr r14,r14,r17
	.global L_8ebf3a
L_8ebf3a:
	brne_s r14,0,L_8ebf1e
L_8ebf3c:
	b_s L_8ebf5a
	.global L_8ebf3e
L_8ebf3e:
	norm r0,r13
L_8ebf42:
	rsub r14,r0,0x1e
L_8ebf46:
	mov_s r0,0x20ecc
L_8ebf4c:
	mov_s r1,r14
L_8ebf4e:
	mov_s r2,0x0
L_8ebf50:
	bl.d L_8c3248
L_8ebf54:
	mov_s r3,0x2
L_8ebf56:
	bclr r13,r13,r14
	.global L_8ebf5a
L_8ebf5a:
	brne_s r13,0,L_8ebf3e
L_8ebf5c:
	b_s L_8ebf7a
	.global L_8ebf5e
L_8ebf5e:
	norm r0,r15
L_8ebf62:
	rsub r13,r0,0x1e
L_8ebf66:
	mov_s r0,0x20edc
L_8ebf6c:
	mov_s r1,r13
L_8ebf6e:
	mov_s r2,0x0
L_8ebf70:
	bl.d L_8c3248
L_8ebf74:
	mov_s r3,0x2
L_8ebf76:
	bclr r15,r15,r13
	.global L_8ebf7a
L_8ebf7a:
	brne_s r15,0,L_8ebf5e
L_8ebf7c:
	mov_s r0,r16
L_8ebf7e:
	bl.d L_8d0b74
L_8ebf82:
	mov_s r1,0x1
L_8ebf84:
	mov_s r0,r16
L_8ebf86:
	bl.d L_8d0538
L_8ebf8a:
	mov_s r1,0x1
L_8ebf8c:
	b L_8c023c
