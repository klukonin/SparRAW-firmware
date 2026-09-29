/* pcp_stop__flow @ 0x8e0878, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCP Stop -> primary channel was unset !!!
 *   PCP Stop failed, BSS not active m: %d, s:%d
 * Зовут его: l2_mgr__pcp_stop
 * Зовёт сам: RADIO_MGR__unset_primary_channel, __ld_r14_to_r13_ret, __st_r14_to_r13, bss_set_mode, fw_log_emit0, fw_log_emit2, l2mgr__send_pcp_stopped, obj__set_field4_one, pcp_stop, pcp_stop__cancel_timer, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_stop__flow
pcp_stop__flow:
	.global L_8e0878
L_8e0878:
	push_s blink
L_8e087a:
	bl L_8c01e4
L_8e087e:
	mov_s r13,r0
L_8e0880:
	ld.as r0,[r0,0xaa]
L_8e0884:
	breq_s r0,0,L_8e0890
L_8e0886:
	bl L_8c8de0
L_8e088a:
	mov_s r0,0x0
L_8e088c:
	st.as r0,[r13,0xaa]
	.global L_8e0890
L_8e0890:
	add3 r14,r13,0x9
L_8e0894:
	ld_s r0,[r14,0x4]
L_8e0896:
	brne r0,0x2,L_8e08d8
L_8e089a:
	ld_s r1,[r14,0x8]
L_8e089c:
	mov_s r0,0x0
L_8e089e:
	cmp_s r1,0x2
L_8e08a0:
	cmp.ne r1,0x3
L_8e08a4:
	mov.eq r0,0x1
L_8e08a8:
	extb.f 0x0,r0
L_8e08ac:
	beq_s L_8e08d8
L_8e08ae:
	mov_s r0,r13
L_8e08b0:
	bl.d L_8f720c
L_8e08b4:
	add r0,r0,0x234
L_8e08b8:
	mov_s r0,r14
L_8e08ba:
	bl.d L_8c4eec
L_8e08be:
	mov_s r1,0x1
L_8e08c0:
	bl.d L_8c4ee4
L_8e08c4:
	mov_s r0,r14
L_8e08c6:
	bl L_8ea87c
L_8e08ca:
	mov_s r1,0x100ce68
L_8e08d0:
	bl.d L_8dcba8
L_8e08d4:
	mov_s r0,0x1b
L_8e08d6:
	b_s L_8e08e8
	.global L_8e08d8
L_8e08d8:
	ld_s r2,[r14,0x8]
L_8e08da:
	mov_s r1,0x100ce94
L_8e08e0:
	mov_s r0,0xb
L_8e08e2:
	bl.d L_8dcc80
L_8e08e6:
	ld_s r3,[r14,0x4]
	.global L_8e08e8
L_8e08e8:
	mov_s r0,0x803c00
L_8e08ee:
	ld_s r1,[r0,0xc]
L_8e08f0:
	cmp_s r1,0x0
L_8e08f2:
	ldb_s r0,[r13,0x10]
L_8e08f4:
	bl.ne L_8d8778
L_8e08f8:
	bl.d L_8f8ac0
L_8e08fc:
	ldb_s r0,[r13,0x10]
L_8e08fe:
	b L_8c0254
L_8e0902:
	nop_s
