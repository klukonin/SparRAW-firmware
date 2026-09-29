/* txq_ptp_sw_is_fifo_idle @ 0x8ea47c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txq_ptp_sw_is_fifo_idle: non_idle 0x%x
 * Зовут его: sm_pring__timeout
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global txq_ptp_sw_is_fifo_idle
txq_ptp_sw_is_fifo_idle:
	.global L_8ea47c
L_8ea47c:
	push_s blink
L_8ea47e:
	push_s r13
L_8ea480:
	mov_s r1,0x886a00
L_8ea486:
	st 0x80000000,[r1, 0x44]
L_8ea48e:
	st 0x80000000,[r1, 0x48]
L_8ea496:
	ld_s r13,[r1,0x44]
L_8ea498:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8ea49a:
	ld_s r1,[r1,0x48]
L_8ea49c:
	bmsk_s r13,r13,0x1
L_8ea49e:
	bmsk_s r1,r1,0x2
L_8ea4a0:
	or_s r13,r13,r1
L_8ea4a2:
	mov_s r1,0x10134d8
L_8ea4a8:
	bl.d L_8dcc10
L_8ea4ac:
	mov_s r2,r13
L_8ea4ae:
	cmp_s r13,0x0
L_8ea4b0:
	mov_s r0,0x1
L_8ea4b2:
	b.d L_8c025c
L_8ea4b6:
	sub_s.ne r0,r0,r0
