/* l2_mgr__connect @ 0x8f1e18, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::connect() MID = %d. NETWORK TYPE = 0x%X. TEST MODE = %d
 *   l2_mgr::connect() MID:[%d], BSSID: ADDR-%04X%08X
 *   l2_mgr::connect() PBC is obsolete
 * Зовут его: l2_mgr__connect_multi_omni_cb, wmi_connect
 * Зовёт сам: RADIO_MGR__set_primary_channel, __ld_r18_to_r13_ret, __st_r18_to_r13, bss_set_active, fw_log_emit0, fw_log_emit3, fw_status__set_state, fw_sysassert_fatal, l2_mgr__connect_args, l2mgr__apply_mac_address, l2mgr__pending_op_set, mid__log_network_type
 * Глобалы (через gp): 0x800212, 0x8002d4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__connect
l2_mgr__connect:
	.global L_8f1e18
L_8f1e18:
	push_s blink
L_8f1e1a:
	bl.d L_8c01d4
L_8f1e1e:
	mov_s r2,0x1
L_8f1e20:
	mov_s r14,r0
L_8f1e22:
	mov_s r13,r1
L_8f1e24:
	bl.d L_8e6358
L_8f1e28:
	mov_s r0,r2
L_8f1e2a:
	add r17,r14,0x20
L_8f1e2e:
	ld r0,[r17, 0x14]
L_8f1e32:
	mov_s r15,0x805160
L_8f1e38:
	st_s r0,[r15]
L_8f1e3a:
	ldw r0,[r17, 0x18]
L_8f1e3e:
	stw_s r0,[r15,0x4]
L_8f1e40:
	mov_s r0,0x803c00
L_8f1e46:
	ld_s r0,[r0,0x20]
L_8f1e48:
	bbit0 r0,0x0,L_8f1e52
L_8f1e4c:
	stw.as r2,[gp,0x47]
L_8f1e50:
	b_s L_8f1e5a
	.global L_8f1e52
L_8f1e52:
	ldb r0,[r17, 0x1a]
L_8f1e56:
	stw.as r0,[gp,0x47]
	.global L_8f1e5a
L_8f1e5a:
	st.as r13,[gp,-0x33]
L_8f1e5e:
	bl.d L_8cc3dc
L_8f1e62:
	mov_s r0,r13
L_8f1e64:
	mov.f r16,r0
L_8f1e68:
	beq_s L_8f1f10
	.global L_8f1e6a
L_8f1e6a:
	mov_s r1,0x100e994
L_8f1e70:
	ldw.as r4,[gp,0x47]
L_8f1e74:
	mov_s r0,0x2b
L_8f1e76:
	mov_s r2,r13
L_8f1e78:
	bl.d L_8dcd00
L_8f1e7c:
	ldb_s r3,[r14]
L_8f1e7e:
	mov_s r0,r16
L_8f1e80:
	bl.d L_8e696c
L_8f1e84:
	ldb_s r1,[r14]
L_8f1e86:
	add3 r0,r16,0x9
L_8f1e8a:
	mov_s r16,r0
L_8f1e8c:
	bl.d L_8e6368
L_8f1e90:
	add r1,r14,0x2a
L_8f1e94:
	add.f r18,r16,0xc
L_8f1e98:
	beq_s L_8f1f1e
	.global L_8f1e9a
L_8f1e9a:
	bl.d L_8e8634
L_8f1e9e:
	mov_s r0,0x5
L_8f1ea0:
	mov_s r1,0x100e9d4
L_8f1ea6:
	ld r4,[r18]
L_8f1eaa:
	mov_s r0,0x2b
L_8f1eac:
	mov_s r2,r13
L_8f1eae:
	bl.d L_8dcd00
L_8f1eb2:
	ldw r3,[r18, 0x4]
L_8f1eb6:
	bl.d L_8c4ec8
L_8f1eba:
	mov_s r0,r16
L_8f1ebc:
	add r1,r14,0x8
L_8f1ec0:
	mov_s r0,r16
L_8f1ec2:
	bl.d L_8e70a8
L_8f1ec6:
	ldb_s r2,[r14,0x7]
L_8f1ec8:
	ldb_s r0,[r14,0x1]
L_8f1eca:
	brne r0,0x8,L_8f1eda
L_8f1ece:
	mov_s r1,0x100ea08
L_8f1ed4:
	bl.d L_8dcba8
L_8f1ed8:
	mov_s r0,0x2b
	.global L_8f1eda
L_8f1eda:
	mov_s r0,0x4
L_8f1edc:
	bl.d L_8e8a14
L_8f1ee0:
	mov_s r1,0x0
L_8f1ee2:
	ldb r0,[r17, 0x8]
L_8f1ee6:
	mov r4,0x1
L_8f1eea:
	ld_s r1,[r15,0x8]
L_8f1eec:
	extb r16,r13
L_8f1ef0:
	ld_s r2,[r15,0xc]
L_8f1ef2:
	ld.as r3,[gp,0x54]
L_8f1ef6:
	bl.d L_8e6cec
L_8f1efa:
	mov r5,r16
L_8f1efe:
	mov_s r0,0x3188c
L_8f1f04:
	mov_s r1,0x0
L_8f1f06:
	bl.d L_8dca38
L_8f1f0a:
	mov_s r2,r16
L_8f1f0c:
	b L_8c0234
	.global L_8f1f10
L_8f1f10:
	mov_s r0,blink
L_8f1f12:
	mov_s r1,0x16c6
L_8f1f18:
	bl L_8c9b28
L_8f1f1c:
	b_s L_8f1e6a
	.global L_8f1f1e
L_8f1f1e:
	mov_s r0,blink
L_8f1f20:
	mov_s r1,0x11e2
L_8f1f26:
	bl L_8c9b28
L_8f1f2a:
	b_s L_8f1e9a
