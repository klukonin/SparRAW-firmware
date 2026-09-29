/* direct_tx__init_rx_desc @ 0x9243fc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: direct_tx_rx_step
 * Зовёт сам: __ld_r13_ret_uc, bf_w_s4_w3_uc
 */
	.section .text.direct_tx__init_rx_desc,"ax",@progbits
	.global direct_tx__init_rx_desc
direct_tx__init_rx_desc:
	.global L_9243fc
L_9243fc:
	push_s blink
L_9243fe:
	push_s r13
L_924400:
	mov_s r3,r0
L_924402:
	mov_s r13,r1
L_924404:
	mov r0,0x764
L_924408:
	stw_s r0,[r3]
L_92440a:
	mov_s r0,0x0
L_92440c:
	st_s r0,[r3,0x10]
L_92440e:
	stb_s r0,[r3,0x15]
L_924410:
	stb_s r0,[r3,0x16]
L_924412:
	mov_s r1,0x1
L_924414:
	add r0,r3,0x10
L_924418:
	bl.d L_9379c4
L_92441c:
	bmsk_s r2,r2,0x0
L_92441e:
	bmsk r0,r13,0x0
L_924422:
	asl_s r0,r0
L_924424:
	bset_s r0,r0,0x0
L_924426:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_924428:
	bclr_s r0,r0,0x2
L_92442a:
	or_s r2,r2,r0
L_92442c:
	b.d L_92028c
L_924430:
	stb_s r2,[r3,0x15]
L_924432:
	nop_s
