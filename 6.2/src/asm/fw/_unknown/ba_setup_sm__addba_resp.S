/* ba_setup_sm__addba_resp @ 0x8f0a44, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_16
 * Зовёт сам: __ld_r13_to_r13_ret, u_schd__cancel, u_schd__schedule
 * Глобалы (через gp): 0x800448
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__addba_resp
ba_setup_sm__addba_resp:
	.global L_8f0a44
L_8f0a44:
	push_s blink
L_8f0a46:
	push_s r13
L_8f0a48:
	ld_s r0,[gp,-0x4c]
L_8f0a4a:
	mov_s r13,0x0
L_8f0a4c:
	breq_s r0,0,L_8f0a56
L_8f0a4e:
	bl L_8c8de0
L_8f0a52:
	st.as r13,[gp,-0x13]
	.global L_8f0a56
L_8f0a56:
	mov_s r0,0x22078
L_8f0a5c:
	ld.as r4,[gp,0xb1]
L_8f0a60:
	mov_s r1,0x0
L_8f0a62:
	mov_s r2,r1
L_8f0a64:
	mov_s r3,r1
L_8f0a66:
	mov_s r5,r1
L_8f0a68:
	bl.d L_8e0c0c
L_8f0a6c:
	mov_s r6,r1
L_8f0a6e:
	b.d L_8c025c
L_8f0a72:
	st.as r0,[gp,-0x13]
L_8f0a76:
	nop_s
