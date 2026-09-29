/* ps_assoc_mgr__vt0c @ 0x8dd210, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.ps_assoc_mgr__vt0c,"ax",@progbits
	.global ps_assoc_mgr__vt0c
ps_assoc_mgr__vt0c:
L_8dd210:
	add_s r0,r0,0xc
L_8dd212:
	ld_s r1,[r0,0x2c]
L_8dd214:
	ld_s r1,[r1,0x4]
L_8dd216:
	j_s [r1]
