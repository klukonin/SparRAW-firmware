/* swc_psc_sm__action_stop_dwelling @ 0x8c23f4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   swc_psc_sm::action_stop_dwelling - Entry
 *   swc_psc_sm::action_stop_dwelling - Exit
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global swc_psc_sm__action_stop_dwelling
swc_psc_sm__action_stop_dwelling:
	.global L_8c23f4
L_8c23f4:
	push_s blink
L_8c23f6:
	push_s r13
L_8c23f8:
	mov_s r13,r0
L_8c23fa:
	mov_s r1,0x1017888
L_8c2400:
	bl.d L_8dcba8
L_8c2404:
	mov_s r0,0x29
L_8c2406:
	ld_s r0,[r13,0x8]
L_8c2408:
	mov_s r1,0x7
L_8c240a:
	ld r0,[r0, 0x80]
L_8c240e:
	mov_s r2,0x0
L_8c2410:
	mov_s r3,r2
L_8c2412:
	bl.d L_8d9b6c
L_8c2416:
	mov_s r4,r2
L_8c2418:
	mov_s r1,0x10178b4
L_8c241e:
	bl.d L_8dcba8
L_8c2422:
	mov_s r0,0x29
L_8c2424:
	b L_8c025c
