/* obj__set_vtable_800828 @ 0x8e8158, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.obj__set_vtable_800828,"ax",@progbits
	.global obj__set_vtable_800828
obj__set_vtable_800828:
L_8e8158:
	pop_s r13
	.global sub_8e815a
sub_8e815a:
L_8e815a:
	nop_s
L_8e815c:
	mov_s r1,0x800828
L_8e8162:
	j_s.d [blink]
L_8e8164:
	st r1,[r0, 0xd4]
