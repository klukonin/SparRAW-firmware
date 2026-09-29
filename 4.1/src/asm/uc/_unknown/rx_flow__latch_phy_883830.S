/* rx_flow__latch_phy_883830 @ 0x92ce6c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 * Зовёт сам: hwd_phy__get_883830
 */
	.section .text.rx_flow__latch_phy_883830,"ax",@progbits
	.global rx_flow__latch_phy_883830
rx_flow__latch_phy_883830:
	.global L_92ce6c
L_92ce6c:
	push_s r13
L_92ce6e:
	mov_s r13,blink
L_92ce70:
	bl L_927470
L_92ce74:
	cmp_s r0,0x3f
L_92ce76:
	mov_s r1,0x800a0c
L_92ce7c:
	ble.d L_92ce88
L_92ce80:
	stb_s r0,[r1]
L_92ce82:
	mov_s r0,0x0
L_92ce84:
	stb r0,[r1]
	.global L_92ce88
L_92ce88:
	mov_s blink,r13
L_92ce8a:
	j_s.d [blink]
L_92ce8c:
	pop_s r13
L_92ce8e:
	nop_s
