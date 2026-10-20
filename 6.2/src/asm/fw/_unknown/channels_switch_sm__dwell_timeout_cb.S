/* channels_switch_sm__dwell_timeout_cb @ 0x8c980c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::dwell_timeout_cb() dwell timeout !!!
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__dwell_timeout_cb
channels_switch_sm__dwell_timeout_cb:
	.global L_8c980c
L_8c980c:
	push_s blink
L_8c980e:
	push_s r13
L_8c9810:
	mov_s r13,r0
L_8c9812:
	mov_s r1,0x10175f8
L_8c9818:
	bl.d L_8dcba8
L_8c981c:
	mov_s r0,0x29
L_8c981e:
	mov_s r0,r13
L_8c9820:
	mov_s r1,0x4
L_8c9822:
	mov_s r2,0x0
L_8c9824:
	mov_s r3,r2
L_8c9826:
	bl.d L_8d9b6c
L_8c982a:
	mov_s r4,r2
L_8c982c:
	b L_8c025c
