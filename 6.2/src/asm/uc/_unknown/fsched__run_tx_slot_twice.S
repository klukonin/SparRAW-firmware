/* fsched__run_tx_slot_twice @ 0x938a18, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap_sm
 * Зовёт сам: __ld_r13_to_r13_ret, fixed_sched__run_tx_slot, fsched__get_cur_idx, fsched_slot__clear_f3, mac__read_usec_to_tbtt_uc, mac__set_sector_arg_and_select_all
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__run_tx_slot_twice
fsched__run_tx_slot_twice:
	.global L_938a18
L_938a18:
	push_s blink
L_938a1a:
	push_s r13
L_938a1c:
	mov_s r13,0x801be8
L_938a22:
	bl.d L_927d54
L_938a26:
	mov_s r0,r13
L_938a28:
	bl.d L_937550
L_938a2c:
	mov_s r0,0x0
L_938a2e:
	bl L_9351ec
L_938a32:
	bl.d L_924f94
L_938a36:
	mov_s r0,r13
L_938a38:
	bl L_93768c
L_938a3c:
	mov r0,0x190
L_938a40:
	mov lp_count,r0
L_938a44:
	nop_s
L_938a46:
	lp L_938a4e
L_938a4a:
	nop_s
L_938a4c:
	nop_s
	.global L_938a4e
L_938a4e:
	bl L_93768c
L_938a52:
	mov_s r1,0x4
L_938a54:
	mov_s r0,0x80064c
L_938a5a:
	st_s r1,[r0]
L_938a5c:
	b.d L_9202ac
L_938a60:
	mov_s r0,0x0
L_938a62:
	nop_s
