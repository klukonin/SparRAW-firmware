/* vring_hw__read_status_bit @ 0x8cd9ec, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txrx_mgr__handle_dma_irq
 */
	.section .text.vring_hw__read_status_bit,"ax",@progbits
	.global vring_hw__read_status_bit
vring_hw__read_status_bit:
	.global L_8cd9ec
L_8cd9ec:
	mul64 r0,0x380
L_8cd9f0:
	add r0,mlo,0x44096e2
L_8cd9f8:
	lsr r1,r0,0x3
L_8cd9fc:
	bic r1,r1,0x3
L_8cda00:
	ld_s r1,[r1]
L_8cda02:
	bmsk_s r0,r0,0x4
L_8cda04:
	lsr r0,r1,r0
L_8cda08:
	j_s.d [blink]
L_8cda0a:
	bmsk_s r0,r0,0x0
