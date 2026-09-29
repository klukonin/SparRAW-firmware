/* event_flush_q_done @ 0x8db7f0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: vring_schd__flush_response
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global event_flush_q_done
event_flush_q_done:
	.global L_8db7f0
L_8db7f0:
	b.d L_8dda68
L_8db7f4:
	ld_s r0,[r0]
L_8db7f6:
	nop_s
