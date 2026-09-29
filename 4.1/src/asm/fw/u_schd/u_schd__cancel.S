/* u_schd__cancel @ 0x8c7794, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   u_schd.cpp
 * Зовут его: PS_ASSOC_SM__ps_cancel_schd_reenter, WBE_DRIVER__HOST_8edad4, WBE_DRIVER__link_down, ba_setup_sm__close_addba_req_retry_timeout_event, ba_setup_sm__close_addba_resp_timeout, ba_setup_sm__close_ba_setup_global_timeout, calib_engine__on_abort, calib_mngr__cancel_scheme_step, channels_switch_sm__action_abort_dwelling, channels_switch_sm__action_pop_ch_and_tune
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal, llist__remove, mem_pool__free_locked, u_schd__arm_timer
 * Глобалы (через gp): 0x800245
 */
	.section .text.u_schd__cancel,"ax",@progbits
	.global u_schd__cancel
u_schd__cancel:
	.global L_8c7794
L_8c7794:
	push_s blink
L_8c7796:
	bl L_8c02b4
L_8c779a:
	mov.f r13,r0
L_8c779e:
	beq_s L_8c7810
	.global L_8c77a0
L_8c77a0:
	ld_s r0,[r13,0x24]
L_8c77a2:
	breq r0,0x0,L_8c7826
	.global L_8c77a6
L_8c77a6:
	mov_s r1,0x0
L_8c77a8:
	lr r17,[0xa]
L_8c77ac:
	bclr r0,r17,0x1
L_8c77b0:
	flag r0
L_8c77b4:
	mov_s r14,0x0
L_8c77b6:
	b_s L_8c77ea
	.global L_8c77b8
L_8c77b8:
	ld_s r2,[r13,0x4]
L_8c77ba:
	mov_s r15,0x8034a8
L_8c77c0:
	add2_s r15,r15,r14
L_8c77c2:
	ld_s r0,[r15]
L_8c77c4:
	brne r2,r0,L_8c77e8
L_8c77c8:
	ld r16,[r0, 0x4]
L_8c77cc:
	bl.d L_8de4ec
L_8c77d0:
	mov_s r1,r13
L_8c77d2:
	ld_s r0,[r15]
L_8c77d4:
	ld_s r1,[r0,0x4]
L_8c77d6:
	ldb_s r0,[gp,0xd5]
L_8c77d8:
	mov r18,0x1
L_8c77dc:
	brne r14,r0,L_8c77e6
L_8c77e0:
	cmp_s r1,r16
L_8c77e2:
	bl.ne L_8de094
	.global L_8c77e6
L_8c77e6:
	mov_s r1,r18
	.global L_8c77e8
L_8c77e8:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8c77ea
L_8c77ea:
	brlt r14,0x2,L_8c77b8
L_8c77ee:
	brne_s r1,0,L_8c77f8
L_8c77f0:
	ld_s r0,[r13,0x4]
L_8c77f2:
	bl.d L_8de4ec
L_8c77f6:
	mov_s r1,r13
	.global L_8c77f8
L_8c77f8:
	lr r1,[0xa]
L_8c77fc:
	and r0,r17,0x2
L_8c7800:
	or_s r0,r0,r1
L_8c7802:
	flag r0
L_8c7806:
	bl.d L_8c93f4
L_8c780a:
	mov_s r0,r13
L_8c780c:
	b L_8c0314
	.global L_8c7810
L_8c7810:
	mov_s r0,blink
L_8c7812:
	mov_s r2,0x1001708
L_8c7818:
	mov_s r1,0x69
L_8c781a:
	bset_s r1,r1,0xc
L_8c781c:
	bl.d L_8c82c0
L_8c7820:
	mov r3,0x10e
L_8c7824:
	b_s L_8c77a0
	.global L_8c7826
L_8c7826:
	mov_s r0,blink
L_8c7828:
	mov_s r2,0x1001708
L_8c782e:
	mov_s r1,0x6a
L_8c7830:
	bset_s r1,r1,0xc
L_8c7832:
	bl.d L_8c82c0
L_8c7836:
	mov r3,0x110
L_8c783a:
	b_s L_8c77a6
