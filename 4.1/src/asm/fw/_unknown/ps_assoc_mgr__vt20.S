/* ps_assoc_mgr__vt20 @ 0x8dd480, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ps_assoc_mgr__vt20,"ax",@progbits
	.global ps_assoc_mgr__vt20
ps_assoc_mgr__vt20:
L_8dd480:
	add_s r0,r0,0xc
L_8dd482:
	ld_s r1,[r0,0x2c]
L_8dd484:
	ld_s r1,[r1,0x18]
L_8dd486:
	j_s [r1]
