/* tx_initiator_rx_step @ 0x934c08, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_initiator_step
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, mac_counter__program_0008, rx_flow__run, sxd_hal__wait_slot2_busy2, tx__pick_slot_for_peer
 * Глобалы (через gp): 0x800608
 */
	.section .text.tx_initiator_rx_step,"ax",@progbits
	.global tx_initiator_rx_step
tx_initiator_rx_step:
	.global L_934c08
L_934c08:
	push_s blink
L_934c0a:
	bl L_920210
L_934c0e:
	mov_s r14,r0
L_934c10:
	ld_s r0,[gp,0xe0]
L_934c12:
	mov_s r15,r1
L_934c14:
	bmsk.f 0x0,r0,0x4
L_934c18:
	mov_s r13,0x1
L_934c1a:
	beq_s L_934cd4
L_934c1c:
	bl.d L_931dcc
L_934c20:
	ldw_s r0,[gp,-0x24]
L_934c22:
	breq r0,0x0,L_934cc0
L_934c26:
	bl L_92ce9c
L_934c2a:
	ld_s r0,[gp,0xe0]
L_934c2c:
	bbit1 r0,0x7,L_934c54
L_934c30:
	ld_s r1,[r14]
L_934c32:
	mov_s r0,0x0
L_934c34:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_934c36:
	add2_s r1,r1,r1
L_934c38:
	add r2,r1,0x857848
L_934c40:
	stb_s r0,[r2]
L_934c42:
	stb_s r13,[r15]
L_934c44:
	mov_s r2,0x80090c
L_934c4a:
	ldw_s r1,[r2,0x28]
L_934c4c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_934c4e:
	extw_s r1,r1
L_934c50:
	stw_s r1,[r2,0x28]
L_934c52:
	b_s L_934cbc
	.global L_934c54
L_934c54:
	bclr r1,r0,0x8
L_934c58:
	st.as r1,[gp,0x38]
L_934c5c:
	bbit0 r1,0x2,L_934c80
	.global L_934c60
L_934c60:
	ldb_s r1,[r14]
L_934c62:
	mov_s r0,0x1
L_934c64:
	bl.d L_924db8
L_934c68:
	ldb_s r2,[r14,0x4]
L_934c6a:
	ld_s r1,[r14]
L_934c6c:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_934c6e:
	add2_s r1,r1,r1
L_934c70:
	add_s r1,r1,0x857838
L_934c76:
	ldb_s r0,[r1,0x10]
L_934c78:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934c7a:
	stb_s r0,[r1,0x10]
L_934c7c:
	mov_s r0,0x1
L_934c7e:
	b_s L_934cbc
	.global L_934c80
L_934c80:
	bic.f r0,r0,-0x6
L_934c84:
	beq_s L_934cba
L_934c86:
	ld_s r0,[r14]
L_934c88:
	mov_s r2,0x0
L_934c8a:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_934c8c:
	add2_s r0,r0,r0
L_934c8e:
	add r1,r0,0x857848
L_934c96:
	stb_s r2,[r1]
L_934c98:
	ldb_s r1,[r14]
L_934c9a:
	mov_s r0,0x0
L_934c9c:
	bl.d L_924db8
L_934ca0:
	ldb_s r2,[r14,0x4]
L_934ca2:
	mov_s r1,0x80090c
L_934ca8:
	ldw_s r0,[r1,0x2a]
L_934caa:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934cac:
	extw_s r0,r0
L_934cae:
	stw_s r0,[r1,0x2a]
L_934cb0:
	b_s L_934cba
	.global L_934cb2
L_934cb2:
	mov_s r0,r14
L_934cb4:
	bl.d L_933f90
L_934cb8:
	mov_s r1,0x2
	.global L_934cba
L_934cba:
	mov_s r0,r13
	.global L_934cbc
L_934cbc:
	b L_92027c
	.global L_934cc0
L_934cc0:
	ld_s r0,[gp,0xe0]
L_934cc2:
	bclr_s r0,r0,0x8
L_934cc4:
	st.as r0,[gp,0x38]
L_934cc8:
	bbit1 r0,0x2,L_934c60
L_934ccc:
	ld_s r0,[r14,0xc]
L_934cce:
	bbit0 r0,0x1,L_934cba
L_934cd2:
	b_s L_934cb2
	.global L_934cd4
L_934cd4:
	bclr_s r0,r0,0x11
L_934cd6:
	st.as r0,[gp,0x38]
L_934cda:
	b_s L_934cba
