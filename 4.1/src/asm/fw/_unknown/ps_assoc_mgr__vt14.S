/* ps_assoc_mgr__vt14 @ 0x8d7420, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ps_assoc_mgr__vt14,"ax",@progbits
	.global ps_assoc_mgr__vt14
ps_assoc_mgr__vt14:
L_8d7420:
	add_s r0,r0,0xc
L_8d7422:
	ld_s r1,[r0,0x2c]
L_8d7424:
	ld_s r1,[r1,0xc]
L_8d7426:
	j_s [r1]
