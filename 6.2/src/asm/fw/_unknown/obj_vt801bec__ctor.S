/* obj_vt801bec__ctor @ 0x8d8e34, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_nonassoc_mgr__vt04
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__bind_descriptor
 * Глобалы (через gp): 0x800424
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt801bec__ctor
obj_vt801bec__ctor:
	.global L_8d8e34
L_8d8e34:
	push_s blink
L_8d8e36:
	push_s r13
L_8d8e38:
	mov_s r1,0x801bec
L_8d8e3e:
	bl.d L_8d94e0
L_8d8e42:
	mov_s r13,r0
L_8d8e44:
	ld_s r0,[gp,0x2a0]
L_8d8e46:
	mov_s r1,0x0
L_8d8e48:
	st.as r1,[gp,-0x18]
L_8d8e4c:
	breq_s r0,0,L_8d8e54
L_8d8e4e:
	mov_s r0,0x1
L_8d8e50:
	stb_s r0,[r13,0x3]
L_8d8e52:
	b_s L_8d8e56
	.global L_8d8e54
L_8d8e54:
	stb_s r1,[r13,0x3]
	.global L_8d8e56
L_8d8e56:
	b L_8c025c
L_8d8e5a:
	nop_s
