/* bitmask_below @ 0x8e55ac, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_phy__get_883b80
 */
	.section .text.bitmask_below,"ax",@progbits
	.global bitmask_below
bitmask_below:
	.global L_8e55ac
L_8e55ac:
	mov_s r2,0x0
L_8e55ae:
	bset r2,r2,r1
L_8e55b2:
	lsr_s r1,r2
L_8e55b4:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8e55b6:
	sub r3,r0,r2
L_8e55ba:
	cmp_s r0,r1
L_8e55bc:
	j_s.d [blink]
L_8e55be:
	.byte 0xca,0x20
