/* ps_assoc_mgr__vt10 @ 0x8dd1d8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ps_assoc_mgr__vt10,"ax",@progbits
	.global ps_assoc_mgr__vt10
ps_assoc_mgr__vt10:
L_8dd1d8:
	add_s r0,r0,0xc
L_8dd1da:
	ld_s r1,[r0,0x2c]
L_8dd1dc:
	ld_s r1,[r1,0x8]
L_8dd1de:
	j_s [r1]
