/* memcpy_fw @ 0x8c0380, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: Calib__Measure_VGA_Gains, SW_TX_MGMT_API__send_packet, UT_HW_DRIVERS_cmd_handler, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler, add_bcon, add_discovery_bcon, add_key, add_pbss_dmg_capinfo_list, app_ie__remove_tlv, boot__init_subsystems
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global memcpy_fw
memcpy_fw:
	.global L_8c0380
L_8c0380:
	mov.f lp_count,r2
L_8c0384:
	or r4,r0,r1
L_8c0388:
	jeq [blink]
L_8c038c:
	and.f 0x0,r4,0x3
L_8c0390:
	lsr r4,r2,0x3
L_8c0394:
	bne L_8c0418
L_8c0398:
	lsr.f lp_count,r4
L_8c039c:
	sub r1,r1,0x4
L_8c03a0:
	sub r3,r0,0x4
L_8c03a4:
	lpne L_8c03c8
L_8c03a8:
	ld.a r4,[r1,0x4]
L_8c03ac:
	ld.a r5,[r1,0x4]
L_8c03b0:
	ld.a r6,[r1,0x4]
L_8c03b4:
	ld.a r7,[r1,0x4]
L_8c03b8:
	st.a r4,[r3,0x4]
L_8c03bc:
	st.a r5,[r3,0x4]
L_8c03c0:
	st.a r6,[r3,0x4]
L_8c03c4:
	st.a r7,[r3,0x4]
	.global L_8c03c8
L_8c03c8:
	bcs.d L_8c03f4
L_8c03cc:
	and.f 0x0,r2,0x4
L_8c03d0:
	bne.d L_8c040c
	.global L_8c03d4
L_8c03d4:
	and.f lp_count,r2,0x3
	.global L_8c03d8
L_8c03d8:
	add r1,r1,0x3
L_8c03dc:
	jeq [blink]
L_8c03e0:
	add r3,r3,0x3
L_8c03e4:
	lp L_8c03f0
L_8c03e8:
	ldb.a r4,[r1,0x1]
L_8c03ec:
	stb.a r4,[r3,0x1]
	.global L_8c03f0
L_8c03f0:
	j [blink]
	.global L_8c03f4
L_8c03f4:
	ld.a r4,[r1,0x4]
L_8c03f8:
	ld.a r5,[r1,0x4]
L_8c03fc:
	st.a r4,[r3,0x4]
L_8c0400:
	beq.d L_8c03d4
L_8c0404:
	st.a r5,[r3,0x4]
L_8c0408:
	and.f lp_count,r2,0x3
	.global L_8c040c
L_8c040c:
	ld.a r4,[r1,0x4]
L_8c0410:
	b.d L_8c03d8
L_8c0414:
	st.a r4,[r3,0x4]
	.global L_8c0418
L_8c0418:
	sub r1,r1,0x1
L_8c041c:
	sub r3,r0,0x1
L_8c0420:
	lp L_8c042c
L_8c0424:
	ldb.a r4,[r1,0x1]
L_8c0428:
	stb.a r4,[r3,0x1]
	.global L_8c042c
L_8c042c:
	j [blink]
