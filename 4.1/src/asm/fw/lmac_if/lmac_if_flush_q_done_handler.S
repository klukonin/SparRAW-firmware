/* lmac_if_flush_q_done_handler @ 0x8d8524, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: vring_schd__flush_response
 */
	.section .text.lmac_if_flush_q_done_handler,"ax",@progbits
	.global lmac_if_flush_q_done_handler
lmac_if_flush_q_done_handler:
	.global L_8d8524
L_8d8524:
	b.d L_8d9b58
L_8d8528:
	ld_s r0,[r0]
L_8d852a:
	nop_s
