/* abif__set_ctrl48_bit18 @ 0x8ce500, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ut_hw_modes_cmd_0x30b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__set_ctrl48_bit18
abif__set_ctrl48_bit18:
	.global L_8ce500
L_8ce500:
	mov_s r1,0x88af00
L_8ce506:
	cmp_s r0,0x1
L_8ce508:
	ld_s r0,[r1,0x48]
L_8ce50a:
	bset.eq r0,r0,0x12
L_8ce50e:
	bclr.ne r0,r0,0x12
L_8ce512:
	st_s r0,[r1,0x48]
L_8ce514:
	j_s [blink]
L_8ce516:
	nop_s
