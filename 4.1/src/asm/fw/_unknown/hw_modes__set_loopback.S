/* hw_modes__set_loopback @ 0x8d4c30, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, hwf_calib__release_hw
 * Зовёт сам: __ld_r13_ret, hwd_abif__rgf_88af80_8cb8d8, hwd_abif__set_sel_nibbles, hwd_mac__set_886d80_8ce294, hwd_mac__set_886d80_8ce2bc
 */
	.section .text.hw_modes__set_loopback,"ax",@progbits
	.global hw_modes__set_loopback
hw_modes__set_loopback:
	.global L_8d4c30
L_8d4c30:
	push_s blink
L_8d4c32:
	push_s r13
L_8d4c34:
	mov_s r13,r1
L_8d4c36:
	breq_s r0,0,L_8d4c50
L_8d4c38:
	bl.d L_8cb8d8
L_8d4c3c:
	mov_s r0,0x0
L_8d4c3e:
	mov_s r0,0x3
L_8d4c40:
	mov_s r1,0x2
L_8d4c42:
	bl.d L_8cbb20
L_8d4c46:
	mov_s r2,0x0
L_8d4c48:
	bl.d L_8ce2bc
L_8d4c4c:
	mov_s r0,r13
L_8d4c4e:
	b_s L_8d4c54
	.global L_8d4c50
L_8d4c50:
	bl L_8ce294
	.global L_8d4c54
L_8d4c54:
	b L_8c033c
