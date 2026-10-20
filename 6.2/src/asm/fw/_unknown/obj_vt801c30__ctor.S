/* obj_vt801c30__ctor @ 0x8d8d08, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_assoc_mgr__vt04
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__bind_descriptor
 * Глобалы (через gp): 0x800424
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt801c30__ctor
obj_vt801c30__ctor:
	.global L_8d8d08
L_8d8d08:
	push_s blink
L_8d8d0a:
	push_s r13
L_8d8d0c:
	mov_s r1,0x801c30
L_8d8d12:
	bl.d L_8d94e0
L_8d8d16:
	mov_s r13,r0
L_8d8d18:
	ld_s r0,[gp,0x2a0]
L_8d8d1a:
	mov_s r1,0x0
L_8d8d1c:
	st.as r1,[gp,-0x17]
L_8d8d20:
	breq_s r0,0,L_8d8d28
L_8d8d22:
	mov_s r0,0x1
L_8d8d24:
	stb_s r0,[r13,0x3]
L_8d8d26:
	b_s L_8d8d2a
	.global L_8d8d28
L_8d8d28:
	stb_s r1,[r13,0x3]
	.global L_8d8d2a
L_8d8d2a:
	b L_8c025c
L_8d8d2e:
	nop_s
