/* mac__load_tx_vector @ 0x926d08, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run, rx_funcs__rx_flow, tx_rate_select_and_program
 */
	.section .text.mac__load_tx_vector,"ax",@progbits
	.global mac__load_tx_vector
mac__load_tx_vector:
	.global L_926d08
L_926d08:
	ld r6,[r0]
L_926d0c:
	mov r5,0x886000
L_926d14:
	st r6,[r5, 0x5c]
L_926d18:
	ld r4,[r0, 0x4]
L_926d1c:
	add r1,r0,0x8
L_926d20:
	st r4,[r5, 0x60]
L_926d24:
	ld_s r2,[r1]
L_926d26:
	st r2,[r5, 0x64]
L_926d2a:
	ld_s r3,[r0,0xc]
L_926d2c:
	st r3,[r5, 0x68]
L_926d30:
	j_s [blink]
L_926d32:
	nop_s
