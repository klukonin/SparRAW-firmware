/* obj__set_vtable_80058c @ 0x8c1798, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: frag_8c1774
 */
	.section .text.obj__set_vtable_80058c,"ax",@progbits
	.global obj__set_vtable_80058c
obj__set_vtable_80058c:
	.global L_8c1798
L_8c1798:
	mov_s r1,0x0
L_8c179a:
	st_s r1,[r0,0x4]
L_8c179c:
	st_s r1,[r0,0x8]
L_8c179e:
	st_s r1,[r0,0xc]
L_8c17a0:
	mov_s r1,0x80058c
L_8c17a6:
	j_s.d [blink]
L_8c17a8:
	st_s r1,[r0]
L_8c17aa:
	nop_s
