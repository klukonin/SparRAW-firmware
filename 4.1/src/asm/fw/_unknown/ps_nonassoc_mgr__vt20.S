/* ps_nonassoc_mgr__vt20 @ 0x8dd4a8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ps_nonassoc_mgr__vt20,"ax",@progbits
	.global ps_nonassoc_mgr__vt20
ps_nonassoc_mgr__vt20:
L_8dd4a8:
	add_s r0,r0,0xc
L_8dd4aa:
	ld_s r1,[r0,0x2c]
L_8dd4ac:
	ld_s r1,[r1,0x18]
L_8dd4ae:
	j_s [r1]
