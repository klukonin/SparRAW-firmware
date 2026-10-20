/* direct_tx__init_rx_desc @ 0x9246c4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx__send_dmg_cts
 * Зовёт сам: __ld_r13_to_r13_ret, bits__uc_set32_s4_w3
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global direct_tx__init_rx_desc
direct_tx__init_rx_desc:
	.global L_9246c4
L_9246c4:
	push_s blink
L_9246c6:
	push_s r13
L_9246c8:
	mov_s r3,r0
L_9246ca:
	mov_s r13,r1
L_9246cc:
	mov r0,0x764
L_9246d0:
	stw_s r0,[r3]
L_9246d2:
	mov_s r0,0x0
L_9246d4:
	st_s r0,[r3,0x10]
L_9246d6:
	stb_s r0,[r3,0x15]
L_9246d8:
	stb_s r0,[r3,0x16]
L_9246da:
	mov_s r1,0x1
L_9246dc:
	add r0,r3,0x10
L_9246e0:
	bl.d L_93e3e4
L_9246e4:
	bmsk_s r2,r2,0x0
L_9246e6:
	bmsk r0,r13,0x0
L_9246ea:
	asl_s r0,r0
L_9246ec:
	bset_s r0,r0,0x0
L_9246ee:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_9246f0:
	bclr_s r0,r0,0x2
L_9246f2:
	or_s r2,r2,r0
L_9246f4:
	b.d L_9202ac
L_9246f8:
	stb_s r2,[r3,0x15]
L_9246fa:
	nop_s
