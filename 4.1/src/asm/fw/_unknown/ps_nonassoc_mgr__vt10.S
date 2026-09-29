/* ps_nonassoc_mgr__vt10 @ 0x8dd1ec, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ps_nonassoc_mgr__vt10,"ax",@progbits
	.global ps_nonassoc_mgr__vt10
ps_nonassoc_mgr__vt10:
L_8dd1ec:
	add_s r0,r0,0xc
L_8dd1ee:
	ld_s r1,[r0,0x2c]
L_8dd1f0:
	ld_s r1,[r1,0x8]
L_8dd1f2:
	j_s [r1]
