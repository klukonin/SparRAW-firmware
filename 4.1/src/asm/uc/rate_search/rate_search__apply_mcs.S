/* rate_search__apply_mcs @ 0x92c330, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo, brp__apply_slot_mcs, rate_search__step, txss__flow_body, txss_flow_step_b
 * Зовёт сам: hwd_mac__apply_timing_entry
 */
	.section .text.rate_search__apply_mcs,"ax",@progbits
	.global rate_search__apply_mcs
rate_search__apply_mcs:
	.global L_92c330
L_92c330:
	push_s blink
L_92c332:
	breq r1,0x8,L_92c348
L_92c336:
	mul64 r1,0x2c
L_92c33a:
	add r2,mlo,0x801755
L_92c342:
	bl.d L_926dd0
L_92c346:
	stb_s r0,[r2]
	.global L_92c348
L_92c348:
	pop_s blink
L_92c34a:
	j_s [blink]
