/* u_schd__enqueue_ready @ 0x8e0bcc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__add, u_schd__pop_expired
 * Зовёт сам: __ld_r13_to_r13_ret, list__find_entry_d
 * Глобалы (через gp): 0x80019c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__enqueue_ready
u_schd__enqueue_ready:
	.global L_8e0bcc
L_8e0bcc:
	push_s blink
L_8e0bce:
	push_s r13
L_8e0bd0:
	mov_s r4,r0
L_8e0bd2:
	lr r13,[0xa]
L_8e0bd6:
	bclr r0,r13,0x1
L_8e0bda:
	flag r0
L_8e0bde:
	ld_s r0,[gp,0x18]
L_8e0be0:
	bic r13,r13,-0x3
L_8e0be4:
	bset r0,r0,r1
L_8e0be8:
	st.as r0,[gp,0x6]
L_8e0bec:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8e0bee:
	add1_s r1,r1,r1
L_8e0bf0:
	add r0,r1,0x803c5c
L_8e0bf8:
	bl.d L_8c25f4
L_8e0bfc:
	mov_s r1,r4
L_8e0bfe:
	lr r0,[0xa]
L_8e0c02:
	or_s r13,r13,r0
L_8e0c04:
	flag r13
L_8e0c08:
	b L_8c025c
