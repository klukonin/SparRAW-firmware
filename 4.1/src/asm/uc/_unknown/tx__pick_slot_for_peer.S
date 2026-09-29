/* tx__pick_slot_for_peer @ 0x924db8, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager_rx_step, internal_tx_step, tx_initiator_rx_step, tx_initiator_step
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, brp__slot_has_peer_bit
 */
	.section .text.tx__pick_slot_for_peer,"ax",@progbits
	.global tx__pick_slot_for_peer
tx__pick_slot_for_peer:
	.global L_924db8
L_924db8:
	push_s blink
L_924dba:
	bl L_920210
L_924dbe:
	mov_s r15,r0
L_924dc0:
	mov_s r0,r1
L_924dc2:
	mov_s r13,0x800ac8
L_924dc8:
	ld_s r1,[r13,0x10]
L_924dca:
	sub_s sp,sp,0x4
L_924dcc:
	breq r1,0x0,L_924e64
L_924dd0:
	bl.d L_925e70
L_924dd4:
	mov_s r1,r2
L_924dd6:
	mov_s r14,r0
L_924dd8:
	mov_s r1,0x801458
L_924dde:
	add2_s r13,r13,r0
L_924de0:
	breq_s r15,0,L_924dfc
L_924de2:
	ldb_s r0,[r13,0x2]
L_924de4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_924de6:
	extb_s r0,r0
L_924de8:
	stb_s r0,[r13,0x2]
L_924dea:
	ldb_s r2,[r13,0x1]
L_924dec:
	min r0,r2,r0
L_924df0:
	extb_s r2,r0
L_924df2:
	stb_s r0,[r13,0x2]
L_924df4:
	ld_s r0,[r1,0x30]
L_924df6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_924df8:
	st_s r0,[r1,0x30]
L_924dfa:
	b_s L_924e06
	.global L_924dfc
L_924dfc:
	ldb_s r2,[r13]
L_924dfe:
	ld_s r0,[r1,0x34]
L_924e00:
	stb_s r2,[r13,0x2]
L_924e02:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_924e04:
	st_s r0,[r1,0x34]
	.global L_924e06
L_924e06:
	mov_s r1,0x0
L_924e08:
	bset r1,r1,r2
L_924e0c:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_924e0e:
	add r0,r14,0x9
L_924e12:
	asl_s r0,r0,0x18
L_924e14:
	or_s r0,r0,r1
L_924e16:
	mov_s r32,r0
L_924e18:
	st.ab r0,[r25,0x4]
L_924e1c:
	bclr r25,r25,0xa
L_924e20:
	mov_s r0,0x800dd0
L_924e26:
	ld_s r0,[r0]
L_924e28:
	add_s r14,r14,sp
L_924e2a:
	st_s r0,[sp,0x0]
L_924e2c:
	mov_s r0,0x2
L_924e2e:
	stb_s r0,[r14]
L_924e30:
	ldb_s r0,[sp,0x0]
L_924e32:
	ldb r1,[sp, 0x1]
L_924e36:
	bset_s r0,r0,0x1b
L_924e38:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_924e3a:
	or_s r0,r0,r1
L_924e3c:
	ldb r1,[sp, 0x2]
L_924e40:
	mov_s r2,0x800994
L_924e46:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_924e48:
	or_s r1,r1,r0
L_924e4a:
	ldb r0,[sp, 0x3]
L_924e4e:
	ld_s r2,[r2,0x8]
L_924e50:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_924e52:
	or_s r1,r1,r0
L_924e54:
	ld_s r0,[gp,-0xd8]
L_924e56:
	and_s r0,r0,r2
L_924e58:
	or_s r1,r1,r0
L_924e5a:
	mov_s r32,r1
L_924e5c:
	st.ab r1,[r25,0x4]
L_924e60:
	bclr r25,r25,0xa
	.global L_924e64
L_924e64:
	b.d L_92027c
L_924e68:
	add_s sp,sp,0x4
L_924e6a:
	nop_s
