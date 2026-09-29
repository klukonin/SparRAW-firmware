/* memcpy_fw @ 0x8c0460, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SW_TX_MGMT_API__send_packet, UT_HW_DRIVERS_cmd_handler, UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, add_discovery_bcon, add_key, add_pbss_dmg_capinfo_list, app_ie__remove_tlv, boot__copy_name, boot__init_subsystems, calib_sar_step
 */
	.section .text.memcpy_fw,"ax",@progbits
	.global memcpy_fw
memcpy_fw:
	.global L_8c0460
L_8c0460:
	mov.f lp_count,r2
L_8c0464:
	or r4,r0,r1
L_8c0468:
	jeq [blink]
L_8c046c:
	and.f 0x0,r4,0x3
L_8c0470:
	lsr r4,r2,0x3
L_8c0474:
	bne L_8c04f8
L_8c0478:
	lsr.f lp_count,r4
L_8c047c:
	sub r1,r1,0x4
L_8c0480:
	sub r3,r0,0x4
L_8c0484:
	lpne L_8c04a8
L_8c0488:
	ld.a r4,[r1,0x4]
L_8c048c:
	ld.a r5,[r1,0x4]
L_8c0490:
	ld.a r6,[r1,0x4]
L_8c0494:
	ld.a r7,[r1,0x4]
L_8c0498:
	st.a r4,[r3,0x4]
L_8c049c:
	st.a r5,[r3,0x4]
L_8c04a0:
	st.a r6,[r3,0x4]
L_8c04a4:
	st.a r7,[r3,0x4]
	.global L_8c04a8
L_8c04a8:
	bcs.d L_8c04d4
L_8c04ac:
	and.f 0x0,r2,0x4
L_8c04b0:
	bne.d L_8c04ec
	.global L_8c04b4
L_8c04b4:
	and.f lp_count,r2,0x3
	.global L_8c04b8
L_8c04b8:
	add r1,r1,0x3
L_8c04bc:
	jeq [blink]
L_8c04c0:
	add r3,r3,0x3
L_8c04c4:
	lp L_8c04d0
L_8c04c8:
	ldb.a r4,[r1,0x1]
L_8c04cc:
	stb.a r4,[r3,0x1]
	.global L_8c04d0
L_8c04d0:
	j [blink]
	.global L_8c04d4
L_8c04d4:
	ld.a r4,[r1,0x4]
L_8c04d8:
	ld.a r5,[r1,0x4]
L_8c04dc:
	st.a r4,[r3,0x4]
L_8c04e0:
	beq.d L_8c04b4
L_8c04e4:
	st.a r5,[r3,0x4]
L_8c04e8:
	and.f lp_count,r2,0x3
	.global L_8c04ec
L_8c04ec:
	ld.a r4,[r1,0x4]
L_8c04f0:
	b.d L_8c04b8
L_8c04f4:
	st.a r4,[r3,0x4]
	.global L_8c04f8
L_8c04f8:
	sub r1,r1,0x1
L_8c04fc:
	sub r3,r0,0x1
L_8c0500:
	lp L_8c050c
L_8c0504:
	ldb.a r4,[r1,0x1]
L_8c0508:
	stb.a r4,[r3,0x1]
	.global L_8c050c
L_8c050c:
	j [blink]
