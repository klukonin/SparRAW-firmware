/* u_schd__insert_timer @ 0x8e0c74, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__schedule
 * Зовёт сам: __ld_r21_to_r13_ret, __st_r21_to_r13, fw_sysassert_fatal, list__find_entry, u_schd__alloc_task, u_schd__arm_timer, u_schd__fill_task_b, u_schd__timer_set_fields
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global u_schd__insert_timer
u_schd__insert_timer:
	.global L_8e0c74
L_8e0c74:
	push_s blink
L_8e0c76:
	bl L_8c01c8
L_8e0c7a:
	mov_s r14,r0
L_8e0c7c:
	mov_s r21,r1
L_8e0c7e:
	mov_s r20,r2
L_8e0c80:
	mov_s r19,r3
L_8e0c82:
	mov r18,r4
L_8e0c86:
	mov_s r13,r5
L_8e0c88:
	mov_s r15,r6
L_8e0c8a:
	bl.d L_8c32f8
L_8e0c8e:
	mov r16,r7
L_8e0c92:
	mov_s r17,r0
L_8e0c94:
	mov_s r1,r21
L_8e0c96:
	mov_s r2,r20
L_8e0c98:
	bl.d L_8e6f88
L_8e0c9c:
	mov_s r3,r19
L_8e0c9e:
	mov_s r0,r17
L_8e0ca0:
	mov_s r1,r13
L_8e0ca2:
	mov_s r2,r15
L_8e0ca4:
	mov_s r3,r16
L_8e0ca6:
	bl.d L_8e6114
L_8e0caa:
	mov r4,r18
L_8e0cae:
	mov_s r13,0x803c54
L_8e0cb4:
	add2_s r13,r13,r14
L_8e0cb6:
	ld_s r0,[r13]
L_8e0cb8:
	mov_s r2,0x291bc
L_8e0cbe:
	ld_s r14,[r0,0x4]
L_8e0cc0:
	bl.d L_8c2638
L_8e0cc4:
	mov_s r1,r17
L_8e0cc6:
	ld_s r0,[r13]
L_8e0cc8:
	ld_s r0,[r0,0x4]
L_8e0cca:
	breq r14,r0,L_8e0cd4
L_8e0cce:
	bl L_8e249c
L_8e0cd2:
	breq_s r0,0,L_8e0cda
	.global L_8e0cd4
L_8e0cd4:
	b.d L_8c021c
L_8e0cd8:
	mov_s r0,r17
	.global L_8e0cda
L_8e0cda:
	mov_s r0,blink
L_8e0cdc:
	mov_s r1,0x67
L_8e0cde:
	bl.d L_8c9b28
L_8e0ce2:
	bset_s r1,r1,0xc
L_8e0ce4:
	b_s L_8e0cd4
L_8e0ce6:
	nop_s
