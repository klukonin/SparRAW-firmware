/* bf_substate__txss_by_slot @ 0x935e84, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_substate__dispatch_by_state
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_sm__reset_slot_table, set_g_800fa8_minus20, txss__flow_body
 */
	.section .text.bf_substate__txss_by_slot,"ax",@progbits
	.global bf_substate__txss_by_slot
bf_substate__txss_by_slot:
	.global L_935e84
L_935e84:
	push_s blink
L_935e86:
	bl L_920214
L_935e8a:
	mov_s r13,r0
L_935e8c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_935e8e:
	add1_s r0,r0,r0
L_935e90:
	add r14,r0,0x800ef4
L_935e98:
	ld_s r0,[r14,0x4]
L_935e9a:
	breq_s r0,0,L_935ea4
L_935e9c:
	breq r0,0x5,L_935eb4
L_935ea0:
	mov_s r13,0x2
L_935ea2:
	b_s L_935eb6
	.global L_935ea4
L_935ea4:
	bl L_92b668
L_935ea8:
	ldb_s r1,[r14,0x9]
L_935eaa:
	bl.d L_9361d4
L_935eae:
	mov_s r0,r13
L_935eb0:
	mov_s r13,0x0
L_935eb2:
	b_s L_935eb6
	.global L_935eb4
L_935eb4:
	mov_s r13,0x1
	.global L_935eb6
L_935eb6:
	cmp_s r13,0x0
L_935eb8:
	bl.ne L_928380
L_935ebc:
	b.d L_920284
L_935ec0:
	mov_s r0,r13
L_935ec2:
	nop_s
