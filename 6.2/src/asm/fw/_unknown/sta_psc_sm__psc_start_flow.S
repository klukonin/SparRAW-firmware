/* sta_psc_sm__psc_start_flow @ 0x8e1c44, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::psc_start_flow. DPM: %d
 *   Sending PSC REQ. bi_start_time:0x%x, number_of_awake_bi:%d, sleep_cycle:%d
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, fw_log_emit3, sta_psc_sm__send_psc_req_flow_sm
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sta_psc_sm__psc_start_flow
sta_psc_sm__psc_start_flow:
	.global L_8e1c44
L_8e1c44:
	push_s blink
L_8e1c46:
	push_s r13
L_8e1c48:
	mov_s r13,r0
L_8e1c4a:
	mov_s r0,0x0
L_8e1c4c:
	stb_s r0,[r13,0x11]
L_8e1c4e:
	mov_s r1,0x1002c70
L_8e1c54:
	mov_s r0,0x2e
L_8e1c56:
	bl.d L_8dcc10
L_8e1c5a:
	ldb r2,[r13, 0x20]
L_8e1c5e:
	mov_s r1,0x1002c94
L_8e1c64:
	ldw r4,[r13, 0x1c]
L_8e1c68:
	mov_s r0,0x2e
L_8e1c6a:
	ld_s r2,[r13,0x18]
L_8e1c6c:
	bl.d L_8dcd00
L_8e1c70:
	ldw_s r3,[r13,0x1e]
L_8e1c72:
	bl.d L_8e5bc0
L_8e1c76:
	mov_s r0,r13
L_8e1c78:
	b L_8c025c
