/* ps_nonassoc_mgr__vt18 @ 0x8d745c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ps_nonassoc_mgr__vt18,"ax",@progbits
	.global ps_nonassoc_mgr__vt18
ps_nonassoc_mgr__vt18:
L_8d745c:
	add_s r0,r0,0xc
L_8d745e:
	ld_s r1,[r0,0x2c]
L_8d7460:
	ld_s r1,[r1,0x10]
L_8d7462:
	j_s [r1]
