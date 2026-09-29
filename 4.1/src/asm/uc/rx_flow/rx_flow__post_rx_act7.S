/* rx_flow__post_rx_act7 @ 0x92ea28, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: rx__send_response_frame, rx_flow__post_rx_tail, rx_rfc_step
 */
	.section .text.rx_flow__post_rx_act7,"ax",@progbits
	.global rx_flow__post_rx_act7
rx_flow__post_rx_act7:
L_92ea28:
	bl L_93137c
L_92ea2c:
	mov r0,r14
L_92ea30:
	bl.d L_92f12c
L_92ea34:
	mov r1,0x8
L_92ea38:
	b L_92ea78
