/* hw_cfg__get_8004fc_bit0 @ 0x8ce1a8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__halt, deep_sleep_exit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_cfg__get_8004fc_bit0
hw_cfg__get_8004fc_bit0:
	.global L_8ce1a8
L_8ce1a8:
	mov_s r0,0x8004f8
L_8ce1ae:
	ldb_s r0,[r0,0x4]
L_8ce1b0:
	j_s.d [blink]
L_8ce1b2:
	bmsk_s r0,r0,0x0
