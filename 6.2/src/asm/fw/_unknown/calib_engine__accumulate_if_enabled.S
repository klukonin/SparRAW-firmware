/* calib_engine__accumulate_if_enabled @ 0x8eaa20, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__on_ready_for_correction
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_engine__accumulate_if_enabled
calib_engine__accumulate_if_enabled:
	.global L_8eaa20
L_8eaa20:
	mov_s r1,0x853920
L_8eaa26:
	ldb_s r1,[r1]
L_8eaa28:
	breq_s r1,0,L_8eaa36
L_8eaa2a:
	mov_s r2,0x853900
L_8eaa30:
	ld_s r1,[r2,0x10]
L_8eaa32:
	add_s r0,r0,r1
L_8eaa34:
	st_s r0,[r2,0x10]
	.global L_8eaa36
L_8eaa36:
	j_s [blink]
