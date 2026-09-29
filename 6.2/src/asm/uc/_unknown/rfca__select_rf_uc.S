/* rfca__select_rf_uc @ 0x928b8c, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: brp__init_ctx, brp__iterate_rf_mask, brp__read_rf_id, brp__rf_module_done, brp_init__flow, brp_init__tx_request, brp_initiator_brp_transaction_flow, brp_initiator_flow_successful_receive_training, brp_responder_flow_enter, brp_responder_transmission_flow
 * Зовёт сам: uc_log__emit_snapshot, uc_sysassert
 * Глобалы (через gp): 0x8006a0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rfca__select_rf_uc
rfca__select_rf_uc:
	.global L_928b8c
L_928b8c:
	st.a r13,[sp,-0x10]
L_928b90:
	st blink,[sp, 0x4]
L_928b94:
	st_s r14,[sp,0x8]
L_928b96:
	st_s r15,[sp,0xc]
L_928b98:
	mov_s r15,r0
L_928b9a:
	ld.as r2,[gp,-0x11]
L_928b9e:
	mov_s r14,r1
L_928ba0:
	and r2,r2,0xfff0ffff
L_928ba8:
	or r8,r2,0x30000
L_928bb0:
	st.as r8,[gp,-0x11]
L_928bb4:
	or r2,r2,0x1d030000
L_928bbc:
	mov r32,r2
L_928bc0:
	st.ab r2,[r25,0x4]
L_928bc4:
	bclr r25,r25,0xa
L_928bc8:
	nop_s
L_928bca:
	nop_s
L_928bcc:
	mov 0x0,0x0
	.global L_928bd0
L_928bd0:
	mov r5,r47
L_928bd4:
	bbit1 r5,0x11,L_928bd0
L_928bd8:
	mov_s r13,0x889800
L_928bde:
	ld.as r3,[r13,-0xde]
L_928be2:
	lsr_s r3,r3,0x8
L_928be4:
	breq.d r14,0x0,L_928bf0
L_928be8:
	extb r10,r3
L_928bec:
	stb r3,[r14]
	.global L_928bf0
L_928bf0:
	breq r15,r10,L_928c58
L_928bf4:
	mov lp_count,0x30d40
L_928bfc:
	mov r9,0x889000
L_928c04:
	lp L_928c18
L_928c08:
	ld r6,[r9, 0xcc]
L_928c0c:
	btst r6,0x1d
L_928c10:
	beq_s L_928c18
L_928c12:
	nop_s
L_928c14:
	mov 0x0,0x0
	.global L_928c18
L_928c18:
	ld r7,[r9, 0xcc]
L_928c1c:
	bbit0 r7,0x1d,L_928c3c
L_928c20:
	mov r1,0x1002f00
L_928c28:
	bl.d L_92d13c
L_928c2c:
	mov r0,0x0
L_928c30:
	mov_s r0,blink
L_928c32:
	mov_s r1,0x136e
L_928c38:
	bl L_926618
	.global L_928c3c
L_928c3c:
	ld.as r4,[r13,-0xde]
L_928c40:
	asl r15,r15,0x8
L_928c44:
	and r4,r4,0xffff00ff
L_928c4c:
	or r15,r15,r4
L_928c50:
	st.as r15,[gp,0x5e]
L_928c54:
	st.as r15,[r13,-0xde]
	.global L_928c58
L_928c58:
	ld blink,[sp, 0x4]
L_928c5c:
	ld_s r14,[sp,0x8]
L_928c5e:
	ld_s r15,[sp,0xc]
L_928c60:
	j.d [blink]
L_928c64:
	ld.ab r13,[sp,0x10]
