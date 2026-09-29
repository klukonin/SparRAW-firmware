/* channels_switch_sm__action_radio_tunned @ 0x8c22ec, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_radio_tunned(p1-%d)
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, scan_mngr__sm_ready_for_dwelling
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__action_radio_tunned
channels_switch_sm__action_radio_tunned:
	.global L_8c22ec
L_8c22ec:
	push_s blink
L_8c22ee:
	push_s r13
L_8c22f0:
	mov_s r13,r0
L_8c22f2:
	mov_s r2,r1
L_8c22f4:
	mov_s r1,0x1017430
L_8c22fa:
	bl.d L_8dcc10
L_8c22fe:
	mov_s r0,0x29
L_8c2300:
	bl.d L_8f9160
L_8c2304:
	ld_s r0,[r13,0x8]
L_8c2306:
	b L_8c025c
L_8c230a:
	nop_s
