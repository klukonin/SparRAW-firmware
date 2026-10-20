/* ps_nonassoc_sm__init @ 0x8d5c7c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_nonassoc_mgr__vt04
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__setup
 * Глобалы (через gp): 0x800194, 0x80040c
 */
	.section .text.ps_nonassoc_sm__init,"ax",@progbits
	.global ps_nonassoc_sm__init
ps_nonassoc_sm__init:
	.global L_8d5c7c
L_8d5c7c:
	push_s blink
L_8d5c7e:
	bl.d L_8c02c4
L_8d5c82:
	mov r6,0x3
L_8d5c86:
	mov_s r13,r0
L_8d5c88:
	mov r4,0x800a0c
L_8d5c90:
	mov r5,0x800a18
L_8d5c98:
	ld.as r1,[gp,0x9]
L_8d5c9c:
	mov_s r14,0x0
L_8d5c9e:
	mov_s r2,r14
L_8d5ca0:
	mov_s r3,0x8018d0
L_8d5ca6:
	bl.d L_8d6478
L_8d5caa:
	mov r7,r6
L_8d5cae:
	ld_s r0,[gp,0x29c]
L_8d5cb0:
	st.as r14,[gp,-0x15]
L_8d5cb4:
	breq_s r0,0,L_8d5cbc
L_8d5cb6:
	mov_s r0,0x1
L_8d5cb8:
	st_s r0,[r13,0x28]
L_8d5cba:
	b_s L_8d5cbe
	.global L_8d5cbc
L_8d5cbc:
	st_s r14,[r13,0x28]
	.global L_8d5cbe
L_8d5cbe:
	b L_8c0334
L_8d5cc2:
	nop_s
