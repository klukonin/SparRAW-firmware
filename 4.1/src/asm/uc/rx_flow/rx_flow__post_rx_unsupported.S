/* rx_flow__post_rx_unsupported @ 0x92ea64, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rx_flow.c
 * Зовут его: rx_flow__handle_frame
 * Зовёт сам: uc_sysassert
 */
	.section .text.rx_flow__post_rx_unsupported,"ax",@progbits
	.global rx_flow__post_rx_unsupported
rx_flow__post_rx_unsupported:
	.global L_92ea64
L_92ea64:
	mov_s r0,blink
L_92ea66:
	mov_s r2,0x10010dc
L_92ea6c:
	mov r1,0x42
L_92ea70:
	bl.d L_925548
L_92ea74:
	mov r3,0x4e8
