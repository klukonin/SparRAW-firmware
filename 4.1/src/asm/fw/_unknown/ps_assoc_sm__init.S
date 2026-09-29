/* ps_assoc_sm__init @ 0x8d5ad4, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_assoc_mgr__vt04
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__setup
 * Глобалы (через gp): 0x800198, 0x80040c
 */
	.section .text.ps_assoc_sm__init,"ax",@progbits
	.global ps_assoc_sm__init
ps_assoc_sm__init:
	.global L_8d5ad4
L_8d5ad4:
	push_s blink
L_8d5ad6:
	bl.d L_8c02c4
L_8d5ada:
	mov r6,0x5
L_8d5ade:
	mov_s r13,r0
L_8d5ae0:
	mov r4,0x800a24
L_8d5ae8:
	mov r5,0x800a38
L_8d5af0:
	ld.as r1,[gp,0xa]
L_8d5af4:
	mov_s r14,0x0
L_8d5af6:
	mov_s r2,r14
L_8d5af8:
	mov_s r3,0x801900
L_8d5afe:
	bl.d L_8d6478
L_8d5b02:
	mov r7,0x4
L_8d5b06:
	ld_s r0,[gp,0x29c]
L_8d5b08:
	st.as r14,[gp,-0x14]
L_8d5b0c:
	breq_s r0,0,L_8d5b14
L_8d5b0e:
	mov_s r0,0x1
L_8d5b10:
	st_s r0,[r13,0x28]
L_8d5b12:
	b_s L_8d5b16
	.global L_8d5b14
L_8d5b14:
	st_s r14,[r13,0x28]
	.global L_8d5b16
L_8d5b16:
	b L_8c0334
L_8d5b1a:
	nop_s
