/* rx_flow__lookup_mcs_ctx @ 0x92ee48, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow_step
 * Зовёт сам: rx_flow__check_ppdu_and_ctx
 * Глобалы (через gp): 0x800608
 */
	.section .text.rx_flow__lookup_mcs_ctx,"ax",@progbits
	.global rx_flow__lookup_mcs_ctx
rx_flow__lookup_mcs_ctx:
	.global L_92ee48
L_92ee48:
	st.a r13,[sp,-0xc]
L_92ee4c:
	ld.as r2,[gp,0x38]
L_92ee50:
	st_s r14,[sp,0x8]
L_92ee52:
	btst_s r2,0x8
L_92ee54:
	st blink,[sp, 0x4]
L_92ee58:
	beq.d L_92f11c
L_92ee5c:
	mov_s r13,0x0
L_92ee5e:
	lsr r2,r38,0x14
L_92ee62:
	ld.as r1,[gp,0x38]
L_92ee66:
	bmsk_s r1,r1,0x4
L_92ee68:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_92ee6a:
	cmp_s r1,0xf
L_92ee6c:
	bhi.d L_92f11c
L_92ee70:
	bmsk r14,r2,0x4
L_92ee74:
	ld.as r0,[0x800c18,r1]
