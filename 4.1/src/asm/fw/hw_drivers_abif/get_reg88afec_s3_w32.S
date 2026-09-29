/* get_reg88afec_s3_w32 @ 0x8cd27c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: car__enable_pll3_and_wait, hwd_abif__set_889800_8cd1f4
 */
	.section .text.get_reg88afec_s3_w32,"ax",@progbits
	.global get_reg88afec_s3_w32
get_reg88afec_s3_w32:
	.global L_8cd27c
L_8cd27c:
	mov_s r0,0x88af80
L_8cd282:
	ld_s r0,[r0,0x6c]
L_8cd284:
	lsr_s r0,r0,0x3
L_8cd286:
	j_s.d [blink]
L_8cd288:
	bmsk_s r0,r0,0x0
L_8cd28a:
	nop_s
