/* sta_psc_sm__psc_done_sm @ 0x8dd7c8, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sta_psc_sm::psc_done_sm. dpm: %d, success: %d
 * Зовут его: sta_psc_sm__max_retry_handler, sta_psc_sm__on_agreed, tail_sta_psc_sm__psc_done_sm
 * Зовёт сам: PS_CONNECTION__psc_complete, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, sta_psc_sm__m_psc_req_tx_wb_timeout_event, sta_psc_sm__m_psc_resp_rx_wb_timeout_event
 */
	.section .text.sta_psc_sm__psc_done_sm,"ax",@progbits
	.global sta_psc_sm__psc_done_sm
sta_psc_sm__psc_done_sm:
	.global L_8dd7c8
L_8dd7c8:
	push_s blink
L_8dd7ca:
	bl L_8c02c4
L_8dd7ce:
	mov_s r13,r0
L_8dd7d0:
	mov_s r14,r1
L_8dd7d2:
	ldb r3,[r13, 0x44]
L_8dd7d6:
	mov_s r2,0x1002ff8
L_8dd7dc:
	mov_s r0,0xe
L_8dd7de:
	mov_s r1,0x2
L_8dd7e0:
	bl.d L_8edff8
L_8dd7e4:
	mov_s r4,r14
L_8dd7e6:
	ldb r0,[r13, 0x44]
L_8dd7ea:
	add r3,r13,0x3c
L_8dd7ee:
	sub.f r2,r0,0x0
L_8dd7f2:
	ld_s r0,[r13,0x38]
L_8dd7f4:
	mov.ne r2,0x1
L_8dd7f8:
	bl.d L_8dd554
L_8dd7fc:
	mov_s r1,r14
L_8dd7fe:
	bl.d L_8c5c0c
L_8dd802:
	mov_s r0,r13
L_8dd804:
	bl.d L_8c5c74
L_8dd808:
	mov_s r0,r13
L_8dd80a:
	b L_8c0334
L_8dd80e:
	nop_s
