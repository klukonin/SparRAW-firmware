/* tx_queue__config_by_mode @ 0x8f9fb0, 628 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_bringup__init_seq, sm_pring__all_wb_done_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set32_s0_w13, fw_sysassert_fatal, memset0_words, qdesc_cfg__get_flag_bit13, qdesc_cfg__get_flag_bit3, qdesc_cfg__get_w10_field, qdesc_cfg__get_w13_field, qdesc_cfg__get_w14_field, qdesc_cfg__get_w3_field_a, qdesc_cfg__get_w3_field_b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_queue__config_by_mode
tx_queue__config_by_mode:
	.global L_8f9fb0
L_8f9fb0:
	push_s blink
L_8f9fb2:
	bl L_8c01e0
L_8f9fb6:
	mov_s r14,r0
L_8f9fb8:
	mov_s r13,r1
L_8f9fba:
	bl.d L_8c1cd8
L_8f9fbe:
	mov_s r1,0x10
L_8f9fc0:
	/* sub_s r13,r13,0x4 */
	.byte 0x64,0xbd
L_8f9fc2:
	cmp_s r13,0x6
L_8f9fc4:
	bhi L_8fa214
L_8f9fc8:
	ldw.x.as r13,[0x8027f4,r13]
L_8f9fd0:
	add r0,pcl,0x8
L_8f9fd4:
	add1_s r0,r0,r13
L_8f9fd6:
	j_s [r0]
L_8f9fd8:
	mov_s r13,0x0
L_8f9fda:
	mov_s r0,r14
L_8f9fdc:
	mov_s r1,r13
L_8f9fde:
	bl L_8ed424
L_8f9fe2:
	bl L_8ed364
L_8f9fe6:
	mov_s r1,0x28
L_8f9fe8:
	bset_s r1,r1,0xd
L_8f9fea:
	bl L_8ed544
L_8f9fee:
	ld_s r0,[r14]
L_8f9ff0:
	bic r0,r0,0x38
L_8f9ff4:
	st_s r0,[r14]
L_8f9ff6:
	ld_s r0,[r14,0x4]
L_8f9ff8:
	bclr_s r0,r0,0xd
L_8f9ffa:
	bl.d L_8cceb8
L_8f9ffe:
	st_s r0,[r14,0x4]
L_8fa000:
	bmsk r1,r0,0xc
L_8fa004:
	add_s r0,r14,0x4
L_8fa006:
	bl L_8ed34c
	.global L_8fa00a
L_8fa00a:
	add_s r0,r14,0x4
L_8fa00c:
	mov_s r1,0x5
L_8fa00e:
	bl.d L_8ed3d0
L_8fa012:
	stw_s r13,[r14,0xe]
L_8fa014:
	b L_8fa220
L_8fa018:
	mov_s r0,r14
L_8fa01a:
	mov_s r1,0x1
L_8fa01c:
	bl L_8ed424
L_8fa020:
	mov_s r1,0x7
L_8fa022:
	bl L_8ed364
L_8fa026:
	mov_s r1,0x28
L_8fa028:
	bset_s r1,r1,0xd
L_8fa02a:
	bl L_8ed544
L_8fa02e:
	ld_s r0,[r14]
L_8fa030:
	bic r0,r0,0x38
L_8fa034:
	bset_s r0,r0,0x4
L_8fa036:
	b_s L_8fa052
L_8fa038:
	mov_s r0,r14
L_8fa03a:
	mov_s r1,0x0
L_8fa03c:
	bl L_8ed424
L_8fa040:
	bl L_8ed364
L_8fa044:
	mov_s r1,0x0
L_8fa046:
	bset_s r1,r1,0xc
L_8fa048:
	bl L_8ed544
L_8fa04c:
	ld_s r0,[r14]
L_8fa04e:
	bic r0,r0,0x38
	.global L_8fa052
L_8fa052:
	st_s r0,[r14]
L_8fa054:
	ld_s r0,[r14,0x4]
L_8fa056:
	bclr_s r0,r0,0xd
L_8fa058:
	bl.d L_8cceb8
L_8fa05c:
	st_s r0,[r14,0x4]
L_8fa05e:
	bmsk r1,r0,0xc
L_8fa062:
	add_s r0,r14,0x4
L_8fa064:
	bl.d L_8ed34c
L_8fa068:
	mov_s r13,0x0
L_8fa06a:
	b_s L_8fa00a
