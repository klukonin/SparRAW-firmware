/* ps_assoc_mgr__vt1c @ 0x8dd4e4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ps_assoc_mgr__vt1c,"ax",@progbits
	.global ps_assoc_mgr__vt1c
ps_assoc_mgr__vt1c:
L_8dd4e4:
	add_s r0,r0,0xc
L_8dd4e6:
	ld_s r1,[r0,0x2c]
L_8dd4e8:
	ld_s r1,[r1,0x14]
L_8dd4ea:
	j_s [r1]
