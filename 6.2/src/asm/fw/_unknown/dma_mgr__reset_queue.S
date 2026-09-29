/* dma_mgr__reset_queue @ 0x8e7f6c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_pmc
 * Зовёт сам: __ld_r13_to_r13_ret, dma_reset, fw_sysassert_fatal, hwd_dma__reset_ring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma_mgr__reset_queue
dma_mgr__reset_queue:
	.global L_8e7f6c
L_8e7f6c:
	push_s blink
L_8e7f6e:
	push_s r13
L_8e7f70:
	mov_s r13,r0
L_8e7f72:
	brne r0,0x7,L_8e7f86
	.global L_8e7f76
L_8e7f76:
	bl.d L_8d06ec
L_8e7f7a:
	mov_s r0,r13
L_8e7f7c:
	bl.d L_8d0970
L_8e7f80:
	mov_s r0,r13
L_8e7f82:
	b L_8c025c
	.global L_8e7f86
L_8e7f86:
	mov_s r0,blink
L_8e7f88:
	mov_s r1,0x1501
L_8e7f8e:
	bl L_8c9b28
L_8e7f92:
	b_s L_8e7f76