L_8fa06c:
	bl L_8cc2e8
L_8fa070:
	cmp_s r0,0x0
L_8fa072:
	beq_s L_8fa170
L_8fa074:
	bl L_8cc2f0
L_8fa078:
	bmsk r1,r0,0x9
L_8fa07c:
	mov_s r0,r14
L_8fa07e:
	bl L_8ed424
L_8fa082:
	bl L_8cc2fc
L_8fa086:
	bmsk r1,r0,0xd
L_8fa08a:
	mov_s r0,r14
L_8fa08c:
	bl L_8ed544
L_8fa090:
	ld_s r0,[r14]
L_8fa092:
	mov_s r15,0xffff0000
L_8fa098:
	bset_s r0,r0,0x4
L_8fa09a:
	bl.d L_8cc2f4
L_8fa09e:
	st_s r0,[r14]
L_8fa0a0:
	bmsk r1,r0,0x2
L_8fa0a4:
	mov_s r0,r14
L_8fa0a6:
	bl L_8ed364
L_8fa0aa:
	bl L_8cc2ec
L_8fa0ae:
	bmsk_s r0,r0,0x0
L_8fa0b0:
	ld_s r1,[r14]
L_8fa0b2:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_8fa0b4:
	bclr_s r1,r1,0x3
L_8fa0b6:
	or_s r0,r0,r1
L_8fa0b8:
	bl.d L_8cc31c
L_8fa0bc:
	st_s r0,[r14]
L_8fa0be:
	ld_s r1,[r14]
L_8fa0c0:
	bclr_s r1,r1,0x1e
L_8fa0c2:
	breq_s r0,0,L_8fa110
L_8fa0c4:
	bset_s r1,r1,0x1e
L_8fa0c6:
	bl.d L_8cc308
L_8fa0ca:
	st_s r1,[r14]
L_8fa0cc:
	tst_s r0,r15
L_8fa0ce:
	bne_s L_8fa0fc
	.global L_8fa0d0
L_8fa0d0:
	mov_s r13,0x886c00
L_8fa0d6:
	ld_s r0,[r13,0x70]
L_8fa0d8:
	bl.d L_8cc308
L_8fa0dc:
	and_s r15,r15,r0
L_8fa0de:
	or_s r0,r0,r15
L_8fa0e0:
	st_s r0,[r13,0x70]
L_8fa0e2:
	bl.d L_8cc330
L_8fa0e6:
	mov r15,-0x100
L_8fa0ea:
	tst_s r0,r15
L_8fa0ec:
	bne_s L_8fa106
	.global L_8fa0ee
L_8fa0ee:
	ld_s r0,[r13,0x74]
L_8fa0f0:
	bl.d L_8cc330
L_8fa0f4:
	and_s r15,r15,r0
L_8fa0f6:
	or_s r0,r0,r15
L_8fa0f8:
	st_s r0,[r13,0x74]
L_8fa0fa:
	b_s L_8fa128
	.global L_8fa0fc
L_8fa0fc:
	mov_s r0,blink
L_8fa0fe:
	bl.d L_8c9b28
L_8fa102:
	mov_s r1,0xac
L_8fa104:
	b_s L_8fa0d0
	.global L_8fa106
L_8fa106:
	mov_s r0,blink
L_8fa108:
	bl.d L_8c9b28
L_8fa10c:
	mov_s r1,0xac
L_8fa10e:
	b_s L_8fa0ee
	.global L_8fa110
L_8fa110:
	st_s r1,[r14]
L_8fa112:
	mov_s r1,0x886c00
L_8fa118:
	ld_s r0,[r1,0x70]
L_8fa11a:
	and_s r0,r0,r15
L_8fa11c:
	bset_s r0,r0,0x0
L_8fa11e:
	st_s r0,[r1,0x70]
L_8fa120:
	ld_s r0,[r1,0x74]
L_8fa122:
	bic r0,r0,0xff
L_8fa126:
	st_s r0,[r1,0x74]
	.global L_8fa128
L_8fa128:
	ld_s r0,[r14]
L_8fa12a:
	bset_s r0,r0,0x5
L_8fa12c:
	bl.d L_8cc304
L_8fa130:
	st_s r0,[r14]
L_8fa132:
	ld_s r1,[r14,0x4]
L_8fa134:
	cmp_s r0,0x0
L_8fa136:
	bclr_s r1,r1,0xd
L_8fa138:
	bset.ne r1,r1,0xd
