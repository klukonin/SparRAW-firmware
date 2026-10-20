/* pcp_psc_sm__psc_start_flow_8e1c14 @ 0x8e1c14, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_psc_sm::psc_start_flow
 *   Sending PSC RESP. bi_start_time:0x%x, number_of_awake_bi:%d, sleep_cycle:%d
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit3, pcp_psc_sm__send_psc_resp_flow
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global pcp_psc_sm__psc_start_flow_8e1c14
pcp_psc_sm__psc_start_flow_8e1c14:
	.global L_8e1c14
L_8e1c14:
	push_s blink
L_8e1c16:
	push_s r13
L_8e1c18:
	mov_s r13,r0
L_8e1c1a:
	mov_s r1,0x1002af0
L_8e1c20:
	bl.d L_8dcba8
L_8e1c24:
	mov_s r0,0x2e
L_8e1c26:
	ldw r4,[r13, 0x18]
L_8e1c2a:
	mov_s r1,0x1002b0c
L_8e1c30:
	ld_s r2,[r13,0x14]
L_8e1c32:
	mov_s r0,0x2e
L_8e1c34:
	bl.d L_8dcd00
L_8e1c38:
	ldw_s r3,[r13,0x1a]
L_8e1c3a:
	bl.d L_8e5c98
L_8e1c3e:
	mov_s r0,r13
L_8e1c40:
	b L_8c025c
