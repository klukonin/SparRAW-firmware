/* rgf_reg_880a80_8cee18 @ 0x8cee18, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__apply_880a80_mode, pcie__program_880a80_seq
 */
	.section .text.rgf_reg_880a80_8cee18,"ax",@progbits
	.global rgf_reg_880a80_8cee18
rgf_reg_880a80_8cee18:
	.global L_8cee18
L_8cee18:
	mov_s r1,0x880a80
L_8cee1e:
	cmp_s r0,0x0
L_8cee20:
	ld_s r0,[r1,0x7c]
L_8cee22:
	beq_s L_8cee34
L_8cee24:
	bset_s r0,r0,0x9
L_8cee26:
	st_s r0,[r1,0x7c]
L_8cee28:
	ld_s r0,[r1,0x7c]
L_8cee2a:
	bset_s r0,r0,0xa
L_8cee2c:
	st_s r0,[r1,0x7c]
L_8cee2e:
	ld_s r0,[r1,0x7c]
L_8cee30:
	bset_s r0,r0,0xb
L_8cee32:
	b_s L_8cee42
	.global L_8cee34
L_8cee34:
	bclr_s r0,r0,0x9
L_8cee36:
	st_s r0,[r1,0x7c]
L_8cee38:
	ld_s r0,[r1,0x7c]
L_8cee3a:
	bclr_s r0,r0,0xa
L_8cee3c:
	st_s r0,[r1,0x7c]
L_8cee3e:
	ld_s r0,[r1,0x7c]
L_8cee40:
	bclr_s r0,r0,0xb
	.global L_8cee42
L_8cee42:
	st_s r0,[r1,0x7c]
L_8cee44:
	j_s [blink]
L_8cee46:
	nop_s
