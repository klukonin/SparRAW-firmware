/* ps_nonassoc_mgr__vt1c @ 0x8dd4f8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ps_nonassoc_mgr__vt1c,"ax",@progbits
	.global ps_nonassoc_mgr__vt1c
ps_nonassoc_mgr__vt1c:
L_8dd4f8:
	add_s r0,r0,0xc
L_8dd4fa:
	ld_s r1,[r0,0x2c]
L_8dd4fc:
	ld_s r1,[r1,0x14]
L_8dd4fe:
	j_s [r1]
