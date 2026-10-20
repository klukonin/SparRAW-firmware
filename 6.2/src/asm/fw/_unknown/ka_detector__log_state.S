/* ka_detector__log_state @ 0x8e10a4, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [NNL] | cid %d | tm_no_tx %d | ack_cnt %d
 *   [NNL]  | last_ack_cnt %d | tx_avail %d | ka_avail %d
 *   [NNL] | ka_period_usec %d | ka_triggers_cnt %d | snr %d
 * Зовут его: ka_necessity_detector__task
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ka_detector__log_state
ka_detector__log_state:
	.global L_8e10a4
L_8e10a4:
	push_s blink
L_8e10a6:
	bl.d L_8c01d4
L_8e10aa:
	mov_s r9,r2
L_8e10ac:
	mov_s r13,r0
L_8e10ae:
	mov_s r14,r1
L_8e10b0:
	mov_s r8,r3
L_8e10b2:
	mov_s r15,r4
L_8e10b4:
	mov r16,r5
L_8e10b8:
	mov r18,r6
L_8e10bc:
	mov r17,r7
L_8e10c0:
	mov_s r1,0x1014d10
L_8e10c6:
	mov_s r0,0x2b
L_8e10c8:
	ldb r2,[r13, 0x30]
L_8e10cc:
	mov_s r3,r9
L_8e10ce:
	bl.d L_8dcd00
L_8e10d2:
	mov r4,r8
L_8e10d6:
	mov_s r1,0x1014d3c
L_8e10dc:
	mov_s r0,0x2b
L_8e10de:
	mov_s r2,r15
L_8e10e0:
	mov_s r3,r16
L_8e10e2:
	bl.d L_8dcd00
L_8e10e6:
	mov r4,r18
L_8e10ea:
	mov_s r1,0x1014d74
L_8e10f0:
	ld r4,[sp, 0x20]
L_8e10f4:
	mov_s r0,0x2b
L_8e10f6:
	mov_s r2,r17
L_8e10f8:
	bl.d L_8dcd00
L_8e10fc:
	ld_s r3,[sp,0x1c]
L_8e10fe:
	ld_s r1,[r14]
L_8e1100:
	ld_s r0,[r14,0x4]
L_8e1102:
	st_s r1,[r13,0x3c]
L_8e1104:
	b.d L_8c0234
L_8e1108:
	st_s r0,[r13,0x40]
L_8e110a:
	nop_s
