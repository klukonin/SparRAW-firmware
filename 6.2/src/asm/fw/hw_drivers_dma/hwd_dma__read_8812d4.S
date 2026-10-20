/* hwd_dma__read_8812d4 @ 0x8d07c8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_lost_diag__dump_dma
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__read_8812d4
hwd_dma__read_8812d4:
	.global L_8d07c8
L_8d07c8:
	mov_s r0,0x881280
L_8d07ce:
	ld_s r0,[r0,0x54]
L_8d07d0:
	j_s [blink]
L_8d07d2:
	nop_s
