/* obj__set_vtable__8f3560 @ 0x8f3560, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_fw_ver
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj__set_vtable__8f3560
obj__set_vtable__8f3560:
	.global L_8f3560
L_8f3560:
	mov_s r2,0x801ba4
L_8f3566:
	st_s r2,[r0]
L_8f3568:
	mov_s r0,0x1
L_8f356a:
	j_s.d [blink]
L_8f356c:
	stb_s r0,[r1]
L_8f356e:
	nop_s
