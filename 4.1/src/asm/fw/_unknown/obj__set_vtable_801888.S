/* obj__set_vtable_801888 @ 0x8ebcbc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_fw_ver
 */
	.section .text.obj__set_vtable_801888,"ax",@progbits
	.global obj__set_vtable_801888
obj__set_vtable_801888:
	.global L_8ebcbc
L_8ebcbc:
	mov_s r2,0x801888
L_8ebcc2:
	st_s r2,[r0]
L_8ebcc4:
	mov_s r0,0x1
L_8ebcc6:
	j_s.d [blink]
L_8ebcc8:
	stb_s r0,[r1]
L_8ebcca:
	nop_s
