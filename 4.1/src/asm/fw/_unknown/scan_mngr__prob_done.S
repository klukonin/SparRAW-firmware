/* scan_mngr__prob_done @ 0x8ef034, 400 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::prob_done()
 *   scan_mngr::prob_done() BSSID in the pending list
 *   scan_mngr::prob_done() delete pending event for: ADDR-%04X%08X
 *   scan_mngr::prob_done() delete pending event for prob_resp_timeout_event_id: %d
 *   scan_mngr::prob_done() move from pending list to scanned list BSSID ADDR-%04X%08X
 *   scan_mngr::prob_done() FREE DBAND INFO ELEMENT (probe failed reason = 0x%x)
 *   scan_mngr::prob_done() SCAN CID:%d LINK_ACQ_FAILURE reason: %d m_curr_conn_ptr:0x%X
 *   scan_mngr::prob_done() SCAN CID:%d LINK_BF_FAILURE reason: %d m_curr_conn_ptr:0x%X
 * Зовут его: scan_mngr__connect, scan_mngr__handle_link_up_event, scan_mngr__prob_resp_timeout_cb, scan_mngr__probe_resp_ind
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, channels_switch_sm__action_abort_dwelling, conn__abort, conn_mgr__activate_conn, conn_mgr__link_down_evt, connection__init, free_dband_info, fw_log__emit0, fw_log__emit1, fw_log__emit2, fw_log__emit3
 */
	.section .text.scan_mngr__prob_done,"ax",@progbits
	.global scan_mngr__prob_done
scan_mngr__prob_done:
	.global L_8ef034
L_8ef034:
	push_s blink
L_8ef036:
	bl L_8c02bc
L_8ef03a:
	mov_s r14,r0
L_8ef03c:
	mov_s r16,r1
L_8ef03e:
	mov_s r13,r2
L_8ef040:
	mov_s r2,0x10134f4
L_8ef046:
	mov_s r0,0x9
L_8ef048:
	bl.d L_8edfb0
L_8ef04c:
	mov_s r1,0x2
L_8ef04e:
	cmp_s r13,0x0
L_8ef050:
	beq_s L_8ef1c0
L_8ef052:
	mov_s r2,0x101350c
L_8ef058:
	mov_s r0,0x9
L_8ef05a:
	bl.d L_8edfb0
L_8ef05e:
	mov_s r1,0x2
L_8ef060:
	mov_s r0,0x4
L_8ef062:
	stb r0,[r13, 0x39]
L_8ef066:
	ld_s r0,[r13,0x40]
L_8ef068:
	breq_s r0,0,L_8ef098
L_8ef06a:
	mov_s r2,0x1013540
L_8ef070:
	ld r4,[r13, 0x8]
L_8ef074:
	mov_s r0,0x9
L_8ef076:
	mov_s r1,0x2
L_8ef078:
	bl.d L_8edff8
L_8ef07c:
	ldw_s r3,[r13,0xc]
L_8ef07e:
	mov_s r2,0x1013580
L_8ef084:
	mov_s r0,0x9
L_8ef086:
	mov_s r1,0x2
L_8ef088:
	bl.d L_8edfcc
L_8ef08c:
	ld_s r3,[r13,0x40]
L_8ef08e:
	bl.d L_8c7794
L_8ef092:
	ld_s r0,[r13,0x40]
L_8ef094:
	mov_s r0,0x0
L_8ef096:
	st_s r0,[r13,0x40]
	.global L_8ef098
L_8ef098:
	ld_s r15,[r13,0x3c]
L_8ef09a:
	brne r16,0x0,L_8ef0c6
L_8ef09e:
	mov_s r2,0x10135d0
L_8ef0a4:
	ld r4,[r13, 0x8]
L_8ef0a8:
	mov_s r0,0x9
L_8ef0aa:
	mov_s r1,0x2
L_8ef0ac:
	bl.d L_8edff8
L_8ef0b0:
	ldw_s r3,[r13,0xc]
L_8ef0b2:
	mov_s r0,r14
L_8ef0b4:
	bl.d L_8de4ec
L_8ef0b8:
	mov_s r1,r13
L_8ef0ba:
	add r0,r14,0xc
L_8ef0be:
	bl.d L_8c1fc4
L_8ef0c2:
	mov_s r1,r13
L_8ef0c4:
	b_s L_8ef0f0
	.global L_8ef0c6
L_8ef0c6:
	mov_s r2,0x1013624
L_8ef0cc:
	mov_s r0,0x9
L_8ef0ce:
	mov_s r1,0x2
L_8ef0d0:
	bl.d L_8edfcc
L_8ef0d4:
	mov_s r3,r16
