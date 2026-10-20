/* obj_vt801eac__ctor @ 0x8d8b6c, 40 байт.  Сгенерировано gen_asm_tree.py
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
	.global obj_vt801eac__ctor
obj_vt801eac__ctor:
	.global L_8d8b6c
L_8d8b6c:
	push_s blink
L_8d8b6e:
	bl L_8c01e4
L_8d8b72:
	mov_s r13,r0
L_8d8b74:
	st_s r1,[r0,0x10]
L_8d8b76:
	mov_s r14,0x0
L_8d8b78:
	mov_s r1,0x801eac
L_8d8b7e:
	bl.d L_8d94e0
L_8d8b82:
	st_s r14,[r0,0x8]
L_8d8b84:
	ld_s r0,[gp,0x2a0]
L_8d8b86:
	breq_s r0,0,L_8d8b8e
L_8d8b88:
	mov_s r0,0x1
L_8d8b8a:
	stb_s r0,[r13,0x3]
L_8d8b8c:
	b_s L_8d8b90
	.global L_8d8b8e
L_8d8b8e:
	stb_s r14,[r13,0x3]
	.global L_8d8b90
L_8d8b90:
	b L_8c0254
