/* hwd_abif__get_88af00 @ 0x8ce5d8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__get_88af00
hwd_abif__get_88af00:
	.global L_8ce5d8
L_8ce5d8:
	mov_s r0,0x88af00
L_8ce5de:
	ld_s r0,[r0,0x40]
L_8ce5e0:
	bxor r0,r0,0x0
L_8ce5e4:
	j_s.d [blink]
L_8ce5e6:
	bmsk_s r0,r0,0x0
