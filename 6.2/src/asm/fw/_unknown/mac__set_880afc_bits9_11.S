/* mac__set_880afc_bits9_11 @ 0x8d1ac0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__apply_mode_fw_8825c0__8d10c8, pcie__program_seq_fw_8825c0__8d1114
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_880afc_bits9_11
mac__set_880afc_bits9_11:
	.global L_8d1ac0
L_8d1ac0:
	mov_s r1,0x880a80
L_8d1ac6:
	cmp_s r0,0x0
L_8d1ac8:
	ld_s r0,[r1,0x7c]
L_8d1aca:
	beq_s L_8d1adc
L_8d1acc:
	bset_s r0,r0,0x9
L_8d1ace:
	st_s r0,[r1,0x7c]
L_8d1ad0:
	ld_s r0,[r1,0x7c]
L_8d1ad2:
	bset_s r0,r0,0xa
L_8d1ad4:
	st_s r0,[r1,0x7c]
L_8d1ad6:
	ld_s r0,[r1,0x7c]
L_8d1ad8:
	bset_s r0,r0,0xb
L_8d1ada:
	b_s L_8d1aea
	.global L_8d1adc
L_8d1adc:
	bclr_s r0,r0,0x9
L_8d1ade:
	st_s r0,[r1,0x7c]
L_8d1ae0:
	ld_s r0,[r1,0x7c]
L_8d1ae2:
	bclr_s r0,r0,0xa
L_8d1ae4:
	st_s r0,[r1,0x7c]
L_8d1ae6:
	ld_s r0,[r1,0x7c]
L_8d1ae8:
	bclr_s r0,r0,0xb
	.global L_8d1aea
L_8d1aea:
	st_s r0,[r1,0x7c]
L_8d1aec:
	j_s [blink]
L_8d1aee:
	nop_s
