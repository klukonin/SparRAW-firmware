/* l2_mgr__wmi_scan_cmd @ 0x8f3710, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_scan_cmd() SCAN CMD (Type = %d, Number of channels = %d)
 *   l2_mgr::wmi_scan_cmd() PROHIBITs cids 0x%x of MID#%d
 * Зовут его: low_sme__wmi_scan_cmd_handler
 * Зовёт сам: L2MGR__system_state_evt_handler, __ld_r18_to_r13_ret, __st_r18_to_r13, bitmap__alloc_bit, bitmap__any_free, bitmap__init, fw_log__emit2, get_g_8000ac_8e15e0, get_g_800242, l2_mgr__scan_start_log, lm_if__inject_evt9, mid_list__by_mid
 */
	.section .text.l2_mgr__wmi_scan_cmd,"ax",@progbits
	.global l2_mgr__wmi_scan_cmd
l2_mgr__wmi_scan_cmd:
	.global L_8f3710
L_8f3710:
	push_s blink
L_8f3712:
	bl L_8c02b4
L_8f3716:
	sub_s sp,sp,0x4
L_8f3718:
	mov_s r16,r0
L_8f371a:
	mov_s r18,r1
L_8f371c:
	mov_s r13,0x0
L_8f371e:
	bl.d L_8e15e0
L_8f3722:
	mov_s r0,r13
L_8f3724:
	bl L_8ca258
L_8f3728:
	mov_s r1,r0
L_8f372a:
	mov_s r0,sp
L_8f372c:
	bl.d L_8e1140
L_8f3730:
	mov_s r17,r0
L_8f3732:
	b_s L_8f374c
	.global L_8f3734
L_8f3734:
	bl.d L_8db194
L_8f3738:
	mov_s r0,r17
L_8f373a:
	bl L_8ca1b0
L_8f373e:
	mov_s r14,r0
L_8f3740:
	bl.d L_8ca1f8
L_8f3744:
	mov_s r1,0x1
L_8f3746:
	mov.f r15,r0
L_8f374a:
	bne_s L_8f378e
	.global L_8f374c
L_8f374c:
	bl.d L_8cb680
L_8f3750:
	mov_s r0,r17
L_8f3752:
	brne_s r0,0,L_8f3734
L_8f3754:
	bl.d L_8ca1b0
L_8f3758:
	mov_s r0,r18
L_8f375a:
	mov_s r17,r0
L_8f375c:
	mov_s r2,0x100ce78
L_8f3762:
	ldb r4,[r16, 0x11]
L_8f3766:
	mov_s r0,0x9
L_8f3768:
	mov_s r1,0x2
L_8f376a:
	bl.d L_8edff8
L_8f376e:
	ldb r3,[r16, 0x10]
L_8f3772:
	mov_s r0,0x2
L_8f3774:
	bl.d L_8e3a08
L_8f3778:
	mov_s r1,0x0
L_8f377a:
	mov_s r0,r17
L_8f377c:
	add r0,r0,0x234
L_8f3780:
	mov_s r1,r16
L_8f3782:
	bl.d L_8f0134
L_8f3786:
	mov_s r2,r13
L_8f3788:
	b.d L_8c0314
L_8f378c:
	add_s sp,sp,0x4
	.global L_8f378e
L_8f378e:
	ldb r13,[r14, 0x24]
L_8f3792:
	ldb r4,[r14, 0x10]
L_8f3796:
	mov_s r2,0x100cec0
L_8f379c:
	mov_s r0,0x9
L_8f379e:
	mov_s r1,0x2
L_8f37a0:
	bl.d L_8edff8
L_8f37a4:
	mov_s r3,r13
L_8f37a6:
	bl.d L_8dd0b4
L_8f37aa:
	mov_s r0,r13
L_8f37ac:
	mov_s r13,r0
L_8f37ae:
	bl.d L_8dc008
L_8f37b2:
	add2 r0,r15,0x19
L_8f37b6:
	b_s L_8f374c
