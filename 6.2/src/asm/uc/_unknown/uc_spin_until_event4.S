/* uc_spin_until_event4 @ 0x9366d0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__respond_flow, bcon_txss_sweep_step, mac_mode_kick, uc_spin_until_event4__r0_100
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_spin_until_event4
uc_spin_until_event4:
	.global L_9366d0
L_9366d0:
	tst r54,r0
L_9366d4:
	jne [blink]
L_9366d8:
	b_s L_9366d0
L_9366da:
	nop_s
