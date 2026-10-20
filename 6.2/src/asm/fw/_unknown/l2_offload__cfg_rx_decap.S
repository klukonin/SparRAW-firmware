/* l2_offload__cfg_rx_decap @ 0x8c7070, 240 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   L2 Offload Rx Decap_trans_type=%d
 *   L2 Offload Rx SNAP_keep=%d
 *   L2 Offload Rx vlan_insertion=%d
 *   L3 Offloads: ipv4_checksum_en=%d  tcpip_checksum_en=%d
 * Зовут его: wmi_cfg_rx_chain
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, dma__set_881b94_bits45, dma_offload__pack_decap_cfg, fw_log_emit1, fw_log_emit2, l2_offload__set_rx_decap_cfg, rx_macq__entry_addr, rx_macq__program_offload_desc_with_b4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_offload__cfg_rx_decap
l2_offload__cfg_rx_decap:
	.global L_8c7070
L_8c7070:
	push_s blink
L_8c7072:
	bl L_8c01d8
L_8c7076:
	mov_s r15,r0
L_8c7078:
	ldb_s r0,[r0,0x12]
L_8c707a:
	mov_s r14,0x0
L_8c707c:
	stb.a r0,[sp,-0x4]
L_8c7080:
	ldb_s r0,[r15,0x13]
L_8c7082:
	mov_s r1,0x100d6b4
L_8c7088:
	mov_s r16,r0
L_8c708a:
	stb r0,[sp, 0x1]
L_8c708e:
	ldb_s r0,[r15,0x16]
L_8c7090:
	stb r0,[sp, 0x2]
L_8c7094:
	mov_s r0,0x2b
L_8c7096:
	bl.d L_8dcc10
L_8c709a:
	ldb_s r2,[r15,0x11]
L_8c709c:
	ldb_s r0,[r15,0x11]
L_8c709e:
	mov_s r13,0x1
L_8c70a0:
	breq_s r0,0,L_8c70b6
L_8c70a2:
	breq r0,0x1,L_8c7106
L_8c70a6:
	mov_s r0,r14
L_8c70a8:
	mov_s r3,r14
L_8c70aa:
	mov_s r4,r13
L_8c70ac:
	mov_s r15,r14
L_8c70ae:
	mov_s r17,r13
L_8c70b0:
	mov_s r5,r13
L_8c70b2:
	mov_s r2,r14
L_8c70b4:
	b_s L_8c7120
	.global L_8c70b6
L_8c70b6:
	ld r16,[sp]
L_8c70ba:
	mov_s r1,0x100d6d8
L_8c70c0:
	lsr r0,r16
L_8c70c4:
	bmsk r17,r0,0x0
L_8c70c8:
	mov_s r0,0x2b
L_8c70ca:
	bl.d L_8dcc10
L_8c70ce:
	mov_s r2,r17
L_8c70d0:
	mov_s r1,0x100d6f4
L_8c70d6:
	mov_s r0,0x2b
L_8c70d8:
	bl.d L_8dcc10
L_8c70dc:
	bmsk r2,r16,0x0
L_8c70e0:
	bxor r17,r17,0x0
L_8c70e4:
	bbit0 r16,0x0,L_8c70fc
L_8c70e8:
	bl.d L_8df5a8
L_8c70ec:
	ldb_s r0,[r15,0x14]
L_8c70ee:
	mov_s r15,0x2
L_8c70f0:
	mov_s r0,r13
L_8c70f2:
	mov_s r3,r13
L_8c70f4:
	mov_s r4,r13
	.global L_8c70f6
L_8c70f6:
	mov_s r5,r14
L_8c70f8:
	mov_s r2,r14
L_8c70fa:
	b_s L_8c7120
	.global L_8c70fc
L_8c70fc:
	mov_s r0,r13
L_8c70fe:
	mov_s r3,r14
L_8c7100:
	mov_s r4,r13
L_8c7102:
	mov_s r15,r13
L_8c7104:
	b_s L_8c70f6
	.global L_8c7106
L_8c7106:
	mov_s r1,0x3
L_8c7108:
	ldb_s r2,[r15,0x15]
L_8c710a:
	mov_s r0,r16
L_8c710c:
	btst_s r0,0x0
L_8c710e:
	mov_s r0,0x2
L_8c7110:
	mov_s r3,r14
L_8c7112:
	mov.ne r4,r13
L_8c7116:
	mov.eq r4,r14
L_8c711a:
	mov_s r15,r1
L_8c711c:
	mov_s r17,r14
L_8c711e:
	mov_s r5,r14
	.global L_8c7120
L_8c7120:
	bl.d L_8df530
L_8c7124:
	mov_s r1,r17
L_8c7126:
	bl.d L_8ccb68
L_8c712a:
	mov_s r0,0x2
L_8c712c:
	bl.d L_8e2474
L_8c7130:
	mov_s r1,r15
L_8c7132:
	ldw r13,[sp, 0x2]
L_8c7136:
	mov_s r1,0x100d714
L_8c713c:
	lsr_s r14,r13
L_8c713e:
	mov_s r0,0x2b
L_8c7140:
	bmsk r2,r13,0x0
L_8c7144:
	bl.d L_8dcc80
L_8c7148:
	bmsk r3,r14,0x0
L_8c714c:
	bmsk r0,r13,0x0
L_8c7150:
	bl.d L_8df560
L_8c7154:
	bmsk r1,r14,0x0
L_8c7158:
	b.d L_8c023c
L_8c715c:
	add_s sp,sp,0x4
L_8c715e:
	nop_s
