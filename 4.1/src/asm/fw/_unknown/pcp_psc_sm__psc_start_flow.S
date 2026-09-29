/* pcp_psc_sm__psc_start_flow @ 0x8ddad8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_psc_sm::psc_start_flow
 *   Sending PSC RESP. bi_start_time:0x%x, number_of_awake_bi:%d, sleep_cycle:%d
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit3, pcp_psc_sm__send_psc_resp_flow
 */
	.section .text.pcp_psc_sm__psc_start_flow,"ax",@progbits
	.global pcp_psc_sm__psc_start_flow
pcp_psc_sm__psc_start_flow:
L_8ddad8:
	push_s blink
L_8ddada:
	push_s r13
L_8ddadc:
	mov_s r13,r0
L_8ddade:
	mov_s r2,0x1003150
L_8ddae4:
	mov_s r0,0xe
L_8ddae6:
	bl.d L_8edfb0
L_8ddaea:
	mov_s r1,0x2
L_8ddaec:
	ldw r4,[r13, 0x3e]
L_8ddaf0:
	mov_s r2,0x100316c
L_8ddaf6:
	ldw r5,[r13, 0x3c]
L_8ddafa:
	mov_s r0,0xe
L_8ddafc:
	mov_s r1,0x2
L_8ddafe:
	bl.d L_8ee034
L_8ddb02:
	ld_s r3,[r13,0x38]
L_8ddb04:
	bl.d L_8e0ff4
L_8ddb08:
	mov_s r0,r13
L_8ddb0a:
	.byte 0x35,0x00
