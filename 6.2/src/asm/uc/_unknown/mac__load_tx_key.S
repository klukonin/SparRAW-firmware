/* mac__load_tx_key @ 0x9294ac, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run, rx_funcs__rx_flow, tx_bcast_flow, txop_initiator_open_txop_flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__load_tx_key
mac__load_tx_key:
	.global L_9294ac
L_9294ac:
	ld r6,[r0]
L_9294b0:
	mov r5,0x886000
L_9294b8:
	st r6,[r5, 0x5c]
L_9294bc:
	ld r4,[r0, 0x4]
L_9294c0:
	add r1,r0,0x8
L_9294c4:
	st r4,[r5, 0x60]
L_9294c8:
	ld_s r2,[r1]
L_9294ca:
	st r2,[r5, 0x64]
L_9294ce:
	ld_s r3,[r0,0xc]
L_9294d0:
	st r3,[r5, 0x68]
L_9294d4:
	j_s [blink]
L_9294d6:
	nop_s
