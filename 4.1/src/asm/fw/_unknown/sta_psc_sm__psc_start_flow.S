/* sta_psc_sm__psc_start_flow @ 0x8ddb0c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::psc_start_flow. DPM: %d
 *   Sending PSC REQ. bi_start_time:0x%x, number_of_awake_bi:%d, sleep_cycle:%d
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_log__emit3, sta_psc_sm__send_psc_req_flow_sm
 */
	.section .text.sta_psc_sm__psc_start_flow,"ax",@progbits
	.global sta_psc_sm__psc_start_flow
sta_psc_sm__psc_start_flow:
	.byte 0x4f
	.byte 0xf1
	.global fwlog_Sending_PSC_REQ_bi_start_time_0x_x_numbe
fwlog_Sending_PSC_REQ_bi_start_time_0x_x_numbe:
L_8ddb0e:
	nop_s
L_8ddb10:
	push_s blink
L_8ddb12:
	bl.d L_8c02c4
L_8ddb16:
	mov_s r1,0x2
L_8ddb18:
	mov_s r13,r0
L_8ddb1a:
	mov_s r0,0x0
L_8ddb1c:
	stb r0,[r13, 0x35]
L_8ddb20:
	mov_s r2,0x1002f54
L_8ddb26:
	add3 r14,r13,0x8
L_8ddb2a:
	mov_s r0,0xe
L_8ddb2c:
	bl.d L_8edfcc
L_8ddb30:
	ldb_s r3,[r14,0x4]
L_8ddb32:
	mov_s r2,0x1002e84
L_8ddb38:
	ldw r4,[r14, 0x2]
L_8ddb3c:
	mov_s r0,0xe
L_8ddb3e:
	ldw r5,[r14]
L_8ddb42:
	mov_s r1,0x2
L_8ddb44:
	bl.d L_8ee034
L_8ddb48:
	ld_s r3,[r13,0x3c]
L_8ddb4a:
	bl.d L_8e0f04
L_8ddb4e:
	mov_s r0,r13
L_8ddb50:
	b L_8c0334
