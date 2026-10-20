/* l2_mgr__connect @ 0x8ea758, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::connect() MID = %d. NETWORK TYPE = 0x%X. TEST MODE = %d
 *   l2_mgr::connect() MID:[%d], BSSID: ADDR-%04X%08X
 *   l2_mgr::connect() PBC is obsolete
 *   layer2_mgr.cpp
 * Зовут его: wmi_handler_connect
 * Зовёт сам: L2MGR__system_state_evt_handler, RADIO_MGR__lock_primary, RADIO_MGR__set_primary_channel, __ld_r18_to_r13_ret, __st_r18_to_r13, bss_set_active, fw_log__emit0, fw_log__emit3, fw_sysassert_fatal, get_g_8000ac_8e15e0, l2mgr__apply_mac_address, mid__log_network_type
 * Глобалы (через gp): 0x8001fa, 0x8002c0
 */
	.section .text.l2_mgr__connect,"ax",@progbits
	.global l2_mgr__connect
l2_mgr__connect:
	.global L_8ea758
L_8ea758:
	push_s blink
L_8ea75a:
	bl.d L_8c02b4
L_8ea75e:
	mov_s r2,0x1
L_8ea760:
	mov_s r14,r0
L_8ea762:
	mov_s r13,r1
L_8ea764:
	bl.d L_8e15e0
L_8ea768:
	mov_s r0,r2
L_8ea76a:
	add r15,r14,0x20
L_8ea76e:
	ld_s r1,[r15,0x14]
L_8ea770:
	mov_s r0,0x805bd4
L_8ea776:
	st_s r1,[r0]
L_8ea778:
	ldw_s r1,[r15,0x18]
L_8ea77a:
	mov_s r17,r0
L_8ea77c:
	stw_s r1,[r0,0x4]
L_8ea77e:
	mov_s r0,0x80345c
L_8ea784:
	ld_s r0,[r0,0x18]
L_8ea786:
	bbit0 r0,0x0,L_8ea790
L_8ea78a:
	stw.as r2,[gp,0x45]
L_8ea78e:
	b_s L_8ea796
	.global L_8ea790
L_8ea790:
	ldb_s r0,[r15,0x1a]
L_8ea792:
	stw.as r0,[gp,0x45]
	.global L_8ea796
L_8ea796:
	st.as r13,[gp,-0x2f]
L_8ea79a:
	bl.d L_8ca1b0
L_8ea79e:
	mov_s r0,r13
L_8ea7a0:
	mov_s r16,r0
L_8ea7a2:
	ldb r4,[r14]
L_8ea7a6:
	mov_s r2,0x100db10
L_8ea7ac:
	ldw.as r5,[gp,0x45]
L_8ea7b0:
	mov_s r0,0xb
L_8ea7b2:
	mov_s r1,0x2
L_8ea7b4:
	bl.d L_8ee034
L_8ea7b8:
	mov_s r3,r13
L_8ea7ba:
	mov_s r0,r16
L_8ea7bc:
	bl.d L_8e1b34
L_8ea7c0:
	ldb_s r1,[r14]
L_8ea7c2:
	add3 r0,r16,0x9
L_8ea7c6:
	mov_s r16,r0
L_8ea7c8:
	bl.d L_8e15f0
L_8ea7cc:
	add r1,r14,0x2a
L_8ea7d0:
	add.f r18,r16,0xc
L_8ea7d4:
	beq_s L_8ea852
	.global L_8ea7d6
L_8ea7d6:
	bl.d L_8e35cc
L_8ea7da:
	mov_s r0,0x5
L_8ea7dc:
	ldw r4,[r18, 0x4]
L_8ea7e0:
	mov_s r2,0x100db50
L_8ea7e6:
	ld r5,[r18]
L_8ea7ea:
	mov_s r0,0xb
L_8ea7ec:
	mov_s r1,0x2
L_8ea7ee:
	bl.d L_8ee034
L_8ea7f2:
	mov_s r3,r13
L_8ea7f4:
	bl.d L_8c456c
L_8ea7f8:
	mov_s r0,r16
L_8ea7fa:
	add r1,r14,0x8
L_8ea7fe:
	mov_s r0,r16
L_8ea800:
	bl.d L_8e2100
L_8ea804:
	ldb_s r2,[r14,0x7]
L_8ea806:
	ldb_s r0,[r14,0x1]
L_8ea808:
	brne r0,0x8,L_8ea81a
L_8ea80c:
	mov_s r2,0x100db84
L_8ea812:
	mov_s r0,0xb
L_8ea814:
	bl.d L_8edfb0
L_8ea818:
	mov_s r1,0x2
	.global L_8ea81a
L_8ea81a:
	mov_s r0,0x4
L_8ea81c:
	bl.d L_8e3a08
L_8ea820:
	mov_s r1,0x0
L_8ea822:
	ldb_s r0,[r15,0x8]
L_8ea824:
	mov r4,0x1
L_8ea828:
	ld r1,[r17, 0x8]
L_8ea82c:
	extb r16,r13
L_8ea830:
	ld r2,[r17, 0xc]
L_8ea834:
	ld.as r3,[gp,0x54]
L_8ea838:
	bl.d L_8e1ed8
L_8ea83c:
	mov r5,r16
L_8ea840:
	mov_s r0,0x2a128
L_8ea846:
	mov_s r1,0x0
L_8ea848:
	bl.d L_8d9288
L_8ea84c:
	mov_s r2,r16
L_8ea84e:
	b L_8c0314
	.global L_8ea852
L_8ea852:
	mov_s r0,blink
L_8ea854:
	mov_s r2,0x100c474
L_8ea85a:
	mov_s r1,0x11e2
L_8ea860:
	bl.d L_8c82c0
L_8ea864:
	mov r3,0x602
L_8ea868:
	b_s L_8ea7d6
L_8ea86a:
	nop_s
