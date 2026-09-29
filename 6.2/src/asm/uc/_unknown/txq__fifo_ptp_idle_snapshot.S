/* txq__fifo_ptp_idle_snapshot @ 0x92e8a8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_is_tx_pipe_idle, vring__disconnect_flush
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txq__fifo_ptp_idle_snapshot
txq__fifo_ptp_idle_snapshot:
	.global L_92e8a8
L_92e8a8:
	push_s blink
L_92e8aa:
	mov_s r0,0x886a00
L_92e8b0:
	st 0x80000000,[r0, 0x38]
L_92e8b8:
	st 0x80000000,[r0, 0x44]
L_92e8c0:
	st 0x80000000,[r0, 0x3c]
L_92e8c8:
	st 0x80000000,[r0, 0x48]
L_92e8d0:
	sync
L_92e8d4:
	mov_s r1,0x886a00
L_92e8da:
	ld_s r0,[r1,0x38]
L_92e8dc:
	ld_s r3,[r1,0x44]
L_92e8de:
	bmsk.f 0x0,r0,0x1
L_92e8e2:
	ld_s r2,[r1,0x48]
L_92e8e4:
	bmsk_s r3,r3,0x1
L_92e8e6:
	ld_s r1,[r1,0x3c]
L_92e8e8:
	bmsk_s r2,r2,0x2
L_92e8ea:
	bmsk_s r1,r1,0x2
L_92e8ec:
	mov_s r0,0x0
L_92e8ee:
	cmp.eq r3,0x0
L_92e8f2:
	cmp.eq r2,0x0
L_92e8f6:
	cmp.eq r1,0x0
L_92e8fa:
	mov.eq r0,0x1
L_92e8fe:
	extb_s r0,r0
L_92e900:
	pop_s blink
L_92e902:
	j_s [blink]
