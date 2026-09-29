/* obj_vt802da0__ctor @ 0x8d8b30, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_if__set_cid
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__bind_descriptor, obj_vt802cc4__ctor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt802da0__ctor
obj_vt802da0__ctor:
	.global L_8d8b30
L_8d8b30:
	push_s blink
L_8d8b32:
	bl L_8c01e4
L_8d8b36:
	mov_s r14,r1
L_8d8b38:
	mov_s r1,0x802da0
L_8d8b3e:
	bl.d L_8d94e0
L_8d8b42:
	mov_s r13,r0
L_8d8b44:
	st_s r14,[r13,0x8]
L_8d8b46:
	add r0,r13,0x10
L_8d8b4a:
	bl.d L_8f52bc
L_8d8b4e:
	mov_s r1,r13
L_8d8b50:
	mov_s r0,0x0
L_8d8b52:
	st_s r0,[r13,0xc]
L_8d8b54:
	st r0,[r13, 0x9c]
L_8d8b58:
	mov r0,-0x2
L_8d8b5c:
	stb r0,[r13, 0xa0]
L_8d8b60:
	mov r0,-0x5
L_8d8b64:
	b.d L_8c0254
L_8d8b68:
	stb r0,[r13, 0xa1]
