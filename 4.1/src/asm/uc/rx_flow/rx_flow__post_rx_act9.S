/* rx_flow__post_rx_act9 @ 0x92ea3c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: direct_tx_rx_step, rx_flow__post_rx_tail, rx_rfc_step
 */
	.section .text.rx_flow__post_rx_act9,"ax",@progbits
	.global rx_flow__post_rx_act9
rx_flow__post_rx_act9:
L_92ea3c:
	bl L_931434
L_92ea40:
	mov r0,r14
L_92ea44:
	bl.d L_92f12c
L_92ea48:
	mov r1,0xa
L_92ea4c:
	b L_92ea78
