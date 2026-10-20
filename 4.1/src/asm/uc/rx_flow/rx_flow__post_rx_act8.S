/* rx_flow__post_rx_act8 @ 0x92ea50, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: rx_flow__post_rx_tail, rx_flow__send_imm_response, rx_rfc_step
 */
	.section .text.rx_flow__post_rx_act8,"ax",@progbits
	.global rx_flow__post_rx_act8
rx_flow__post_rx_act8:
L_92ea50:
	bl L_9313e8
L_92ea54:
	mov r0,r14
L_92ea58:
	bl.d L_92f12c
L_92ea5c:
	mov r1,0x3
L_92ea60:
	b L_92ea78
