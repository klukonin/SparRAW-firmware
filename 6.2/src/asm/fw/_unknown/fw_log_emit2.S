/* fw_log_emit2 @ 0x8dcc80, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: BUILDER_push_dmg_parameters, CALIB_MNGR__system_state_evt_handler, PS_CONNECTION__assoc_ntf, STREAM_MGR, STREAM_MGR__ADD, SW_TX_MGMT_API__link_up_evt, TX_API__post_tx_payload, TX_API__send_dband_bcon, UT_HW_FLOWS_OPERATIONAL_cmd_handler, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_log_emit2
fw_log_emit2:
	.global L_8dcc80
L_8dcc80:
	push_s blink
L_8dcc82:
	bl L_8c01e0
L_8dcc86:
	mov_s r13,r1
L_8dcc88:
	bmsk r1,r0,0x3
L_8dcc8c:
	lsr_s r0,r0,0x4
L_8dcc8e:
	mov_s r14,0x843900
L_8dcc94:
	add_s r15,r14,0x4
L_8dcc96:
	ldb_s r1,[r15,r1]
L_8dcc98:
	bmsk_s r0,r0,0x1
L_8dcc9a:
	sub_s sp,sp,0x8
L_8dcc9c:
	bbit0 r1,r0,L_8dccf8
L_8dcca0:
	ld_s r0,[r14]
L_8dcca2:
	bmsk_s r13,r13,0x13
L_8dcca4:
	add_s r1,r0,0x3
L_8dcca6:
	bmsk_s r1,r1,0x9
L_8dcca8:
	add2 r1,r14,r1
L_8dccac:
	st_s r3,[r1,0x14]
L_8dccae:
	/* add_s r0,0x2 */
	.byte 0x02,0xe0
L_8dccb0:
	bmsk_s r0,r0,0x9
L_8dccb2:
	add2 r0,r14,r0
L_8dccb6:
	st_s r2,[r0,0x14]
L_8dccb8:
	mov_s r1,sp
L_8dccba:
	mov_s r0,0x0
L_8dccbc:
	bl.d L_8e9900
L_8dccc0:
	mov_s r2,r0
L_8dccc2:
	ld_s r1,[sp,0x4]
L_8dccc4:
	mov_s r0,0xff
L_8dccc6:
	cmp_s r1,r0
L_8dccc8:
	mov.cc r2,r0
L_8dcccc:
	ld_s r0,[r14]
L_8dccce:
	mov.cs r2,r1
L_8dccd2:
	add_s r1,r0,0x1
L_8dccd4:
	bmsk_s r1,r1,0x9
L_8dccd6:
	ld_s r3,[sp,0x0]
L_8dccd8:
	add2 r1,r14,r1
L_8dccdc:
	st_s r3,[r1,0x14]
L_8dccde:
	bset_s r13,r13,0x1b
L_8dcce0:
	bset_s r13,r13,0x1d
L_8dcce2:
	bset_s r13,r13,0x1f
L_8dcce4:
	extb_s r2,r2
L_8dcce6:
	asl_s r2,r2,0x12
L_8dcce8:
	or_s r13,r13,r2
L_8dccea:
	bmsk r1,r0,0x9
L_8dccee:
	add2 r1,r14,r1
L_8dccf2:
	st_s r13,[r1,0x14]
L_8dccf4:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8dccf6:
	st_s r0,[r14]
	.global L_8dccf8
L_8dccf8:
	b.d L_8c024c
L_8dccfc:
	add_s sp,sp,0x8
L_8dccfe:
	nop_s
