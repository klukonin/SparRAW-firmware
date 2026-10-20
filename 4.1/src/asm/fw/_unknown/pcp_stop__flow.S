/* pcp_stop__flow @ 0x8dc660, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCP Stop -> primary channel was unset !!!
 *   PCP Stop failed, BSS not active m: %d, s:%d
 * Зовут его: l2_mgr__pcp_stop
 * Зовёт сам: RADIO_MGR__unset_primary_channel, __ld_r14_to_r13_ret, __st_r14_to_r13, bss_set_mode, fw_log__emit0, fw_log__emit2, l2mgr__send_pcp_stopped, obj__set_field4_one, pcp_stop, pcp_stop__cancel_timer, u_schd__cancel
 */
	.section .text.pcp_stop__flow,"ax",@progbits
	.global pcp_stop__flow
pcp_stop__flow:
	.global L_8dc660
L_8dc660:
	push_s blink
L_8dc662:
	bl L_8c02c4
L_8dc666:
	mov_s r13,r0
L_8dc668:
	ld.as r0,[r0,0xb8]
L_8dc66c:
	breq_s r0,0,L_8dc678
L_8dc66e:
	bl L_8c7794
L_8dc672:
	mov_s r0,0x0
L_8dc674:
	st.as r0,[r13,0xb8]
	.global L_8dc678
L_8dc678:
	add3 r14,r13,0x9
L_8dc67c:
	ld_s r0,[r14,0x4]
L_8dc67e:
	brne r0,0x2,L_8dc6c2
L_8dc682:
	ld_s r1,[r14,0x8]
L_8dc684:
	mov_s r0,0x0
L_8dc686:
	cmp_s r1,0x2
L_8dc688:
	cmp.ne r1,0x3
L_8dc68c:
	mov.eq r0,0x1
L_8dc690:
	extb.f 0x0,r0
L_8dc694:
	beq_s L_8dc6c2
L_8dc696:
	mov_s r0,r13
L_8dc698:
	bl.d L_8ef014
L_8dc69c:
	add r0,r0,0x234
L_8dc6a0:
	mov_s r0,r14
L_8dc6a2:
	bl.d L_8c4594
L_8dc6a6:
	mov_s r1,0x1
L_8dc6a8:
	bl.d L_8c458c
L_8dc6ac:
	mov_s r0,r14
L_8dc6ae:
	bl L_8e5568
L_8dc6b2:
	mov_s r2,0x100b94c
L_8dc6b8:
	mov_s r0,0xb
L_8dc6ba:
	bl.d L_8edfb0
L_8dc6be:
	mov_s r1,0x1
L_8dc6c0:
	b_s L_8dc6d6
	.global L_8dc6c2
L_8dc6c2:
	ld r4,[r14, 0x4]
L_8dc6c6:
	mov_s r2,0x100b978
L_8dc6cc:
	mov_s r0,0xb
L_8dc6ce:
	mov_s r1,0x0
L_8dc6d0:
	bl.d L_8edff8
L_8dc6d4:
	ld_s r3,[r14,0x8]
	.global L_8dc6d6
L_8dc6d6:
	mov_s r0,0x80345c
L_8dc6dc:
	ld_s r1,[r0,0xc]
L_8dc6de:
	cmp_s r1,0x0
L_8dc6e0:
	ldb_s r0,[r13,0x10]
L_8dc6e2:
	bl.ne L_8d5400
L_8dc6e6:
	bl.d L_8f07f4
L_8dc6ea:
	ldb_s r0,[r13,0x10]
L_8dc6ec:
	b L_8c0334
