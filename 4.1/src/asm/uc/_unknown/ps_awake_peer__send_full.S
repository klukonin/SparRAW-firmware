/* ps_awake_peer__send_full @ 0x9265bc, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_manager__decide_shallow_sleep
 * Зовёт сам: uc_send_evt__ps_awake_peer
 */
	.section .text.ps_awake_peer__send_full,"ax",@progbits
	.global ps_awake_peer__send_full
ps_awake_peer__send_full:
	.global L_9265bc
L_9265bc:
	ld.as r7,[r0,0x50]
L_9265c0:
	add r5,r0,0x200
L_9265c8:
	breq.d r7,0x0,L_9265ec
L_9265cc:
	mov r6,0x0
L_9265d0:
	ldb r8,[r5, -0xcc]
L_9265d4:
	ldb r4,[r5, -0xcb]
L_9265d8:
	ldb r3,[r5, -0xc8]
L_9265dc:
	or r4,r4,r8
L_9265e0:
	stb r4,[r5, -0xa7]
L_9265e4:
	b.d L_9265f8
L_9265e8:
	stb r3,[r5, -0xa6]
	.global L_9265ec
L_9265ec:
	mov r2,0xff
L_9265f0:
	stb r2,[r5, -0xa7]
L_9265f4:
	stb r6,[r5, -0xa6]
	.global L_9265f8
L_9265f8:
	stb r1,[r5, -0xa8]
L_9265fc:
	stb r6,[r5, -0xa5]
L_926600:
	b.d L_925ba4
L_926604:
	add r0,r0,0x158
