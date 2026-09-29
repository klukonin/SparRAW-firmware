/* hwd_dma__write_ring_reg @ 0x8d0c00, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion, tx_ring__post_frame
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__write_ring_reg
hwd_dma__write_ring_reg:
	.global L_8d0c00
L_8d0c00:
	mul64 r0,0x380
L_8d0c04:
	add r0,mlo,0x4409740
L_8d0c0c:
	lsr_s r0,r0,0x3
L_8d0c0e:
	bic r0,r0,0x3
L_8d0c12:
	st_s r1,[r0]
L_8d0c14:
	j_s [blink]
L_8d0c16:
	nop_s
