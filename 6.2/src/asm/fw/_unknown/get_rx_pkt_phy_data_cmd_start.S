/* get_rx_pkt_phy_data_cmd_start @ 0x8f3988, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   get_rx_pkt_phy_data_cmd_start: Enter
 *   reject SYSAPI GET_RX_PKT_PHY_DATA - prev command was not completed
 *   get_rx_pkt_phy_data_timeout_cb: !! TIMEOUT !!halt cmd
 * Зовут его: fw_sysapi__start_rx_pkt_phy_data
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, channel_est__clamp_64, channel_est__stack_args, field_set_0x00__8dbe88, fw_log_emit0, fw_sysapi_mgr__send_evt2host, fw_sysapi_mgr__start_sysapi_cmd, fw_sysassert_fatal, get_rx_pkt_phy_data_cmd_complete, memcpy_fw, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global get_rx_pkt_phy_data_cmd_start
get_rx_pkt_phy_data_cmd_start:
	.global L_8f3988
L_8f3988:
	sub_s sp,sp,0x8
L_8f398a:
	push_s blink
L_8f398c:
	bl L_8c01dc
L_8f3990:
	sub_s sp,sp,0x28
L_8f3992:
	st_s r3,[sp,0x3c]
L_8f3994:
	st r4,[sp, 0x40]
L_8f3998:
	mov_s r13,r0
L_8f399a:
	mov_s r16,r1
L_8f399c:
	mov_s r15,r2
L_8f399e:
	mov_s r1,0x1012710
L_8f39a4:
	bl.d L_8dcba8
L_8f39a8:
	mov_s r0,0x20
L_8f39aa:
	mov_s r0,r13
L_8f39ac:
	mov_s r1,r16
L_8f39ae:
	bl.d L_8f7490
L_8f39b2:
	mov_s r2,r15
L_8f39b4:
	add_s r14,sp,0x3c
L_8f39b6:
	mov_s r0,r13
L_8f39b8:
	mov_s r1,0x3
L_8f39ba:
	bl.d L_8f9a20
L_8f39be:
	mov_s r2,r14
L_8f39c0:
	brne_s r0,0,L_8f39e6
L_8f39c2:
	mov_s r0,sp
L_8f39c4:
	bl.d L_8c1cd8
L_8f39c8:
	mov_s r1,0x28
L_8f39ca:
	mov_s r1,0x1012738
L_8f39d0:
	bl.d L_8dcba8
L_8f39d4:
	mov_s r0,0x20
L_8f39d6:
	mov_s r2,sp
L_8f39d8:
	mov_s r0,r13
L_8f39da:
	mov_s r1,0x2
L_8f39dc:
	mov_s r3,0x28
L_8f39de:
	bl.d L_8f8948
L_8f39e2:
	mov_s r4,r14
L_8f39e4:
	b_s L_8f3a12
	.global L_8f39e6
L_8f39e6:
	mov_s r0,0x33a1c
L_8f39ec:
	st_s r0,[r13,0x34]
L_8f39ee:
	mov_s r2,0x33a48
L_8f39f4:
	mov_s r0,r13
L_8f39f6:
	bl.d L_8f9070
L_8f39fa:
	mov_s r1,r15
L_8f39fc:
	mov_s r0,sp
L_8f39fe:
	mov_s r1,r16
L_8f3a00:
	bl.d L_8c0380
L_8f3a04:
	mov_s r2,0x8
L_8f3a06:
	ld_s r1,[sp,0x0]
L_8f3a08:
	mov_s r0,0x2e
L_8f3a0a:
	ld_s r2,[sp,0x4]
L_8f3a0c:
	bl.d L_8dbe54
L_8f3a10:
	mov_s r3,0x0
	.global L_8f3a12
L_8f3a12:
	mov_s r12,0xc
L_8f3a14:
	b.d L_8c0246
L_8f3a18:
	add_s sp,sp,0x28
L_8f3a1a:
	nop_s
L_8f3a1c:
	push_s blink
L_8f3a1e:
	bl L_8c01dc
L_8f3a22:
	mov.f r13,r0
L_8f3a26:
	mov_s r14,r1
L_8f3a28:
	mov_s r16,r2
L_8f3a2a:
	beq_s L_8f3a3a
	.global L_8f3a2c
L_8f3a2c:
	st_s r14,[r13,0x20]
L_8f3a2e:
	mov_s r0,r13
L_8f3a30:
	bl.d L_8f38cc
L_8f3a34:
	mov_s r1,r16
L_8f3a36:
	b L_8c0244
	.global L_8f3a3a
L_8f3a3a:
	mov_s r0,blink
L_8f3a3c:
	mov_s r1,0x1454
L_8f3a42:
	bl L_8c9b28
L_8f3a46:
	b_s L_8f3a2c
L_8f3a48:
	push_s blink
L_8f3a4a:
	ld_s r2,[r0]
L_8f3a4c:
	mov_s r1,0x0
L_8f3a4e:
	st_s r1,[r0,0x10]
L_8f3a50:
	brne r2,0x3,L_8f3a5c
L_8f3a54:
	ld_s r2,[r0,0x20]
L_8f3a56:
	cmp_s r2,0x2
L_8f3a58:
	mov.eq r1,0x1
	.global L_8f3a5c
L_8f3a5c:
	extb.f 0x0,r1
L_8f3a60:
	beq_s L_8f3a78
L_8f3a62:
	breq_s r0,0,L_8f3a7c
	.global L_8f3a64
L_8f3a64:
	mov_s r1,0x1013074
L_8f3a6a:
	bl.d L_8dcba8
L_8f3a6e:
	mov_s r0,0x20
L_8f3a70:
	mov_s r0,0x2f
L_8f3a72:
	bl.d L_8dbe88
L_8f3a76:
	mov_s r1,0x3
	.global L_8f3a78
L_8f3a78:
	pop_s blink
L_8f3a7a:
	j_s [blink]
	.global L_8f3a7c
L_8f3a7c:
	mov_s r0,blink
L_8f3a7e:
	mov_s r1,0x1530
L_8f3a84:
	bl L_8c9b28
L_8f3a88:
	b_s L_8f3a64
L_8f3a8a:
	nop_s
