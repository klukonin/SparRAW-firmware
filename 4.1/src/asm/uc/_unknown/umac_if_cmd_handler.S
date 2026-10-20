/* umac_if_cmd_handler @ 0x936dd0, 644 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   umac_if_cmd_handler FW command 0x%x
 *   umac_if_cmd_handler.cpp
 * Зовут его: uc_mailbox__dispatch_one
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, bf__abort_to_state11, bf_pending__set_bit, bi_ap_mon__window_code, get_selected_rf_sector_index_cmd_handler, internal_tx__clear_pending, psc_pending_agreement_cmd, set_g_801b18_x4, set_selected_rf_sector_index_cmd_handler, traffic_deferral_cfg_cmd_handler, txrx_umac_if_long_range_cmd_handler
 * Глобалы (через gp): 0x8005d0, 0x8005d2, 0x8005dc, 0x8005e0, 0x8005ec, 0x8005f0
 */
	.section .text.umac_if_cmd_handler,"ax",@progbits
	.global umac_if_cmd_handler
umac_if_cmd_handler:
	.global L_936dd0
L_936dd0:
	push_s blink
L_936dd2:
	bl L_92020c
L_936dd6:
	mov_s r14,r0
L_936dd8:
	ldw_s r0,[r0,0x4]
L_936dda:
	mov_s r13,r1
L_936ddc:
	or r0,r0,0xcd0000
L_936de4:
	mov_s r32,r0
L_936de6:
	st.ab r0,[r25,0x4]
L_936dea:
	bclr r25,r25,0xa
L_936dee:
	mov_s r2,0x80209c
L_936df4:
	ldb_s r0,[r2,0x4]
L_936df6:
	mov r4,0x1001374
L_936dfe:
	ldw_s r1,[r14,0x4]
L_936e00:
	bbit0 r0,0x2,L_936e2c
L_936e04:
	ld_s r0,[r2]
L_936e06:
	mov_s r3,0x8020b0
L_936e0c:
	add_s r15,r0,0x1
L_936e0e:
	extb_s r15,r15
L_936e10:
	add2 r15,r3,r15
L_936e14:
	st_s r1,[r15]
L_936e16:
	bmsk r1,r4,0x13
L_936e1a:
	or r1,r1,0xa6000000
L_936e22:
	extb_s r15,r0
L_936e24:
	add2_s r3,r3,r15
L_936e26:
	st_s r1,[r3]
L_936e28:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_936e2a:
	st_s r0,[r2]
	.global L_936e2c
L_936e2c:
	mov_s r15,0x8009cc
L_936e32:
	ld_s r0,[r15,0x1c]
L_936e34:
	brne_s r0,0,L_936e46
L_936e36:
	mov_s r0,0x800fcc
L_936e3c:
	ldb r0,[r0, 0x68]
L_936e40:
	cmp_s r0,0x0
L_936e42:
	bl.ne L_926490
	.global L_936e46
L_936e46:
	ldw_s r1,[r14,0x4]
L_936e48:
	cmp_s r1,0x41
L_936e4a:
	bhi L_937040
L_936e4e:
	ldb r1,[0x800c68,r1]
L_936e56:
	add r0,pcl,0xa
L_936e5a:
	add1_s r0,r0,r1
L_936e5c:
	j_s [r0]
L_936e5e:
	bl.d L_934f68
L_936e62:
	mov_s r0,r13
L_936e64:
	b L_937050
L_936e68:
	bl.d L_935068
L_936e6c:
	mov_s r0,r13
L_936e6e:
	b L_937050
L_936e72:
	bl.d L_934de4
L_936e76:
	mov_s r0,r13
L_936e78:
	b L_937050
L_936e7c:
	bl.d L_9259d8
L_936e80:
	mov_s r0,r13
L_936e82:
	b L_937050
L_936e86:
	bl.d L_93504c
L_936e8a:
	mov_s r0,r13
L_936e8c:
	b L_937050
