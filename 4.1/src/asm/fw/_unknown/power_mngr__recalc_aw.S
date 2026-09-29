/* power_mngr__recalc_aw @ 0x8dd500, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   POWER_MNGR:: Number of connection: %d, curr_awake_window: %d next_awake_window: %d
 * Зовут его: POWER_MNGR__system_state_evt_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit3, mid__get_awake_window, mid__update_aw_ie, mid_list__by_mid, mid_list__count_free
 */
	.section .text.power_mngr__recalc_aw,"ax",@progbits
	.global power_mngr__recalc_aw
power_mngr__recalc_aw:
	.global L_8dd500
L_8dd500:
	push_s blink
L_8dd502:
	bl.d L_8c02bc
L_8dd506:
	mov_s r0,0x0
L_8dd508:
	bl.d L_8ca1b0
L_8dd50c:
	mov r15,0x3e8
L_8dd510:
	mov_s r14,r0
L_8dd512:
	add3 r13,r0,0x9
L_8dd516:
	bl.d L_8c989c
L_8dd51a:
	mov_s r0,r13
L_8dd51c:
	mov_s r16,r0
L_8dd51e:
	bl.d L_8ca464
L_8dd522:
	mov_s r0,r14
L_8dd524:
	mov_s r3,r0
L_8dd526:
	mov_s r2,0x10020c0
L_8dd52c:
	mov_s r0,0xe
L_8dd52e:
	mov_s r1,0x2
L_8dd530:
	mov r4,r16
L_8dd534:
	bl.d L_8ee034
L_8dd538:
	mov_s r5,r15
L_8dd53a:
	cmp_s r15,r16
L_8dd53c:
	mov.ne r0,r13
L_8dd540:
	mov.ne r1,0x9d
L_8dd548:
	bl.ne.d L_8c30fc
L_8dd54c:
	mov.ne r2,r15
L_8dd550:
	b L_8c0324
