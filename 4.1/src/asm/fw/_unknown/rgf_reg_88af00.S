/* rgf_reg_88af00 @ 0x8cb7d4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ut_hw_modes_cmd_0x30b
 */
	.section .text.rgf_reg_88af00,"ax",@progbits
	.global rgf_reg_88af00
rgf_reg_88af00:
	.global L_8cb7d4
L_8cb7d4:
	mov_s r1,0x88af00
L_8cb7da:
	cmp_s r0,0x1
L_8cb7dc:
	ld_s r0,[r1,0x48]
L_8cb7de:
	bset.eq r0,r0,0x12
L_8cb7e2:
	bclr.ne r0,r0,0x12
L_8cb7e6:
	st_s r0,[r1,0x48]
L_8cb7e8:
	j_s [blink]
L_8cb7ea:
	nop_s
