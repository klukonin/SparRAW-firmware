/* obj_vt801d64__ctor @ 0x8d8b94, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__assoc_ntf
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__bind_descriptor
 * Глобалы (через gp): 0x800424
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj_vt801d64__ctor
obj_vt801d64__ctor:
	.global L_8d8b94
L_8d8b94:
	push_s blink
L_8d8b96:
	bl L_8c01e0
L_8d8b9a:
	mov_s r13,r0
L_8d8b9c:
	mov_s r14,r1
L_8d8b9e:
	mov_s r1,0x801d64
L_8d8ba4:
	bl.d L_8d94e0
L_8d8ba8:
	mov_s r15,r2
L_8d8baa:
	st_s r14,[r13,0x8]
L_8d8bac:
	stw_s r15,[r13,0xc]
L_8d8bae:
	ld_s r0,[gp,0x2a0]
L_8d8bb0:
	cmp_s r0,0x0
L_8d8bb2:
	mov_s r0,0x0
L_8d8bb4:
	mov.ne r0,0x1
L_8d8bb8:
	b.d L_8c024c
L_8d8bbc:
	stb_s r0,[r13,0x3]
L_8d8bbe:
	nop_s