L_8ef0d6:
	brne r16,0x3,L_8ef0e0
L_8ef0da:
	ldb r0,[r13, 0x3a]
L_8ef0de:
	breq_s r0,0,L_8ef0f0
	.global L_8ef0e0
L_8ef0e0:
	mov_s r0,r14
L_8ef0e2:
	bl.d L_8de4ec
L_8ef0e6:
	mov_s r1,r13
L_8ef0e8:
	bl.d L_8ebb88
L_8ef0ec:
	mov_s r0,r13
L_8ef0ee:
	mov_s r13,0x0
	.global L_8ef0f0
L_8ef0f0:
	breq r15,0x0,L_8ef19e
L_8ef0f4:
	ldb r0,[r15, 0xb0]
L_8ef0f8:
	breq r0,0x2,L_8ef19e
L_8ef0fc:
	brne r16,0x1,L_8ef118
L_8ef100:
	mov_s r2,0x1013670
L_8ef106:
	mov_s r0,0x9
L_8ef108:
	mov_s r1,0x1
L_8ef10a:
	ldb_s r3,[r15,0x8]
L_8ef10c:
	mov r4,r16
L_8ef110:
	bl.d L_8ee034
L_8ef114:
	mov_s r5,r15
L_8ef116:
	b_s L_8ef19e
	.global L_8ef118
L_8ef118:
	brne r16,0x2,L_8ef126
L_8ef11c:
	mov_s r2,0x10136c4
L_8ef122:
	ldb_s r3,[r15,0x8]
L_8ef124:
	b_s L_8ef18a
	.global L_8ef126
L_8ef126:
	brne r16,0x3,L_8ef182
L_8ef12a:
	breq_s r13,0,L_8ef182
L_8ef12c:
	mov_s r2,0x1013718
L_8ef132:
	add_s r13,r13,0x20
L_8ef134:
	mov_s r0,0x9
L_8ef136:
	mov_s r1,0x2
L_8ef138:
	bl.d L_8edfcc
L_8ef13c:
	ldb_s r3,[r13,0x1a]
L_8ef13e:
	mov_s r2,0x1013744
L_8ef144:
	mov_s r0,0x9
L_8ef146:
	mov_s r1,0x2
L_8ef148:
	ldb_s r3,[r15,0x8]
L_8ef14a:
	mov r4,r16
L_8ef14e:
	bl.d L_8ee034
L_8ef152:
	mov_s r5,r15
L_8ef154:
	ldb_s r0,[r13,0x1a]
L_8ef156:
	mov_s r1,0x1
L_8ef158:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ef15a:
	extb_s r0,r0
L_8ef15c:
	stb_s r0,[r13,0x1a]
L_8ef15e:
	mov_s r0,0x3
L_8ef160:
	stb_s r0,[r13,0x18]
L_8ef162:
	stb_s r1,[r13,0x19]
L_8ef164:
	bl.d L_8e8dbc
L_8ef168:
	mov_s r0,r15
L_8ef16a:
	add r1,r15,0x10
L_8ef16e:
	mov_s r0,r15
L_8ef170:
	bl.d L_8ed290
L_8ef174:
	ld_s r2,[r15,0xc]
L_8ef176:
	mov_s r1,0x0
L_8ef178:
	st_s r1,[r15,0x20]
L_8ef17a:
	bl.d L_8c1df0
L_8ef17e:
	mov_s r0,r15
L_8ef180:
	b_s L_8ef19e
	.global L_8ef182
L_8ef182:
	ldb_s r3,[r15,0x8]
L_8ef184:
	mov_s r2,0x10137e8
	.global L_8ef18a
L_8ef18a:
	mov_s r0,0x9
L_8ef18c:
	mov_s r1,0x2
L_8ef18e:
	mov r4,r16
L_8ef192:
	bl.d L_8ee034
L_8ef196:
	mov_s r5,r15
L_8ef198:
	bl.d L_8d79cc
L_8ef19c:
	mov_s r0,r15
	.global L_8ef19e
L_8ef19e:
	ld_s r0,[r14,0x6c]
L_8ef1a0:
	brne r0,0x3,L_8ef1c0
L_8ef1a4:
	mov_s r2,0x101383c
L_8ef1aa:
	mov_s r0,0x9
L_8ef1ac:
	bl.d L_8edfb0
L_8ef1b0:
	mov_s r1,0x2
L_8ef1b2:
	ld r0,[r14, 0x84]
L_8ef1b6:
	mov_s r1,0x0
L_8ef1b8:
	mov_s r2,r1
L_8ef1ba:
	bl.d L_8e8f00
L_8ef1be:
	mov_s r3,r1
	.global L_8ef1c0
L_8ef1c0:
	b L_8c0324
