/* ps_nonassoc_mgr__vt14 @ 0x8d7434, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ps_nonassoc_mgr__vt14,"ax",@progbits
	.global ps_nonassoc_mgr__vt14
ps_nonassoc_mgr__vt14:
L_8d7434:
	add_s r0,r0,0xc
L_8d7436:
	ld_s r1,[r0,0x2c]
L_8d7438:
	ld_s r1,[r1,0xc]
L_8d743a:
	j_s [r1]
