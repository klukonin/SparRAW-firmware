/* tx_macq__config_bcast_ring @ 0x8d68a8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__setup_bcast_queues
 * Зовёт сам: __ld_r13_ret, get_g_8001e8, tx_macq__config_ring_params
 */
	.section .text.tx_macq__config_bcast_ring,"ax",@progbits
	.global tx_macq__config_bcast_ring
tx_macq__config_bcast_ring:
	.global L_8d68a8
L_8d68a8:
	push_s blink
L_8d68aa:
	push_s r13
L_8d68ac:
	mov_s r13,0x8063b4
L_8d68b2:
	mov_s r0,0x18
L_8d68b4:
	bl.d L_8ca0d8
L_8d68b8:
	stb_s r0,[r13]
L_8d68ba:
	mov_s r5,r0
L_8d68bc:
	mov_s r0,r13
L_8d68be:
	mov_s r1,0x0
L_8d68c0:
	mov r2,0x1c2
L_8d68c4:
	mov_s r3,0x3
L_8d68c6:
	mov r4,0x2000
L_8d68ce:
	bl.d L_8de5d8
L_8d68d2:
	asl_s r3,r3,0xc
L_8d68d4:
	b L_8c033c
