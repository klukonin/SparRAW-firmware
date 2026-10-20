/* scan_mngr__dband_beacon_ind @ 0x8c7f9c, 584 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::dband_beacon_ind() Scan while connect. Got connected AP beacon. BSSID#%x%x MID#%d.
 *   scan_mngr::dband_beacon_ind() uCode mailbox is full, ignore this beacon indication BSSID: ADDR-%04X%08X
 *   scan_mngr::dband_beacon_ind() exit. maximum allocation for pending list is WMI_MAX_ASSOC_STA(8)
 *   scan_mngr::dband_beacon_ind() exit. p_dband_info == NULL
 *   scan_mngr::dband_beacon_ind() Adding DMG BEACON from BSSID: ADDR-%04X%08X to scanned_list dont send prob req.
 *   scan_mngr::dband_beacon_ind() Adding DMG BEACON from BSSID: ADDR-%04X%08X discovery_mode=%d.
 *   [NNL] container:%d
 *   scan_mngr::dband_beacon_ind() no probing in passive scan
 * Зовут его: dmg_bcon__rx_handler
 * Зовёт сам: __ld_r23_to_r13_ret, __st_r23_to_r13, alloc_dband_info, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, find_main_sm__bcon_step, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, hexdump_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__dband_beacon_ind
scan_mngr__dband_beacon_ind:
	.global L_8c7f9c
L_8c7f9c:
	push_s blink
L_8c7f9e:
	bl L_8c01c0
L_8c7fa2:
	sub_s sp,sp,0x24
L_8c7fa4:
	mov_s r20,r0
L_8c7fa6:
	mov_s r16,r1
L_8c7fa8:
	ld_s r13,[r1,0x8]
L_8c7faa:
	mov_s r14,0x0
L_8c7fac:
	ld_s r0,[r1,0xc]
L_8c7fae:
	/* add_s r13,0x4 */
	.byte 0x04,0xe5
L_8c7fb0:
	ld r0,[r0, 0xc0]
L_8c7fb4:
	mov.f r17,r2
L_8c7fb8:
	ldb_s r0,[r0]
L_8c7fba:
	lsr r23,r0
L_8c7fbe:
	beq_s L_8c7fd2
L_8c7fc0:
	add r0,r20,0xc
L_8c7fc4:
	bl.d L_8f8574
L_8c7fc8:
	mov_s r1,r13
L_8c7fca:
	cmp_s r0,0x0
L_8c7fcc:
	mov.ne r0,r14
L_8c7fd0:
	bne_s L_8c81a8
	.global L_8c7fd2
L_8c7fd2:
	ld r0,[r20, 0x80]
L_8c7fd6:
	ldb_s r0,[r0]
L_8c7fd8:
	brne r0,0x4,L_8c7fe4
L_8c7fdc:
	ld.as r0,[r20,0x78]
L_8c7fe0:
	brne r0,0x1,L_8c7fe8
	.global L_8c7fe4
L_8c7fe4:
	mov_s r0,0x0
L_8c7fe6:
	b_s L_8c81a8
	.global L_8c7fe8
L_8c7fe8:
	bl.d L_8cc484
L_8c7fec:
	mov_s r14,sp
L_8c7fee:
	mov_s r1,r0
L_8c7ff0:
	bl.d L_8e5dfc
L_8c7ff4:
	mov_s r0,r14
L_8c7ff6:
	mov_s r15,0x0
L_8c7ff8:
	b_s L_8c800a
	.global L_8c7ffa
L_8c7ffa:
	bl.d L_8df444
L_8c7ffe:
	mov_s r0,r14
L_8c8000:
	bl L_8cc3dc
L_8c8004:
	mov.f r15,r0
L_8c8008:
	bne_s L_8c8016
	.global L_8c800a
L_8c800a:
	bl.d L_8cdcc4
L_8c800e:
	mov_s r0,r14
L_8c8010:
	brne_s r0,0,L_8c7ffa
L_8c8012:
	mov_s r0,0x0
L_8c8014:
	b_s L_8c806a
	.global L_8c8016
L_8c8016:
	mov_s r1,0x1
L_8c8018:
	bl.d L_8cc424
