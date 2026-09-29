/* ut_hw_drivers_cmd_0x138 @ 0x8cd008, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.ut_hw_drivers_cmd_0x138,"ax",@progbits
	.global ut_hw_drivers_cmd_0x138
ut_hw_drivers_cmd_0x138:
	.global L_8cd008
L_8cd008:
	mov_s r0,0x88a000
L_8cd00e:
	ld_s r0,[r0]
L_8cd010:
	lsr_s r0,r0
L_8cd012:
	j_s.d [blink]
L_8cd014:
	bmsk_s r0,r0,0x4
L_8cd016:
	nop_s
