/* mid__count_active_conns @ 0x8cc66c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: assoc_ready_check_trig, l2_mgr__chk_sys_idle, mids__count_active_conns, mlme_sm__check_assoc_capacity, power_mngr__recalc_aw, wmi_add_key__pick_mid
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__count_active_conns
mid__count_active_conns:
	.global L_8cc66c
L_8cc66c:
	push_s blink
L_8cc66e:
	bl.d L_8c01e4
L_8cc672:
	add r1,r0,0x18
L_8cc676:
	sub_s sp,sp,0x4
L_8cc678:
	mov_s r13,sp
L_8cc67a:
	bl.d L_8e5df4
L_8cc67e:
	mov_s r0,r13
L_8cc680:
	mov_s r14,0x0
L_8cc682:
	b_s L_8cc690
	.global L_8cc684
L_8cc684:
	bl.d L_8df438
L_8cc688:
	mov_s r0,r13
L_8cc68a:
	ldb r0,[r0, 0xf0]
L_8cc68e:
	brne_s r0,0,L_8cc6a0
	.global L_8cc690
L_8cc690:
	bl.d L_8cdcb8
L_8cc694:
	mov_s r0,r13
L_8cc696:
	brne_s r0,0,L_8cc684
L_8cc698:
	mov_s r0,r14
L_8cc69a:
	b.d L_8c0254
L_8cc69e:
	add_s sp,sp,0x4
	.global L_8cc6a0
L_8cc6a0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cc6a2:
	b_s L_8cc690
