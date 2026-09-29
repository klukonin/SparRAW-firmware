/* rx_flow__latch_phy_8014e8__930da4 @ 0x930da4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 * Зовёт сам: phy__read_signal_gain_adc_db_sfd_locked
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_flow__latch_phy_8014e8__930da4
rx_flow__latch_phy_8014e8__930da4:
	.global L_930da4
L_930da4:
	push_s r13
L_930da6:
	mov_s r13,blink
L_930da8:
	bl L_929b84
L_930dac:
	cmp_s r0,0x3f
L_930dae:
	mov_s r1,0x8014e8
L_930db4:
	ble.d L_930dc0
L_930db8:
	stb_s r0,[r1]
L_930dba:
	mov_s r0,0x0
L_930dbc:
	stb r0,[r1]
	.global L_930dc0
L_930dc0:
	mov_s blink,r13
L_930dc2:
	j_s.d [blink]
L_930dc4:
	pop_s r13
L_930dc6:
	nop_s
