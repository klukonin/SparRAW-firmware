/* hwd_dma__uses_rgf_881000 @ 0x8d0ba4, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__uses_rgf_881000
hwd_dma__uses_rgf_881000:
	.global L_8d0ba4
L_8d0ba4:
	push_s blink
L_8d0ba6:
	bl L_8c01e0
L_8d0baa:
	mov_s r15,r0
L_8d0bac:
	mov_s r14,r1
L_8d0bae:
	mov_s r13,r2
L_8d0bb0:
	mov_s r0,0x881000
L_8d0bb6:
	st_s r1,[r0,0x2c]
L_8d0bb8:
	sync
L_8d0bbc:
	cmp_s r14,0x0
L_8d0bbe:
	cmp.ne r13,0x0
L_8d0bc2:
	beq_s L_8d0bfa
L_8d0bc4:
	mul64 r15,0x380
L_8d0bc8:
	mov_s r3,0x0
L_8d0bca:
	mov_s r15,0x0
L_8d0bcc:
	add r0,mlo,0x4409a20
L_8d0bd4:
	lsr r1,r0,0x3
L_8d0bd8:
	bmsk_s r0,r0,0x4
L_8d0bda:
	add r14,r0,0x1f
L_8d0bde:
	bset r3,r3,r14
L_8d0be2:
	bic r2,r1,0x3
L_8d0be6:
	ld_s r1,[r2]
L_8d0be8:
	bset r15,r15,r0
L_8d0bec:
	sub r14,r3,r15
L_8d0bf0:
	or_s r3,r3,r14
L_8d0bf2:
	asl_s r13,r13,r0
L_8d0bf4:
	bic_s r1,r1,r3
L_8d0bf6:
	or_s r13,r13,r1
L_8d0bf8:
	st_s r13,[r2]
	.global L_8d0bfa
L_8d0bfa:
	b L_8c024c
L_8d0bfe:
	nop_s
