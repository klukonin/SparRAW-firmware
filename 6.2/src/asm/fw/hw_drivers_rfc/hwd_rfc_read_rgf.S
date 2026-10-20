/* hwd_rfc_read_rgf @ 0x8d3588, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_read_rgf: rf_rgf_addr=0x%x rfca_en=0x%02x
 *   hwd_rfc_read_rgf: RF read failed in all %d trials. Returning invalid res_val=0x%8x
 * Зовут его: UT_HW_DRIVERS_cmd_handler, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler, hw_sysapi_rfc_fetch_rgf_util, hwd_rfc__read_sector_chain, hwd_rfc__read_sector_reg, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, hwd_rfc_write_verify
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2, fw_sysassert_fatal, hwd_abif__rfc_divider_restart, hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_read_rgf
hwd_rfc_read_rgf:
	.global L_8d3588
L_8d3588:
	push_s blink
L_8d358a:
	bl L_8c01dc
L_8d358e:
	mov_s r0,0x889480
L_8d3594:
	ld_s r3,[r0,0x8]
L_8d3596:
	mov_s r15,0xdeadbeef
L_8d359c:
	lsr_s r3,r3,0x8
L_8d359e:
	extb_s r3,r3
L_8d35a0:
	neg_s r0,r3
L_8d35a2:
	and_s r0,r0,r3
L_8d35a4:
	xor.f 0x0,r0,r3
L_8d35a8:
	mov_s r16,r1
L_8d35aa:
	beq_s L_8d35c6
L_8d35ac:
	mov_s r1,0x101e1e4
L_8d35b2:
	mov_s r0,0x0
L_8d35b4:
	bl.d L_8dcc80
L_8d35b8:
	mov_s r2,r16
L_8d35ba:
	mov_s r0,blink
L_8d35bc:
	mov_s r1,0x1513
L_8d35c2:
	bl L_8c9b28
	.global L_8d35c6
L_8d35c6:
	mov_s r14,0x0
L_8d35c8:
	b_s L_8d35d2
	.global L_8d35ca
L_8d35ca:
	bl.d L_8ceda4
L_8d35ce:
	mov_s r0,0x1
L_8d35d0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8d35d2
L_8d35d2:
	brge r14,0x5,L_8d3606
L_8d35d6:
	mov_s r1,0x889100
L_8d35dc:
	ld_s r0,[r1,0x18]
L_8d35de:
	mov_s r13,0x889000
L_8d35e4:
	bset_s r0,r0,0x6
L_8d35e6:
	st_s r0,[r1,0x18]
L_8d35e8:
	ld_s r0,[r1,0x18]
L_8d35ea:
	mov_s r2,r16
L_8d35ec:
	bclr_s r0,r0,0x6
L_8d35ee:
	st_s r0,[r1,0x18]
L_8d35f0:
	mov_s r0,0x0
L_8d35f2:
	mov_s r1,0x4
L_8d35f4:
	bl.d L_8d415c
L_8d35f8:
	mov_s r3,r0
L_8d35fa:
	ld.as r0,[r13,0xfb]
L_8d35fe:
	brne r0,0x1,L_8d35ca
L_8d3602:
	ld r15,[r13, 0xd8]
	.global L_8d3606
L_8d3606:
	brne r15,0xdeadbeef,L_8d3622
L_8d360e:
	mov_s r1,0x101e218
L_8d3614:
	mov_s r0,0x0
L_8d3616:
	mov_s r3,0xdeadbeef
L_8d361c:
	bl.d L_8dcc80
L_8d3620:
	mov_s r2,0x5
	.global L_8d3622
L_8d3622:
	b.d L_8c0244
L_8d3626:
	mov_s r0,r15
