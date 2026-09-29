/* rgf_reg_889480 @ 0x8d15cc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf__apply_tx_power
 */
	.section .text.rgf_reg_889480,"ax",@progbits
	.global rgf_reg_889480
rgf_reg_889480:
	.global L_8d15cc
L_8d15cc:
	mov_s r1,0x889480
L_8d15d2:
	cmp_s r0,0x0
L_8d15d4:
	ld_s r0,[r1,0x14]
L_8d15d6:
	beq_s L_8d15e6
L_8d15d8:
	or r0,r0,0x3
L_8d15dc:
	st_s r0,[r1,0x14]
L_8d15de:
	ld_s r0,[r1,0x14]
L_8d15e0:
	or r0,r0,0xc
L_8d15e4:
	b_s L_8d15f2
	.global L_8d15e6
L_8d15e6:
	bic r0,r0,0x3
L_8d15ea:
	st_s r0,[r1,0x14]
L_8d15ec:
	ld_s r0,[r1,0x14]
L_8d15ee:
	bic r0,r0,0xc
	.global L_8d15f2
L_8d15f2:
	st_s r0,[r1,0x14]
L_8d15f4:
	j_s [blink]
L_8d15f6:
	nop_s