L_936e90:
	bl.d L_935410
L_936e94:
	mov_s r0,r13
L_936e96:
	b L_937050
L_936e9a:
	bl.d L_935208
L_936e9e:
	mov_s r0,r13
L_936ea0:
	b_s L_937050
L_936ea2:
	bl.d L_9353a4
L_936ea6:
	mov_s r0,r13
L_936ea8:
	b_s L_937050
L_936eaa:
	mov_s r0,blink
L_936eac:
	mov_s r2,0x1001398
L_936eb2:
	mov_s r1,0xa3
L_936eb4:
	mov_s r3,0x90
L_936eb6:
	b_s L_93704c
L_936eb8:
	bl.d L_935438
L_936ebc:
	mov_s r0,r13
L_936ebe:
	b_s L_937050
L_936ec0:
	bl.d L_9354d4
L_936ec4:
	mov_s r0,r13
L_936ec6:
	b_s L_937050
L_936ec8:
	bl.d L_922268
L_936ecc:
	mov_s r0,r13
L_936ece:
	b_s L_937050
L_936ed0:
	bl.d L_932f8c
L_936ed4:
	mov_s r0,r13
L_936ed6:
	b_s L_937050
L_936ed8:
	bl.d L_935ed4
L_936edc:
	mov_s r0,r13
L_936ede:
	b_s L_937050
L_936ee0:
	ldw_s r0,[r13,0x4]
L_936ee2:
	mov_s r1,0x800fcc
L_936ee8:
	ld_s r14,[r13]
L_936eea:
	breq_s r0,0,L_936f2a
L_936eec:
	ldb r0,[r1, 0x68]
L_936ef0:
	brne_s r0,0,L_936f00
L_936ef2:
	mov_s r3,0x0
L_936ef4:
	mov_s r2,0x0
L_936ef6:
	mov_s r0,0x8009c0
L_936efc:
	st_s r3,[r0]
L_936efe:
	st_s r2,[r0,0x4]
	.global L_936f00
L_936f00:
	ldb r0,[r1, 0x68]
L_936f04:
	bset r0,r0,r14
L_936f08:
	stb r0,[r1, 0x68]
L_936f0c:
	bl.d L_92836c
L_936f10:
	mov_s r0,r14
L_936f12:
	ld_s r0,[gp,-0x84]
L_936f14:
	cmp_s r0,0x0
L_936f16:
	beq_s L_937050
L_936f18:
	ld_s r0,[r15,0x1c]
L_936f1a:
	cmp_s r0,0x0
L_936f1c:
	bne_s L_937050
L_936f1e:
	mov_s r0,0x801ed0
L_936f24:
	bl L_9283b8
L_936f28:
	b_s L_937050
	.global L_936f2a
L_936f2a:
	mov_s r13,0x0
L_936f2c:
	bset r13,r13,r14
L_936f30:
	ldb r0,[r1, 0x68]
L_936f34:
	not r16,r13
L_936f38:
	and r0,r0,r16
L_936f3c:
	stb r0,[r1, 0x68]
L_936f40:
	mov_s r15,0x800ef4
L_936f46:
	ld_s r0,[r15,0x6c]
L_936f48:
	tst_s r0,r13
L_936f4a:
	beq_s L_936f72
L_936f4c:
	bl.d L_924fd0
L_936f50:
	mov_s r0,r14
L_936f52:
	ld_s r0,[r15,0x78]
L_936f54:
	mov_s r1,0x800f64
L_936f5a:
	bmsk_s r0,r0,0x2
L_936f5c:
	ldb_s r0,[r1,r0]
L_936f5e:
	brne r14,r0,L_936f6a
L_936f62:
	bl.d L_921f58
L_936f66:
	mov_s r0,0x0
L_936f68:
	b_s L_936f72
	.global L_936f6a
L_936f6a:
	ldb_s r0,[gp,-0xf0]
L_936f6c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_936f6e:
	stb r0,[gp, -0xf0]
	.global L_936f72
