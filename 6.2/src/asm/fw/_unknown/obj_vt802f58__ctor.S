/* obj_vt802f58__ctor @ 0x8d8dc0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: obj_vt802cc4__ctor
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__bind_descriptor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt802f58__ctor
obj_vt802f58__ctor:
	.global L_8d8dc0
L_8d8dc0:
	push_s blink
L_8d8dc2:
	bl L_8c01e4
L_8d8dc6:
	mov_s r14,r1
L_8d8dc8:
	mov_s r1,0x802f58
L_8d8dce:
	bl.d L_8d94e0
L_8d8dd2:
	mov_s r13,r0
L_8d8dd4:
	mov_s r0,0x0
L_8d8dd6:
	st_s r0,[r13,0x8]
L_8d8dd8:
	st_s r0,[r13,0xc]
L_8d8dda:
	st_s r14,[r13,0x10]
L_8d8ddc:
	b.d L_8c0254
L_8d8de0:
	stb r0,[r13, 0x3d]
