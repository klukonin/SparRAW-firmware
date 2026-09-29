/* calib_base__vt2c @ 0x8cac24, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_divmod_signed, get_g_8000a0, get_g_80013c
 */
	.section .text.calib_base__vt2c,"ax",@progbits
	.global calib_base__vt2c
calib_base__vt2c:
L_8cac24:
	push_s blink
L_8cac26:
	bl L_8c02c0
L_8cac2a:
	mov_s r14,r1
L_8cac2c:
	bl.d L_8c98a4
L_8cac30:
	mov_s r13,r2
L_8cac32:
	mov r15,-0x1
L_8cac36:
	st_s r0,[r14]
L_8cac38:
	breq r0,r15,L_8cac46
L_8cac3c:
	bl.d L_8c03bc
L_8cac40:
	mov r1,0x3e8
L_8cac44:
	st_s r0,[r14]
	.global L_8cac46
L_8cac46:
	bl L_8ca7fc
L_8cac4a:
	st_s r0,[r13]
L_8cac4c:
	breq r0,r15,L_8cac5a
L_8cac50:
	bl.d L_8c03bc
L_8cac54:
	mov r1,0x3e8
L_8cac58:
	st_s r0,[r13]
	.global L_8cac5a
L_8cac5a:
	b L_8c032c
L_8cac5e:
	nop_s
