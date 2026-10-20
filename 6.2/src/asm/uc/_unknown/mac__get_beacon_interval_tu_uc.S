/* mac__get_beacon_interval_tu_uc @ 0x9374d8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__set_new_tbtt, aw_tbtt__count_intervals, sched__calc_next_start_tsf
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__get_beacon_interval_tu_uc
mac__get_beacon_interval_tu_uc:
	.global L_9374d8
L_9374d8:
	ld r0,[0x886d64]
L_9374e0:
	j.d [blink]
L_9374e4:
	extw_s r0,r0
L_9374e6:
	nop_s
