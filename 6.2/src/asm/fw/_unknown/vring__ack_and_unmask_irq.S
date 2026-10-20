/* vring__ack_and_unmask_irq @ 0x8d85d4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__disconnect_notify, vring_schd__fill_vring_cfg, vring_schd__resume_vring, vring_schd__stop_vring
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_dma__ack_881c44, vring_hw__unmask_irq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__ack_and_unmask_irq
vring__ack_and_unmask_irq:
	.global L_8d85d4
L_8d85d4:
	push_s blink
L_8d85d6:
	bl L_8c01e4
L_8d85da:
	ld_s r1,[r0,0x20]
L_8d85dc:
	mov_s r13,0x1
L_8d85de:
	st_s r13,[r0,0x24]
L_8d85e0:
	brne r1,0x1,L_8d85fe
L_8d85e4:
	ldb_s r14,[r0,0x9]
L_8d85e6:
	mov_s r0,0x0
L_8d85e8:
	bset r0,r0,r14
L_8d85ec:
	bl.d L_8d05c0
L_8d85f0:
	mov_s r1,r13
L_8d85f2:
	mov_s r0,0x0
L_8d85f4:
	bset r0,r0,r14
L_8d85f8:
	bl.d L_8d05f0
L_8d85fc:
	mov_s r1,r13
	.global L_8d85fe
L_8d85fe:
	b L_8c0254
L_8d8602:
	nop_s
