/* ps_awake_peer__send_clear_peer @ 0x9268f8, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow
 * Зовёт сам: uc_send_evt__ps_awake_peer
 */
	.section .text.ps_awake_peer__send_clear_peer,"ax",@progbits
	.global ps_awake_peer__send_clear_peer
ps_awake_peer__send_clear_peer:
	.global L_9268f8
L_9268f8:
	mov r7,0x1
L_9268fc:
	asl r2,0x1,r1
L_926904:
	add r5,r0,0x200
L_92690c:
	ldb r4,[r5, -0xa7]
L_926910:
	not r6,r2
L_926914:
	and r4,r4,r6
L_926918:
	ldb r3,[r5, -0xa6]
L_92691c:
	stb r4,[r5, -0xa7]
L_926920:
	and r3,r3,r6
L_926924:
	stb r3,[r5, -0xa6]
L_926928:
	stb r7,[r5, -0xa5]
L_92692c:
	b.d L_925ba4
L_926930:
	add r0,r0,0x158
