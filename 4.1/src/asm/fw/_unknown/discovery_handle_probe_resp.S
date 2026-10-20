/* discovery_handle_probe_resp @ 0x8eb678, 244 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery_handle_probe_resp()
 *   [NNL] length %d send pkt to host (channel ID = %d) <ts: %d>
 *   [NNL] rssi_raw_value %d (0x%X), snr %d
 *   discovery_handle_probe_resp() Probe resp contain Wilocity Vendor Specific [[ PBC mode = %d ]]
 * Зовут его: discovery__rx_pkt_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit3, fw_read_timer, hwd_phy__get_883b80, mid_list__find_by, parse_wilocity_vs__get_flag3, regulatory_domain__set_country_code, scan_mngr__probe_resp_ind, set_vendor_specific_version
 * Глобалы (через gp): 0x800410
 */
	.section .text.discovery_handle_probe_resp,"ax",@progbits
	.global discovery_handle_probe_resp
discovery_handle_probe_resp:
	.global L_8eb678
L_8eb678:
	push_s blink
L_8eb67a:
	bl L_8c02b8
L_8eb67e:
	mov_s r16,r0
L_8eb680:
	mov_s r14,r1
L_8eb682:
	mov_s r2,0x101231c
L_8eb688:
	mov_s r0,0xc
L_8eb68a:
	bl.d L_8edfb0
L_8eb68e:
	mov_s r1,0x2
L_8eb690:
	ld_s r1,[r14,0x8]
L_8eb692:
	add_s r1,r1,0xa
L_8eb694:
	bl.d L_8c9e74
L_8eb698:
	ld r0,[r16, 0x4]
L_8eb69c:
	mov.f r17,r0
L_8eb6a0:
	mov_s r15,0x0
L_8eb6a2:
	beq_s L_8eb766
L_8eb6a4:
	bl.d L_8e4694
L_8eb6a8:
	add r13,r14,0x20
L_8eb6ac:
	mov_s r5,r0
L_8eb6ae:
	mov_s r2,0x101233c
L_8eb6b4:
	ldb r4,[r13, 0x17]
L_8eb6b8:
	mov_s r0,0xc
L_8eb6ba:
	mov_s r1,0x2
L_8eb6bc:
	bl.d L_8ee034
L_8eb6c0:
	ld_s r3,[r14,0x30]
L_8eb6c2:
	bl L_8cfed8
L_8eb6c6:
	st.as r0,[gp,0xa8]
L_8eb6ca:
	mov_s r4,r0
L_8eb6cc:
	mov_s r0,0x5
L_8eb6ce:
	stw_s r0,[r14,0x2c]
L_8eb6d0:
	asr r0,r4,0x4
L_8eb6d4:
	sub3 r5,r0,0x9
L_8eb6d8:
	sexb r5,r5
L_8eb6dc:
	stb_s r15,[r13,0xa]
L_8eb6de:
	stb r5,[r13, 0x9]
L_8eb6e2:
	ldb r0,[r17,0x185]
L_8eb6ea:
	mov_s r2,0x1012378
L_8eb6f0:
	stb_s r0,[r13,0xb]
L_8eb6f2:
	mov_s r0,0xc
L_8eb6f4:
	mov_s r1,0x2
L_8eb6f6:
	bl.d L_8ee034
L_8eb6fa:
	mov_s r3,r4
L_8eb6fc:
	ld r0,[r16, 0x8]
L_8eb700:
	ld_s r1,[r0,0x78]
L_8eb702:
	breq_s r1,0,L_8eb74a
L_8eb704:
	ld_s r2,[r14,0x8]
L_8eb706:
	add_s r1,r2,0x4
L_8eb708:
	add_s r2,r2,0x10
L_8eb70a:
	bl.d L_8ef694
L_8eb70e:
	ldb_s r3,[r13,0x17]
L_8eb710:
	mov.f r15,r0
L_8eb714:
	ld_s r1,[r14,0xc]
L_8eb716:
	beq_s L_8eb754
L_8eb718:
	ld r0,[r1, 0xa4]
L_8eb71c:
	breq_s r0,0,L_8eb754
L_8eb71e:
	add r1,r1,0xa0
L_8eb722:
	ld r0,[r16, 0x4]
L_8eb726:
	bl.d L_8db7e0
L_8eb72a:
	add_s r0,r0,0x48
L_8eb72c:
	mov_s r3,r0
L_8eb72e:
	mov_s r2,0x10123a0
L_8eb734:
	mov_s r0,0xc
L_8eb736:
	bl.d L_8edfcc
L_8eb73a:
	mov_s r1,0x2
L_8eb73c:
	mov_s r0,r17
L_8eb73e:
	mov_s r1,r14
L_8eb740:
	bl.d L_8e21d0
L_8eb744:
	ld r2,[r16, 0x4]
L_8eb748:
	b_s L_8eb754
	.global L_8eb74a
L_8eb74a:
	ld r0,[r16, 0x70]
L_8eb74e:
	cmp_s r0,0x0
L_8eb750:
	mov.ne r15,0x1
	.global L_8eb754
L_8eb754:
	ld_s r0,[r14,0xc]
L_8eb756:
	ld_s r0,[r0,0x1c]
L_8eb758:
	breq_s r0,0,L_8eb766
L_8eb75a:
	ldb_s r1,[r0]
L_8eb75c:
	ldb_s r0,[r0,0x1]
L_8eb75e:
	asl_s r1,r1,0x8
L_8eb760:
	bl.d L_8e1670
L_8eb764:
	or_s r0,r0,r1
	.global L_8eb766
L_8eb766:
	b.d L_8c031c
L_8eb76a:
	mov_s r0,r15
