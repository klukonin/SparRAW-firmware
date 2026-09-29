/* ba_setup_sm__addba_resp_timeout_cb @ 0x8e93ac, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::addba_resp_timeout_cb()
 *   ba_setup_sm.cpp
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.ba_setup_sm__addba_resp_timeout_cb,"ax",@progbits
	.global ba_setup_sm__addba_resp_timeout_cb
ba_setup_sm__addba_resp_timeout_cb:
	.byte 0x4f
	.byte 0xeb
	.global fwlog_ba_setup_sm_addba_resp_timeout_cb
fwlog_ba_setup_sm_addba_resp_timeout_cb:
L_8e93ae:
	nop_s
L_8e93b0:
	push_s blink
L_8e93b2:
	push_s r13
L_8e93b4:
	mov_s r13,r0
L_8e93b6:
	mov_s r2,0x101044c
L_8e93bc:
	mov_s r0,0x5
L_8e93be:
	bl.d L_8edfb0
L_8e93c2:
	mov_s r1,0x2
L_8e93c4:
	breq_s r13,0,L_8e93da
	.global L_8e93c6
L_8e93c6:
	mov_s r2,0x0
L_8e93c8:
	st_s r2,[r13,0x30]
L_8e93ca:
	mov_s r0,r13
L_8e93cc:
	mov_s r1,0x5
L_8e93ce:
	mov_s r3,r2
L_8e93d0:
	bl.d L_8d6a1c
L_8e93d4:
	mov_s r4,r2
L_8e93d6:
	b L_8c033c
	.global L_8e93da
L_8e93da:
	mov_s r0,blink
L_8e93dc:
	mov_s r2,0x10102c4
L_8e93e2:
	mov_s r1,0x1293
L_8e93e8:
	bl.d L_8c82c0
L_8e93ec:
	mov r3,0x10b
