/* hwd_dma__read_8813c8 @ 0x8d0828, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__read_8813c8
hwd_dma__read_8813c8:
	.global L_8d0828
L_8d0828:
	mov_s r0,0x881380
L_8d082e:
	ld_s r0,[r0,0x48]
L_8d0830:
	j_s [blink]
L_8d0832:
	nop_s
