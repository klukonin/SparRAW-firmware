/* ps_assoc_mgr__vt18 @ 0x8d7448, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ps_assoc_mgr__vt18,"ax",@progbits
	.global ps_assoc_mgr__vt18
ps_assoc_mgr__vt18:
L_8d7448:
	add_s r0,r0,0xc
L_8d744a:
	ld_s r1,[r0,0x2c]
L_8d744c:
	ld_s r1,[r1,0x10]
L_8d744e:
	j_s [r1]
