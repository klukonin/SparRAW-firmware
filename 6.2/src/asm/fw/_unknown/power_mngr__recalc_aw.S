/* power_mngr__recalc_aw @ 0x8e16d8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   POWER_MNGR:: Number of connection: %d, curr_awake_window: %d next_awake_window: %d
 * Зовут его: power_mgr_ut__dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit3, mid__count_active_conns, mid__get_aw_len, mid__update_aw_ie, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mngr__recalc_aw
power_mngr__recalc_aw:
	.global L_8e16d8
L_8e16d8:
	push_s blink
L_8e16da:
	bl.d L_8c01dc
L_8e16de:
	mov_s r0,0x0
L_8e16e0:
	bl.d L_8cc3dc
L_8e16e4:
	mov r16,0x3e8
L_8e16e8:
	mov_s r15,r0
L_8e16ea:
	add3 r13,r0,0x9
L_8e16ee:
	bl.d L_8cb914
L_8e16f2:
	mov_s r0,r13
L_8e16f4:
	mov_s r14,r0
L_8e16f6:
	bl.d L_8cc66c
L_8e16fa:
	mov_s r0,r15
L_8e16fc:
	mov_s r2,r0
L_8e16fe:
	mov_s r1,0x1001f78
L_8e1704:
	mov_s r0,0x2e
L_8e1706:
	mov_s r3,r14
L_8e1708:
	bl.d L_8dcd00
L_8e170c:
	mov r4,r16
L_8e1710:
	cmp_s r14,r16
L_8e1712:
	mov.ne r0,r13
L_8e1716:
	mov.ne r1,0x9d
L_8e171e:
	bl.ne.d L_8c3a04
L_8e1722:
	mov.ne r2,r16
L_8e1726:
	b L_8c0244
L_8e172a:
	nop_s
