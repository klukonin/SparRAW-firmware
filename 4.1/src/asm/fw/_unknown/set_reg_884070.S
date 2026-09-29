/* set_reg_884070 @ 0x8d037c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power_step, hwf_calib__release_hw
 */
	.section .text.set_reg_884070,"ax",@progbits
	.global set_reg_884070
set_reg_884070:
	.global L_8d037c
L_8d037c:
	mov_s r1,0x884000
L_8d0382:
	st_s r0,[r1,0x70]
L_8d0384:
	j_s [blink]
L_8d0386:
	nop_s