L_8c801c:
	mov_s r18,r1
L_8c801e:
	breq_s r0,0,L_8c800a
L_8c8020:
	add2 r0,r15,0x15
L_8c8024:
	ldb_s r2,[r0]
L_8c8026:
	ldb_s r1,[r13]
L_8c8028:
	brne r2,r1,L_8c800a
L_8c802c:
	ldb_s r2,[r0,0x1]
L_8c802e:
	ldb_s r1,[r13,0x1]
L_8c8030:
	brne r2,r1,L_8c800a
L_8c8034:
	ldb_s r2,[r0,0x2]
L_8c8036:
	ldb_s r1,[r13,0x2]
L_8c8038:
	brne r2,r1,L_8c800a
L_8c803c:
	ldb_s r2,[r0,0x3]
L_8c803e:
	ldb_s r1,[r13,0x3]
L_8c8040:
	brne r2,r1,L_8c800a
L_8c8044:
	ldb_s r2,[r0,0x4]
L_8c8046:
	ldb_s r1,[r13,0x4]
L_8c8048:
	brne r2,r1,L_8c800a
L_8c804c:
	ldb_s r1,[r0,0x5]
L_8c804e:
	ldb_s r0,[r13,0x5]
L_8c8050:
	brne r1,r0,L_8c800a
L_8c8054:
	ldb r4,[r15, 0x10]
L_8c8058:
	mov_s r1,0x10157e8
L_8c805e:
	ld_s r2,[r13]
L_8c8060:
	mov_s r0,0x29
L_8c8062:
	bl.d L_8dcd00
L_8c8066:
	ldw_s r3,[r13,0x4]
L_8c8068:
	mov_s r0,r18
	.global L_8c806a
L_8c806a:
	mov_s r21,r0
L_8c806c:
	mov r22,0x8054ec
L_8c8074:
	ldw r0,[r22, 0x2c]
L_8c8078:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c807a:
	extw_s r0,r0
L_8c807c:
	bl.d L_8db948
L_8c8080:
	stw r0,[r22, 0x2c]
L_8c8084:
	brne r0,0x1,L_8c809a
L_8c8088:
	ld_s r2,[r13]
L_8c808a:
	mov_s r1,0x1015848
L_8c8090:
	mov_s r0,0x19
L_8c8092:
	bl.d L_8dcc80
L_8c8096:
	ldw_s r3,[r13,0x4]
L_8c8098:
	b_s L_8c7fe4
	.global L_8c809a
L_8c809a:
	mov_s r0,r20
L_8c809c:
	bl.d L_8f8574
L_8c80a0:
	mov_s r1,r13
L_8c80a2:
	brne r0,0x0,L_8c7fe4
L_8c80a6:
	add r18,r20,0xc
L_8c80aa:
	mov_s r0,r18
L_8c80ac:
	bl.d L_8f8574
L_8c80b0:
	mov_s r1,r13
L_8c80b2:
	brne r0,0x0,L_8c7fe4
L_8c80b6:
	ld r0,[r20]
L_8c80ba:
	brlo r0,0x8,L_8c80cc
L_8c80be:
	mov_s r1,0x10158b0
	.global L_8c80c4
L_8c80c4:
	bl.d L_8dcba8
L_8c80c8:
	mov_s r0,0x19
L_8c80ca:
	b_s L_8c7fe4
	.global L_8c80cc
L_8c80cc:
	bl L_8f0cf8
L_8c80d0:
	mov.f r14,r0
L_8c80d4:
	bne_s L_8c80de
L_8c80d6:
	mov_s r1,0x1015910
L_8c80dc:
	b_s L_8c80c4
	.global L_8c80de
L_8c80de:
	add r0,r14,0x8
L_8c80e2:
	mov_s r1,r13
L_8c80e4:
	bl.d L_8c0380
L_8c80e8:
	mov_s r2,0x6
L_8c80ea:
	mov_s r0,0x3
L_8c80ec:
	stb r0,[r14, 0x40]
L_8c80f0:
	mov_s r0,0x1
L_8c80f2:
	stb r0,[r14, 0x41]
L_8c80f6:
	mov_s r0,0x0
L_8c80f8:
	st_s r0,[r14,0x44]
