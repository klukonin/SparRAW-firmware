/* fsched__cur_entry_byte0 @ 0x927dbc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fixed_sched__check_slot_flag, fixed_sched__slot_setup, fsched_ap__poll_station, l1_fixed_sched_ap__ev4_state2, l1_fixed_sched_ap__ev4_state4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__cur_entry_byte0
fsched__cur_entry_byte0:
	.global L_927dbc
L_927dbc:
	ldb r1,[r0, 0x28]
L_927dc0:
	add2_s r1,r1,r1
L_927dc2:
	j_s.d [blink]
L_927dc4:
	ldb_s r0,[r0,r1]
L_927dc6:
	nop_s
