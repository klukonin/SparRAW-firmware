/* sm_802f58__action_8e2be4 @ 0x8e2be4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, link_stats__report, sm_802f58__on_evt_latency_timer_in_active
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_802f58__action_8e2be4
sm_802f58__action_8e2be4:
	.global L_8e2be4
L_8e2be4:
	push_s blink
L_8e2be6:
	push_s r13
L_8e2be8:
	mov_s r13,r0
L_8e2bea:
	bl.d L_8da73c
L_8e2bee:
	mov_s r1,0x0
L_8e2bf0:
	mov_s r0,r13
L_8e2bf2:
	bl.d L_8e7cf8
L_8e2bf6:
	mov_s r1,0x0
L_8e2bf8:
	b L_8c025c
