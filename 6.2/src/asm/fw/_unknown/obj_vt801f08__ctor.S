/* obj_vt801f08__ctor @ 0x8d8c50, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: psc_if__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__bind_descriptor
 * Глобалы (через gp): 0x800424
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt801f08__ctor
obj_vt801f08__ctor:
	.global L_8d8c50
L_8d8c50:
	push_s blink
L_8d8c52:
	bl L_8c01e4
L_8d8c56:
	mov_s r13,r0
L_8d8c58:
	st_s r1,[r0,0x14]
L_8d8c5a:
	mov_s r14,0x0
L_8d8c5c:
	stb_s r14,[r0,0x10]
L_8d8c5e:
	st_s r14,[r0,0x8]
L_8d8c60:
	mov_s r1,0x801f08
L_8d8c66:
	bl.d L_8d94e0
L_8d8c6a:
	st_s r14,[r0,0xc]
L_8d8c6c:
	ld_s r0,[gp,0x2a0]
L_8d8c6e:
	breq_s r0,0,L_8d8c76
L_8d8c70:
	mov_s r0,0x1
L_8d8c72:
	stb_s r0,[r13,0x3]
L_8d8c74:
	b_s L_8d8c78
	.global L_8d8c76
L_8d8c76:
	stb_s r14,[r13,0x3]
	.global L_8d8c78
L_8d8c78:
	b L_8c0254