L_936f72:
	bl.d L_933d78
L_936f76:
	mov_s r0,r14
L_936f78:
	ldw_s r0,[gp,0xaa]
L_936f7a:
	or_s r0,r0,r13
L_936f7c:
	stw.as r0,[gp,0x55]
L_936f80:
	ldw_s r0,[gp,0xa8]
L_936f82:
	and r0,r0,r16
L_936f86:
	stw.as r0,[gp,0x54]
L_936f8a:
	b_s L_937050
L_936f8c:
	bl.d L_922970
L_936f90:
	mov_s r0,r13
L_936f92:
	b_s L_937050
L_936f94:
	bl.d L_930294
L_936f98:
	mov_s r0,r13
L_936f9a:
	b_s L_937050
L_936f9c:
	bl.d L_92c434
L_936fa0:
	mov_s r0,r13
L_936fa2:
	b_s L_937050
L_936fa4:
	bl.d L_92becc
L_936fa8:
	mov_s r0,r13
L_936faa:
	b_s L_937050
L_936fac:
	ld_s r1,[r13]
L_936fae:
	ld_s r0,[r13,0x4]
L_936fb0:
	st.as r1,[gp,0x2d]
L_936fb4:
	st.as r0,[gp,0x2e]
L_936fb8:
	b_s L_937050
L_936fba:
	ld_s r1,[r13]
L_936fbc:
	ld_s r0,[r13,0x4]
L_936fbe:
	st.as r1,[gp,0x31]
L_936fc2:
	st.as r0,[gp,0x32]
L_936fc6:
	b_s L_937050
L_936fc8:
	bl.d L_930dd4
L_936fcc:
	mov_s r0,r13
L_936fce:
	b_s L_937050
L_936fd0:
	bl.d L_934dac
L_936fd4:
	mov_s r0,r13
L_936fd6:
	b_s L_937050
L_936fd8:
	bl.d L_92b250
L_936fdc:
	mov_s r0,r13
L_936fde:
	b_s L_937050
L_936fe0:
	bl.d L_937054
L_936fe4:
	mov_s r0,r13
L_936fe6:
	b_s L_937050
L_936fe8:
	bl.d L_92b19c
L_936fec:
	mov_s r0,r13
L_936fee:
	b_s L_937050
L_936ff0:
	bl.d L_93502c
L_936ff4:
	mov_s r0,r13
L_936ff6:
	b_s L_937050
L_936ff8:
	bl.d L_92b308
L_936ffc:
	mov_s r0,r13
L_936ffe:
	b_s L_937050
L_937000:
	bl.d L_921770
L_937004:
	mov_s r0,r13
L_937006:
	b_s L_937050
L_937008:
	bl.d L_9357e4
L_93700c:
	mov_s r0,r13
L_93700e:
	b_s L_937050
L_937010:
	bl.d L_9296c0
L_937014:
	mov_s r0,r13
L_937016:
	b_s L_937050
L_937018:
	bl.d L_932488
L_93701c:
	mov_s r0,r13
L_93701e:
	b_s L_937050
L_937020:
	bl.d L_92c188
L_937024:
	mov_s r0,r13
L_937026:
	b_s L_937050
L_937028:
	bl.d L_92639c
L_93702c:
	mov_s r0,r13
L_93702e:
	b_s L_937050
L_937030:
	bl.d L_930a40
L_937034:
	mov_s r0,r13
L_937036:
	b_s L_937050
L_937038:
	bl.d L_934fdc
L_93703c:
	mov_s r0,r13
L_93703e:
	b_s L_937050
	.global L_937040
L_937040:
	mov_s r0,blink
L_937042:
	mov_s r2,0x1001398
L_937048:
	mov_s r1,0xa4
L_93704a:
	mov_s r3,0xf6
	.global L_93704c
L_93704c:
	bl L_925548
	.global L_937050
L_937050:
	b L_920274
