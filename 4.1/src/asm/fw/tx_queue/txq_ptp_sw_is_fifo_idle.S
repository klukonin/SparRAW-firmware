/* txq_ptp_sw_is_fifo_idle @ 0x8e50f0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   txq_ptp_sw_is_fifo_idle: non_idle 0x%x
 * Зовут его: sm_pring__timeout
 * Зовёт сам: __ld_r13_ret, fw_log__emit1
 */
	.section .text.txq_ptp_sw_is_fifo_idle,"ax",@progbits
	.global txq_ptp_sw_is_fifo_idle
txq_ptp_sw_is_fifo_idle:
	.global L_8e50f0
L_8e50f0:
	push_s blink
L_8e50f2:
	push_s r13
L_8e50f4:
	mov_s r1,r0
L_8e50f6:
	mov_s r0,0x886a00
L_8e50fc:
	st 0x80000000,[r0, 0x44]
L_8e5104:
	st 0x80000000,[r0, 0x48]
L_8e510c:
	ld_s r13,[r0,0x44]
L_8e510e:
	mov_s r2,0x1010128
L_8e5114:
	ld_s r0,[r0,0x48]
L_8e5116:
	bmsk_s r13,r13,0x1
L_8e5118:
	bmsk_s r0,r0,0x2
L_8e511a:
	or_s r13,r13,r0
L_8e511c:
	mov_s r0,0x0
L_8e511e:
	bl.d L_8edfcc
L_8e5122:
	mov_s r3,r13
L_8e5124:
	cmp_s r13,0x0
L_8e5126:
	mov_s r0,0x1
L_8e5128:
	b.d L_8c033c
L_8e512c:
	sub_s.ne r0,r0,r0
L_8e512e:
	nop_s
