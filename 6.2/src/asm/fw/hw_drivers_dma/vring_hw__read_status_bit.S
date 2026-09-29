/* vring_hw__read_status_bit @ 0x8d0798, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txrx_mgr__handle_dma_irq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_hw__read_status_bit
vring_hw__read_status_bit:
	.global L_8d0798
L_8d0798:
	mul64 r0,0x380
L_8d079c:
	add r0,mlo,0x44096e2
L_8d07a4:
	lsr r1,r0,0x3
L_8d07a8:
	bic r1,r1,0x3
L_8d07ac:
	ld_s r1,[r1]
L_8d07ae:
	bmsk_s r0,r0,0x4
L_8d07b0:
	lsr r0,r1,r0
L_8d07b4:
	j_s.d [blink]
L_8d07b6:
	bmsk_s r0,r0,0x0
