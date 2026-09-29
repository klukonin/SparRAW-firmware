/* vring_schdlr__isr_dispatch @ 0x8e738c, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schdlr.cpp
 * Зовут его: isr_vring_dma
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, hwd_dma__ack_881c44, hwd_dma__ack_881c54, hwd_dma__read_cause_881c48, u_schd__add
 */
	.section .text.vring_schdlr__isr_dispatch,"ax",@progbits
	.global vring_schdlr__isr_dispatch
vring_schdlr__isr_dispatch:
	.global L_8e738c
L_8e738c:
	push_s blink
L_8e738e:
	bl L_8c02c0
L_8e7392:
	bl L_8cdac4
L_8e7396:
	lsr.f 0x0,r0,0x18
L_8e739a:
	bmsk r15,r0,0x17
L_8e739e:
	bne_s L_8e73d6
	.global L_8e73a0
L_8e73a0:
	mov_s r14,r15
L_8e73a2:
	b_s L_8e73c0
	.global L_8e73a4
L_8e73a4:
	norm r0,r14
L_8e73a8:
	rsub r13,r0,0x1e
L_8e73ac:
	mov_s r0,0x23aa0
L_8e73b2:
	mov_s r1,r13
L_8e73b4:
	mov_s r2,0x0
L_8e73b6:
	bl.d L_8c2ac8
L_8e73ba:
	mov_s r3,0x1
L_8e73bc:
	bclr r14,r14,r13
	.global L_8e73c0
L_8e73c0:
	brne_s r14,0,L_8e73a4
L_8e73c2:
	mov_s r0,r15
L_8e73c4:
	bl.d L_8cdec4
L_8e73c8:
	mov_s r1,0x1
L_8e73ca:
	mov_s r0,r15
L_8e73cc:
	bl.d L_8cd734
L_8e73d0:
	mov_s r1,0x1
L_8e73d2:
	b L_8c032c
	.global L_8e73d6
L_8e73d6:
	mov_s r0,blink
L_8e73d8:
	mov_s r2,0x100a584
L_8e73de:
	mov_s r1,0x12b0
L_8e73e4:
	bl.d L_8c82c0
L_8e73e8:
	mov_s r3,0x29
L_8e73ea:
	b_s L_8e73a0
