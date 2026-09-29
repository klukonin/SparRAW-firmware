/* mid_list__count_free @ 0x8ca464, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: assoc_ready_check_trig, l2_mgr__chk_sys_idle, mlme_sm__check_assoc_capacity, power_mngr__recalc_aw, wmi_add_key__pick_mid
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__has_more, iter__init, iter__next
 */
	.section .text.mid_list__count_free,"ax",@progbits
	.global mid_list__count_free
mid_list__count_free:
	.global L_8ca464
L_8ca464:
	push_s blink
L_8ca466:
	bl.d L_8c02c4
L_8ca46a:
	add r1,r0,0x18
L_8ca46e:
	sub_s sp,sp,0x4
L_8ca470:
	mov_s r13,sp
L_8ca472:
	bl.d L_8e1138
L_8ca476:
	mov_s r0,r13
L_8ca478:
	mov_s r14,0x0
L_8ca47a:
	b_s L_8ca488
	.global L_8ca47c
L_8ca47c:
	bl.d L_8db188
L_8ca480:
	mov_s r0,r13
L_8ca482:
	ldb r0,[r0, 0xb0]
L_8ca486:
	brne_s r0,0,L_8ca498
	.global L_8ca488
L_8ca488:
	bl.d L_8cb674
L_8ca48c:
	mov_s r0,r13
L_8ca48e:
	brne_s r0,0,L_8ca47c
L_8ca490:
	mov_s r0,r14
L_8ca492:
	b.d L_8c0334
L_8ca496:
	add_s sp,sp,0x4
	.global L_8ca498
L_8ca498:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8ca49a:
	b_s L_8ca488
