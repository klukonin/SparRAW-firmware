/* uc_spin_until_event4 @ 0x9317f0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder_worker, bi_dti__sleep_and_resume, cf_end__pulse_883150, mac_mode_kick
 */
	.section .text.uc_spin_until_event4,"ax",@progbits
	.global uc_spin_until_event4
uc_spin_until_event4:
	.global L_9317f0
L_9317f0:
	tst r54,r0
L_9317f4:
	jne [blink]
L_9317f8:
	b_s L_9317f0
L_9317fa:
	nop_s
