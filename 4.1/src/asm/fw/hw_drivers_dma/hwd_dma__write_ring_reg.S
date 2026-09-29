/* hwd_dma__write_ring_reg @ 0x8cdeac, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion, tx_dma_if__push_desc
 */
	.section .text.hwd_dma__write_ring_reg,"ax",@progbits
	.global hwd_dma__write_ring_reg
hwd_dma__write_ring_reg:
	.global L_8cdeac
L_8cdeac:
	mul64 r0,0x380
L_8cdeb0:
	add r0,mlo,0x4409740
L_8cdeb8:
	lsr_s r0,r0,0x3
L_8cdeba:
	bic r0,r0,0x3
L_8cdebe:
	st_s r1,[r0]
L_8cdec0:
	j_s [blink]
L_8cdec2:
	nop_s
