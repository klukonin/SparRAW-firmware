/* sta_psc_sm__send_psc_req_flow_sm @ 0x8e0f04, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::send_psc_req_flow_sm. retry count: %d
 *   sta_psc_sm.cpp
 * Зовут его: sta_psc_sm__psc_req_tx_complete, sta_psc_sm__psc_start_flow
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, fw_sysassert_fatal, sta_psc_sm__build_psc_req, u_schd__schedule
 * Глобалы (через gp): 0x800418
 */
	.section .text.sta_psc_sm__send_psc_req_flow_sm,"ax",@progbits
	.global sta_psc_sm__send_psc_req_flow_sm
sta_psc_sm__send_psc_req_flow_sm:
	.global L_8e0f04
L_8e0f04:
	push_s blink
L_8e0f06:
	push_s r13
L_8e0f08:
	mov_s r13,r0
L_8e0f0a:
	mov_s r2,0x1002f10
L_8e0f10:
	mov_s r0,0xe
L_8e0f12:
	mov_s r1,0x2
L_8e0f14:
	bl.d L_8edfcc
L_8e0f18:
	ldb r3,[r13, 0x35]
L_8e0f1c:
	bl.d L_8e0e3c
L_8e0f20:
	mov_s r0,r13
L_8e0f22:
	ld_s r0,[r13,0x2c]
L_8e0f24:
	brne_s r0,0,L_8e0f44
	.global L_8e0f26
L_8e0f26:
	mov_s r0,0x1d958
L_8e0f2c:
	ld.as r4,[gp,0xaa]
L_8e0f30:
	mov_s r1,r13
L_8e0f32:
	mov_s r2,0x0
L_8e0f34:
	mov_s r3,r2
L_8e0f36:
	mov_s r5,r2
L_8e0f38:
	bl.d L_8dc92c
L_8e0f3c:
	mov_s r6,r2
L_8e0f3e:
	b.d L_8c033c
L_8e0f42:
	st_s r0,[r13,0x2c]
	.global L_8e0f44
L_8e0f44:
	mov_s r0,blink
L_8e0f46:
	mov_s r2,0x1002f44
L_8e0f4c:
	mov_s r1,0x12a4
L_8e0f52:
	bl.d L_8c82c0
L_8e0f56:
	mov_s r3,0x75
L_8e0f58:
	b_s L_8e0f26
L_8e0f5a:
	nop_s
