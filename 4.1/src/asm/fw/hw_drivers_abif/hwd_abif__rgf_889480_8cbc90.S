/* hwd_abif__rgf_889480_8cbc90 @ 0x8cbc90, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_modes__program_rf_clocks
 */
	.section .text.hwd_abif__rgf_889480_8cbc90,"ax",@progbits
	.global hwd_abif__rgf_889480_8cbc90
hwd_abif__rgf_889480_8cbc90:
	.global L_8cbc90
L_8cbc90:
	mov_s r1,0x889480
L_8cbc96:
	cmp_s r0,0x1
L_8cbc98:
	ld_s r0,[r1,0x20]
L_8cbc9a:
	bne_s L_8cbcac
L_8cbc9c:
	or r0,r0,0xffe00000
L_8cbca4:
	st_s r0,[r1,0x20]
L_8cbca6:
	ld_s r0,[r1,0x24]
L_8cbca8:
	bset_s r0,r0,0x5
L_8cbcaa:
	b_s L_8cbcb4
	.global L_8cbcac
L_8cbcac:
	bmsk_s r0,r0,0x14
L_8cbcae:
	st_s r0,[r1,0x20]
L_8cbcb0:
	ld_s r0,[r1,0x24]
L_8cbcb2:
	bclr_s r0,r0,0x5
	.global L_8cbcb4
L_8cbcb4:
	st_s r0,[r1,0x24]
L_8cbcb6:
	j_s [blink]
