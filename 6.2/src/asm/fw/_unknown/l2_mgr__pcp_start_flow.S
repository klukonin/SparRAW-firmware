/* l2_mgr__pcp_start_flow @ 0x8e0778, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCP Start failed, MAC address error
 *   PCP Start handle channel id %d  bcon_interval_msec %d networkType = %x
 *   PBSS PCP Start DMG Information flow start networkType = %d WMI_NETTYPE_P2P = %d.
 *   PCP Start failed, BSS not ready or channel is not valid bss_mode: %d, bss_state:%d, channel:%d
 * Зовут его: l2_mgr__pcp_start
 * Зовёт сам: RADIO_MGR__set_primary_channel, __ld_r21_to_r13_ret, __st_r21_to_r13, bss_set_active, bss_set_mode, field_set_0x58__8e6788, fw_log_emit0, fw_log_emit2, fw_log_emit3, mac_parser__set_886260, mid__log_network_type, pcp_start
 * Глобалы (через gp): 0x8002d4, 0x8003f8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__pcp_start_flow
l2_mgr__pcp_start_flow:
	.global L_8e0778
L_8e0778:
	push_s blink
L_8e077a:
	bl L_8c01c8
L_8e077e:
	mov_s r13,r0
L_8e0780:
	mov_s r19,r1
L_8e0782:
	mov_s r14,r2
L_8e0784:
	mov_s r15,0x0
L_8e0786:
	st.as r15,[r0,0xaa]
L_8e078a:
	ldw_s r0,[r0,0xa]
L_8e078c:
	mov r18,r4
L_8e0790:
	bxor r0,r0,0x0
L_8e0794:
	mov_s r21,r3
L_8e0796:
	mov r16,r5
L_8e079a:
	bbit1 r0,0x0,L_8e07ac
L_8e079e:
	mov_s r1,0x100cd48
L_8e07a4:
	bl.d L_8dcba8
L_8e07a8:
	mov_s r0,0xb
L_8e07aa:
	b_s L_8e0872
	.global L_8e07ac
L_8e07ac:
	bl.d L_8e696c
L_8e07b0:
	mov_s r0,r13
L_8e07b2:
	stb_s r14,[r13,0x11]
L_8e07b4:
	add3 r14,r13,0x9
L_8e07b8:
	ld_s r3,[r14,0x4]
L_8e07ba:
	mov r17,0x803b80
L_8e07c2:
	ld r20,[r17]
L_8e07c6:
	breq r3,0x2,L_8e0860
L_8e07ca:
	ld.as r3,[gp,0x54]
L_8e07ce:
	mov_s r1,0x100cd6c
L_8e07d4:
	mov_s r0,0x2b
L_8e07d6:
	mov_s r2,r20
L_8e07d8:
	bl.d L_8dcd00
L_8e07dc:
	mov r4,r19
L_8e07e0:
	ldb r5,[r13, 0x10]
L_8e07e4:
	mov_s r0,r20
L_8e07e6:
	ld.as r3,[gp,0x54]
L_8e07ea:
	mov_s r1,r15
L_8e07ec:
	mov_s r2,r15
L_8e07ee:
	bl.d L_8e6cec
L_8e07f2:
	mov_s r4,r15
L_8e07f4:
	stb r20,[r14, 0x4c]
L_8e07f8:
	cmp r19,0x10
L_8e07fc:
	mov_s r0,r14
L_8e07fe:
	mov_s r1,0x3
L_8e0800:
	mov.ne r1,0x2
L_8e0804:
	bl L_8c4eec
L_8e0808:
	stb r18,[r14, 0x54]
L_8e080c:
	stb r16,[r14, 0x55]
L_8e0810:
	mov_s r0,r13
L_8e0812:
	bl.d L_8f7110
L_8e0816:
	add r0,r0,0x234
L_8e081a:
	mov_s r0,r14
L_8e081c:
	bl.d L_8e6788
L_8e0820:
	mov_s r1,r21
L_8e0822:
	ld r0,[r17, 0x8c]
L_8e0826:
	breq_s r0,0,L_8e0842
L_8e0828:
	mov_s r1,0x100cdb4
L_8e082e:
	mov_s r0,0x2b
L_8e0830:
	mov_s r2,r19
L_8e0832:
	bl.d L_8dcc80
L_8e0836:
	mov_s r3,0x20
L_8e0838:
	brne r19,0x20,L_8e0842
L_8e083c:
	bl.d L_8d8750
L_8e0840:
	ldb_s r0,[r13,0x10]
	.global L_8e0842
L_8e0842:
	bl.d L_8c4ec8
L_8e0846:
	mov_s r0,r14
L_8e0848:
	ld_s r0,[gp,0x274]
L_8e084a:
	cmp_s r0,0x0
L_8e084c:
	mov.ne r1,0x3f02
L_8e0854:
	bl.ne.d L_8dfbbc
L_8e0858:
	mov.ne r0,0x2
L_8e085c:
	mov_s r0,0x0
L_8e085e:
	b_s L_8e0874
	.global L_8e0860
L_8e0860:
	ld_s r2,[r14,0x8]
L_8e0862:
	mov_s r1,0x100ce08
L_8e0868:
	mov_s r0,0xb
L_8e086a:
	bl.d L_8dcd00
L_8e086e:
	mov r4,r20
	.global L_8e0872
L_8e0872:
	mov_s r0,0x1
	.global L_8e0874
L_8e0874:
	b L_8c021c
