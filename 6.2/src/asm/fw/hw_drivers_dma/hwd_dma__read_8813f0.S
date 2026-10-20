/* hwd_dma__read_8813f0 @ 0x8d081c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__read_8813f0
hwd_dma__read_8813f0:
	.global L_8d081c
L_8d081c:
	mov_s r0,0x881380
L_8d0822:
	ld_s r0,[r0,0x70]
L_8d0824:
	j_s [blink]
L_8d0826:
	nop_s
