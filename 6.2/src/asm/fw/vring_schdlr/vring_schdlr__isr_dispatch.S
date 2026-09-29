/* vring_schdlr__isr_dispatch @ 0x8ebf90, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_vring_dma_fw
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, hwd_dma__ack_881c44, hwd_dma__uses_rgf_881c00_8d0870, hwd_dma__uses_rgf_881c00_8d0c18, u_schd__add
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schdlr__isr_dispatch
vring_schdlr__isr_dispatch:
	.global L_8ebf90
L_8ebf90:
	push_s blink
L_8ebf92:
	bl L_8c01e0
L_8ebf96:
	bl L_8d0870
L_8ebf9a:
	lsr.f 0x0,r0,0x18
L_8ebf9e:
	bmsk r15,r0,0x17
L_8ebfa2:
	bne_s L_8ebfda
	.global L_8ebfa4
L_8ebfa4:
	mov_s r14,r15
L_8ebfa6:
	b_s L_8ebfc4
	.global L_8ebfa8
L_8ebfa8:
	norm r0,r14
L_8ebfac:
	rsub r13,r0,0x1e
L_8ebfb0:
	mov_s r0,L_8e8a70-0x8c0000
L_8ebfb6:
	mov_s r1,r13
L_8ebfb8:
	mov_s r2,0x0
L_8ebfba:
	bl.d L_8c3248
L_8ebfbe:
	mov_s r3,0x1
L_8ebfc0:
	bclr r14,r14,r13
	.global L_8ebfc4
L_8ebfc4:
	brne_s r14,0,L_8ebfa8
L_8ebfc6:
	mov_s r0,r15
L_8ebfc8:
	bl.d L_8d0c18
L_8ebfcc:
	mov_s r1,0x1
L_8ebfce:
	mov_s r0,r15
L_8ebfd0:
	bl.d L_8d05c0
L_8ebfd4:
	mov_s r1,0x1
L_8ebfd6:
	b L_8c024c
	.global L_8ebfda
L_8ebfda:
	mov_s r0,blink
L_8ebfdc:
	mov_s r1,0x12b0
L_8ebfe2:
	bl L_8c9b28
L_8ebfe6:
	b_s L_8ebfa4
