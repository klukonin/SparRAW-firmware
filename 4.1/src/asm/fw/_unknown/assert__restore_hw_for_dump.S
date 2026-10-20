/* assert__restore_hw_for_dump @ 0x8e35e4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysassert_fatal
 * Зовёт сам: get_g_80035c, hwd_pcie__set_low_power, hwd_phy__power_up_seq, hwm__apply_mode_flags
 */
	.section .text.assert__restore_hw_for_dump,"ax",@progbits
	.global assert__restore_hw_for_dump
assert__restore_hw_for_dump:
	.global L_8e35e4
L_8e35e4:
	push_s blink
L_8e35e6:
	bl.d L_8d50e4
L_8e35ea:
	mov_s r0,0x0
L_8e35ec:
	bl L_8ca008
L_8e35f0:
	add r1,r0,0xc
L_8e35f4:
	bl.d L_8d4d5c
L_8e35f8:
	mov_s r0,0x0
L_8e35fa:
	bl.d L_8d4d20
L_8e35fe:
	mov_s r0,0x0
L_8e3600:
	pop_s blink
L_8e3602:
	j_s [blink]