L_8fa13c:
	bl.d L_8cc344
L_8fa140:
	st_s r1,[r14,0x4]
L_8fa142:
	bmsk r1,r0,0xc
L_8fa146:
	add_s r0,r14,0x4
L_8fa148:
	bl L_8ed34c
L_8fa14c:
	bl L_8cc300
L_8fa150:
	bmsk r1,r0,0x3
L_8fa154:
	add_s r0,r14,0x4
L_8fa156:
	bl L_8ed418
L_8fa15a:
	bl L_8cc348
L_8fa15e:
	bl.d L_8cc2f8
L_8fa162:
	stw_s r0,[r14,0xe]
L_8fa164:
	bmsk r1,r0,0x2
L_8fa168:
	add_s r0,r14,0x4
L_8fa16a:
	bl L_8ed3d0
L_8fa16e:
	b_s L_8fa220
	.global L_8fa170
L_8fa170:
	mov_s r13,0x0
L_8fa172:
	mov_s r0,r14
L_8fa174:
	mov_s r1,r13
L_8fa176:
	bl L_8ed424
L_8fa17a:
	bl L_8cc2fc
L_8fa17e:
	bmsk r1,r0,0xd
L_8fa182:
	mov_s r0,r14
L_8fa184:
	bl L_8ed544
L_8fa188:
	ld_s r0,[r14]
L_8fa18a:
	mov_s r1,r13
L_8fa18c:
	bclr_s r0,r0,0x4
L_8fa18e:
	st_s r0,[r14]
L_8fa190:
	mov_s r0,r14
L_8fa192:
	bl L_8ed364
L_8fa196:
	ld_s r0,[r14]
L_8fa198:
	bclr_s r0,r0,0x1e
L_8fa19a:
	bl.d L_8cc2ec
L_8fa19e:
	st_s r0,[r14]
L_8fa1a0:
	bmsk_s r0,r0,0x0
L_8fa1a2:
	ld_s r1,[r14]
L_8fa1a4:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_8fa1a6:
	bic r1,r1,0x28
L_8fa1aa:
	bclr_s r0,r0,0x5
L_8fa1ac:
	or_s r0,r0,r1
L_8fa1ae:
	bset_s r0,r0,0x5
L_8fa1b0:
	st_s r0,[r14]
L_8fa1b2:
	ld_s r0,[r14,0x4]
L_8fa1b4:
	mov_s r1,0x1fff
L_8fa1ba:
	bclr_s r0,r0,0xd
L_8fa1bc:
	st_s r0,[r14,0x4]
L_8fa1be:
	add_s r0,r14,0x4
L_8fa1c0:
	bl L_8ed34c
L_8fa1c4:
	stw_s r13,[r14,0xe]
L_8fa1c6:
	b_s L_8fa220
L_8fa1c8:
	mov_s r0,r14
L_8fa1ca:
	mov r1,0x29a
L_8fa1ce:
	bl L_8ed424
L_8fa1d2:
	mov r1,0x219
L_8fa1d6:
	bl L_8ed544
L_8fa1da:
	ld_s r0,[r14]
L_8fa1dc:
	mov_s r1,0x4
L_8fa1de:
	bset_s r0,r0,0x4
L_8fa1e0:
	st_s r0,[r14]
L_8fa1e2:
	mov_s r0,r14
L_8fa1e4:
	bl L_8ed364
L_8fa1e8:
	ld_s r0,[r14]
L_8fa1ea:
	mov_s r1,0x1cc2
L_8fa1f0:
	bic r0,r0,0x28
L_8fa1f4:
	bset_s r0,r0,0x5
L_8fa1f6:
	st_s r0,[r14]
L_8fa1f8:
	ld_s r0,[r14,0x4]
L_8fa1fa:
	bclr_s r0,r0,0xd
L_8fa1fc:
	st_s r0,[r14,0x4]
L_8fa1fe:
	add_s r0,r14,0x4
L_8fa200:
	bl L_8ed34c
L_8fa204:
	mov_s r1,0x7
L_8fa206:
	bl L_8ed3d0
L_8fa20a:
	stw 0xaf23,[r14, 0xe]
L_8fa212:
	b_s L_8fa220
	.global L_8fa214
L_8fa214:
	add_s r0,r14,0x4
L_8fa216:
	mov_s r1,0x1fff
L_8fa21c:
	bl L_8ed34c
	.global L_8fa220
L_8fa220:
	b L_8c024c
