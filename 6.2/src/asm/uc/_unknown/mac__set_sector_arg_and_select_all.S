/* mac__set_sector_arg_and_select_all @ 0x9351ec, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: delay_800_iters, fsched__run_tx_slot_twice, l1_fixed_sched_ap__ev4_state2, l1_fixed_sched_ap__ev4_state4
 * Зовёт сам: mac__select_all_sectors_and_wait
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__set_sector_arg_and_select_all
mac__set_sector_arg_and_select_all:
	.global L_9351ec
L_9351ec:
	mov_s r1,0x886d00
L_9351f2:
	st_s r0,[r1,0x50]
L_9351f4:
	b L_936870
