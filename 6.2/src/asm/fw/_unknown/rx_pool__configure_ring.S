/* rx_pool__configure_ring @ 0x8d8ef8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pool__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, dma_mgr__configure_ring, rx_pool__configure_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_pool__configure_ring
rx_pool__configure_ring:
	.global L_8d8ef8
L_8d8ef8:
	push_s blink
L_8d8efa:
	bl.d L_8c01e0
L_8d8efe:
	/* _add_s r0,0x4 */
	.byte 0x04,0xe0
L_8d8f00:
	mov_s r13,r1
L_8d8f02:
	mov_s r15,r2
L_8d8f04:
	bl.d L_8e60d0
L_8d8f08:
	mov_s r14,r3
L_8d8f0a:
	bmsk r1,r13,0x11
L_8d8f0e:
	mov_s r0,r14
L_8d8f10:
	mov_s r2,0x0
L_8d8f12:
	mov_s r3,r15
L_8d8f14:
	mov r4,0x1
L_8d8f18:
	mov r5,r4
L_8d8f1c:
	mov_s r6,r2
L_8d8f1e:
	bl.d L_8c6e90
L_8d8f22:
	mov_s r7,r2
L_8d8f24:
	b L_8c024c
