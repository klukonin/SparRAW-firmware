/* dma_mgr__reset_queue @ 0x8e2e78, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dma_mgr.cpp
 * Зовут его: wmi_handler_pmc
 * Зовёт сам: __ld_r13_ret, dma_reset, fw_sysassert_fatal, hwd_dma__reset_ring
 */
	.section .text.dma_mgr__reset_queue,"ax",@progbits
	.global dma_mgr__reset_queue
dma_mgr__reset_queue:
	.global L_8e2e78
L_8e2e78:
	push_s blink
L_8e2e7a:
	push_s r13
L_8e2e7c:
	mov_s r13,r0
L_8e2e7e:
	brne r0,0x7,L_8e2e92
	.global L_8e2e82
L_8e2e82:
	bl.d L_8cd908
L_8e2e86:
	mov_s r0,r13
L_8e2e88:
	bl.d L_8cdbb0
L_8e2e8c:
	mov_s r0,r13
L_8e2e8e:
	b L_8c033c
	.global L_8e2e92
L_8e2e92:
	mov_s r0,blink
L_8e2e94:
	mov_s r2,0x10104a0
L_8e2e9a:
	mov_s r1,0x12e9
L_8e2ea0:
	bl.d L_8c82c0
L_8e2ea4:
	mov_s r3,0x32
L_8e2ea6:
	b_s L_8e2e82
