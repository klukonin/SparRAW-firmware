/* fsched__arm_slot_timer @ 0x925014, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched__rx_slot, fsched_ap__start_slot, l1_fixed_sched_ap__ev4_state2, l1_fixed_sched_ap__ev4_state4
 * Зовёт сам: __ld_r13_to_r13_ret, sxd_hal__write_qset_field
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__arm_slot_timer
fsched__arm_slot_timer:
	.global L_925014
L_925014:
	push_s blink
L_925016:
	push_s r13
L_925018:
	mov_s r2,0x2
L_92501a:
	mov_s r1,0x80064c
L_925020:
	cmp_s r0,0x0
L_925022:
	st_s r2,[r1]
L_925024:
	mov.eq r0,0x4
L_925028:
	beq_s L_92503a
L_92502a:
	mulu64 r0,0xa5
L_92502e:
	mov_s r13,0x0
L_925030:
	mov_s r0,r13
L_925032:
	bl.d L_934f54
L_925036:
	mov_s r1,mlo
L_925038:
	mov_s r0,r13
	.global L_92503a
L_92503a:
	b L_9202ac
L_92503e:
	nop_s