L_8c80fa:
	st r21,[r14, 0x34]
L_8c80fe:
	ldb r0,[r20,0x214]
L_8c8106:
	add_s r1,sp,0x4
L_8c8108:
	stb r0,[r14, 0x39]
L_8c810c:
	add3 r0,r15,0x9
L_8c8110:
	bl.d L_8ccc98
L_8c8114:
	mov_s r19,r1
L_8c8116:
	extb_s r2,r0
L_8c8118:
	brlt.d r2,0x1,L_8c812a
L_8c811c:
	stb r0,[r14, 0x30]
L_8c8120:
	add r0,r14,0x10
L_8c8124:
	bl.d L_8c0380
L_8c8128:
	mov_s r1,r19
	.global L_8c812a
L_8c812a:
	breq r17,0x0,L_8c8148
L_8c812e:
	ldw_s r2,[r14,0xc]
L_8c8130:
	mov_s r1,0x101594c
L_8c8136:
	mov_s r0,0x29
L_8c8138:
	bl.d L_8dcc80
L_8c813c:
	ld_s r3,[r14,0x8]
L_8c813e:
	mov_s r0,r18
L_8c8140:
	bl.d L_8c25f4
L_8c8144:
	mov_s r1,r14
L_8c8146:
	b_s L_8c7fe4
	.global L_8c8148
L_8c8148:
	mov_s r0,r20
L_8c814a:
	bl.d L_8c25f4
L_8c814e:
	mov_s r1,r14
L_8c8150:
	ldw r0,[r22, 0x2e]
L_8c8154:
	mov_s r1,0x10159bc
L_8c815a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c815c:
	extw_s r0,r0
L_8c815e:
	stw r0,[r22, 0x2e]
L_8c8162:
	ldw_s r2,[r14,0xc]
L_8c8164:
	mov_s r0,0x29
L_8c8166:
	ld_s r3,[r14,0x8]
L_8c8168:
	bl.d L_8dcd00
L_8c816c:
	bmsk r4,r23,0x0
L_8c8170:
	mov_s r1,0x1015a1c
L_8c8176:
	mov_s r0,0x29
L_8c8178:
	bl.d L_8dcc10
L_8c817c:
	ld_s r2,[r14,0x4]
L_8c817e:
	ld r0,[r16, 0x8]
L_8c8182:
	bl.d L_8c9790
L_8c8186:
	ld r1,[r16, 0x30]
L_8c818a:
	ld r0,[r20, 0x6c]
L_8c818e:
	cmp_s r0,0x2
L_8c8190:
	mov_s r0,0x1
L_8c8192:
	sub_s.ne r0,r0,r0
L_8c8194:
	extb.f 0x0,r0
L_8c8198:
	beq_s L_8c81ae
L_8c819a:
	mov_s r1,0x1015a30
L_8c81a0:
	bl.d L_8dcba8
L_8c81a4:
	mov_s r0,0x29
L_8c81a6:
	mov_s r0,0x1
	.global L_8c81a8
L_8c81a8:
	b.d L_8c020c
L_8c81ac:
	add_s sp,sp,0x24
	.global L_8c81ae
L_8c81ae:
	breq r21,0x0,L_8c81c6
L_8c81b2:
	mov_s r0,r15
L_8c81b4:
	bl.d L_8cc024
L_8c81b8:
	mov_s r1,r13
L_8c81ba:
	st_s r0,[r14,0x44]
L_8c81bc:
	mov_s r0,r20
L_8c81be:
	bl.d L_8f8bcc
L_8c81c2:
	mov_s r1,r14
L_8c81c4:
	b_s L_8c7fe4
	.global L_8c81c6
L_8c81c6:
	mov_s r1,0x1015a6c
L_8c81cc:
	bl.d L_8dcba8
L_8c81d0:
	mov_s r0,0x29
L_8c81d2:
	mov_s r0,0x395bc
L_8c81d8:
	mov_s r1,r20
L_8c81da:
	mov_s r2,r14
L_8c81dc:
	bl.d L_8c3248
L_8c81e0:
	mov_s r3,0x1
L_8c81e2:
	b_s L_8c7fe4
