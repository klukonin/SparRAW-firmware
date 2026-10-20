/* ka_detector__log_state @ 0x8dcef8, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [NNL] | cid %d | tm_no_tx %d | ack_cnt %d
 *   [NNL]  | last_ack_cnt %d | tx_avail %d | ka_avail %d
 *   [NNL] | ka_period_usec %d | ka_triggers_cnt %d | snr %d
 *   [NNL] | dt %d
 * Зовут его: ka_necessity_detector__task
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit1, fw_log__emit3
 */
	.section .text.ka_detector__log_state,"ax",@progbits
	.global ka_detector__log_state
ka_detector__log_state:
	.global L_8dcef8
L_8dcef8:
	push_s blink
L_8dcefa:
	bl.d L_8c02b4
L_8dcefe:
	mov_s r9,r2
L_8dcf00:
	mov_s r14,r0
L_8dcf02:
	mov_s r13,r1
L_8dcf04:
	mov_s r8,r3
L_8dcf06:
	mov_s r15,r4
L_8dcf08:
	mov r18,r5
L_8dcf0c:
	mov r17,r6
L_8dcf10:
	mov r16,r7
L_8dcf14:
	mov_s r2,0x10114f8
L_8dcf1a:
	mov_s r0,0xb
L_8dcf1c:
	mov_s r1,0x2
L_8dcf1e:
	ldb r3,[r14, 0x30]
L_8dcf22:
	mov r4,r9
L_8dcf26:
	bl.d L_8ee034
L_8dcf2a:
	mov r5,r8
L_8dcf2e:
	mov_s r2,0x1011524
L_8dcf34:
	mov_s r0,0xb
L_8dcf36:
	mov_s r1,0x2
L_8dcf38:
	mov_s r3,r15
L_8dcf3a:
	mov r4,r18
L_8dcf3e:
	bl.d L_8ee034
L_8dcf42:
	mov r5,r17
L_8dcf46:
	ld r4,[sp, 0x1c]
L_8dcf4a:
	mov_s r2,0x101155c
L_8dcf50:
	ld r5,[sp, 0x20]
L_8dcf54:
	mov_s r0,0xb
L_8dcf56:
	mov_s r1,0x2
L_8dcf58:
	bl.d L_8ee034
L_8dcf5c:
	mov_s r3,r16
L_8dcf5e:
	mov_s r2,0x1011594
L_8dcf64:
	mov_s r0,0xb
L_8dcf66:
	mov_s r1,0x2
L_8dcf68:
	bl.d L_8edfcc
L_8dcf6c:
	ld_s r3,[sp,0x24]
L_8dcf6e:
	ld_s r1,[r13]
L_8dcf70:
	ld_s r0,[r13,0x4]
L_8dcf72:
	st_s r1,[r14,0x3c]
L_8dcf74:
	b.d L_8c0314
L_8dcf78:
	st_s r0,[r14,0x40]
L_8dcf7a:
	nop_s
