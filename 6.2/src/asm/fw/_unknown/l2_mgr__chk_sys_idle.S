/* l2_mgr__chk_sys_idle @ 0x8c6508, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__send_discovery_stopped, maintain_sm__reset_rate_params, mlme_sm__disconnect_ev_handle, sys_state__broadcast
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_sysassert_fatal, mid__count_active_conns, mid_list__by_mid_fw, mids__get_count
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__chk_sys_idle
l2_mgr__chk_sys_idle:
	.global L_8c6508
L_8c6508:
	push_s blink
L_8c650a:
	bl L_8c01e0
L_8c650e:
	bl.d L_8cc484
L_8c6512:
	sub_s sp,sp,0x4
L_8c6514:
	mov_s r1,r0
L_8c6516:
	mov_s r14,sp
L_8c6518:
	bl.d L_8e5dfc
L_8c651c:
	mov_s r0,r14
L_8c651e:
	mov_s r15,0x1
L_8c6520:
	b_s L_8c653a
	.global L_8c6522
L_8c6522:
	bl.d L_8df444
L_8c6526:
	mov_s r0,r14
L_8c6528:
	bl L_8cc3dc
L_8c652c:
	mov.f r13,r0
L_8c6530:
	beq_s L_8c654a
	.global L_8c6532
L_8c6532:
	bl.d L_8cc66c
L_8c6536:
	mov_s r0,r13
L_8c6538:
	brne_s r0,0,L_8c6558
	.global L_8c653a
L_8c653a:
	bl.d L_8cdcc4
L_8c653e:
	mov_s r0,r14
L_8c6540:
	brne_s r0,0,L_8c6522
L_8c6542:
	mov_s r0,r15
L_8c6544:
	b.d L_8c024c
L_8c6548:
	add_s sp,sp,0x4
	.global L_8c654a
L_8c654a:
	mov_s r0,blink
L_8c654c:
	mov_s r1,0x16c5
L_8c6552:
	bl L_8c9b28
L_8c6556:
	b_s L_8c6532
	.global L_8c6558
L_8c6558:
	mov_s r15,0x0
L_8c655a:
	b_s L_8c653a
