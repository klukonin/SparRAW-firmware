/* discovery__rx_pkt_handler @ 0x8e3f0c, 332 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID Beacon sent to host
 *   discovery::rx_pkt_handler() Probe Req pkt handler # %d
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID Probe Req pkt Pass to host %d
 *   discovery::rx_pkt_handler() Probe Resp pkt handler # %d
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID Probe Resp pkt
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, discovery_handle_probe_req, discovery_handle_probe_resp, dmg_bcon__rx_handler, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, low_sme__send_evt2sw, mem_pool__free_thunk, mgmt_pkt__release, rx_mgmt_prs__alloc_ei_default
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global discovery__rx_pkt_handler
discovery__rx_pkt_handler:
	.global L_8e3f0c
L_8e3f0c:
	push_s blink
L_8e3f0e:
	bl L_8c01dc
L_8e3f12:
	mov_s r16,r0
L_8e3f14:
	mov_s r14,r1
L_8e3f16:
	bl.d L_8e3c3c
L_8e3f1a:
	mov_s r0,r1
L_8e3f1c:
	ld_s r0,[r14,0x8]
L_8e3f1e:
	ldw_s r0,[r0]
L_8e3f20:
	lsr_s r0,r0,0x4
L_8e3f22:
	bmsk.f r0,r0,0x3
L_8e3f26:
	beq_s L_8e3f3e
L_8e3f28:
	breq r0,0x4,L_8e3f94
L_8e3f2c:
	breq r0,0x5,L_8e3fec
L_8e3f30:
	mov_s r0,blink
L_8e3f32:
	mov_s r1,0x1231
L_8e3f38:
	bl L_8c9b28
L_8e3f3c:
	b_s L_8e4054
	.global L_8e3f3e
L_8e3f3e:
	mov_s r0,r16
L_8e3f40:
	bl.d L_8c9404
L_8e3f44:
	mov_s r1,r14
L_8e3f46:
	mov_s r15,r0
L_8e3f48:
	mov_s r13,0x843158
L_8e3f4e:
	ld_s r0,[r13,0x28]
L_8e3f50:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e3f52:
	st_s r0,[r13,0x28]
L_8e3f54:
	bl.d L_8cb180
L_8e3f58:
	mov_s r0,r14
L_8e3f5a:
	breq r15,0x0,L_8e4018
L_8e3f5e:
	mov_s r1,0x1016bdc
L_8e3f64:
	bl.d L_8dcba8
L_8e3f68:
	mov_s r0,0x2c
L_8e3f6a:
	ld_s r2,[r14,0x30]
L_8e3f6c:
	add r0,r14,0x28
L_8e3f70:
	add_s r2,r2,0x10
L_8e3f72:
	extw_s r2,r2
L_8e3f74:
	mov_s r1,0x61
L_8e3f76:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8e3f78:
	ldb r3,[r14, 0x35]
L_8e3f7c:
	mov r4,0x1
L_8e3f80:
	mov r5,0x0
L_8e3f84:
	bl.d L_8e5474
L_8e3f88:
	mov r6,r5
L_8e3f8c:
	ld_s r0,[r13,0x1c]
L_8e3f8e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e3f90:
	st_s r0,[r13,0x1c]
L_8e3f92:
	b_s L_8e4054
	.global L_8e3f94
L_8e3f94:
	mov_s r13,0x843158
L_8e3f9a:
	ld_s r2,[r13]
L_8e3f9c:
	mov_s r1,0x1016c20
L_8e3fa2:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8e3fa4:
	st_s r2,[r13]
L_8e3fa6:
	bl.d L_8dcc10
L_8e3faa:
	mov_s r0,0x2c
L_8e3fac:
	mov_s r0,r16
L_8e3fae:
	bl.d L_8f2798
L_8e3fb2:
	mov_s r1,r14
L_8e3fb4:
	bl.d L_8cb180
L_8e3fb8:
	mov_s r0,r14
L_8e3fba:
	mov_s r1,0x1016c58
L_8e3fc0:
	mov_s r0,0x2c
L_8e3fc2:
	bl.d L_8dcc10
L_8e3fc6:
	ld_s r2,[r13]
L_8e3fc8:
	ld_s r2,[r14,0x30]
L_8e3fca:
	add r0,r14,0x28
L_8e3fce:
	add_s r2,r2,0x10
L_8e3fd0:
	extw_s r2,r2
L_8e3fd2:
	mov_s r1,0x61
L_8e3fd4:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8e3fd6:
	ldb r3,[r14, 0x35]
L_8e3fda:
	mov r4,0x1
L_8e3fde:
	mov r5,0x0
L_8e3fe2:
	bl.d L_8e5474
L_8e3fe6:
	mov r6,r5
L_8e3fea:
	b_s L_8e4054
	.global L_8e3fec
L_8e3fec:
	mov_s r1,0x1016ca8
L_8e3ff2:
	mov_s r13,0x843158
L_8e3ff8:
	mov_s r0,0x2c
L_8e3ffa:
	bl.d L_8dcc10
L_8e3ffe:
	ld_s r2,[r13,0x10]
L_8e4000:
	ld_s r0,[r13,0x10]
L_8e4002:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e4004:
	st_s r0,[r13,0x10]
L_8e4006:
	mov_s r0,r16
L_8e4008:
	bl.d L_8f294c
L_8e400c:
	mov_s r1,r14
L_8e400e:
	mov_s r15,r0
L_8e4010:
	bl.d L_8cb180
L_8e4014:
	mov_s r0,r14
L_8e4016:
	brne_s r15,0,L_8e4020
	.global L_8e4018
L_8e4018:
	bl.d L_8cb15c
L_8e401c:
	mov_s r0,r14
L_8e401e:
	b_s L_8e4054
	.global L_8e4020
L_8e4020:
	mov_s r1,0x1016ce4
L_8e4026:
	bl.d L_8dcba8
L_8e402a:
	mov_s r0,0x2c
L_8e402c:
	ld_s r2,[r14,0x30]
L_8e402e:
	add r0,r14,0x28
L_8e4032:
	add_s r2,r2,0x10
L_8e4034:
	extw_s r2,r2
L_8e4036:
	mov_s r1,0x61
L_8e4038:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8e403a:
	ldb r3,[r14, 0x35]
L_8e403e:
	mov r4,0x1
L_8e4042:
	mov r5,0x0
L_8e4046:
	bl.d L_8e5474
L_8e404a:
	mov r6,r5
L_8e404e:
	ld_s r0,[r13,0xc]
L_8e4050:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e4052:
	st_s r0,[r13,0xc]
	.global L_8e4054
L_8e4054:
	b L_8c0244
