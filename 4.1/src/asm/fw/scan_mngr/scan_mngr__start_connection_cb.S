/* scan_mngr__start_connection_cb @ 0x8f1280, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::start_connection_cb() connect to: ADDR-%04X%08X m_active_probs=%d
 *   scan_mngr.cpp
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit3, fw_sysassert_fatal, scan_mngr__connect
 */
	.section .text.scan_mngr__start_connection_cb,"ax",@progbits
	.global scan_mngr__start_connection_cb
scan_mngr__start_connection_cb:
L_8f1280:
	push_s blink
L_8f1282:
	bl L_8c02c4
L_8f1286:
	mov.f r13,r1
L_8f128a:
	mov_s r14,r0
L_8f128c:
	beq_s L_8f12b2
	.global L_8f128e
L_8f128e:
	ld r4,[r13, 0x8]
L_8f1292:
	mov_s r2,0x1013e2c
L_8f1298:
	ldb r5,[r14, 0x8c]
L_8f129c:
	mov_s r0,0x9
L_8f129e:
	mov_s r1,0x2
L_8f12a0:
	bl.d L_8ee034
L_8f12a4:
	ldw_s r3,[r13,0xc]
L_8f12a6:
	mov_s r0,r14
L_8f12a8:
	bl.d L_8ea86c
L_8f12ac:
	mov_s r1,r13
L_8f12ae:
	b L_8c0334
	.global L_8f12b2
L_8f12b2:
	mov_s r0,blink
L_8f12b4:
	mov_s r2,0x1012bb8
L_8f12ba:
	mov_s r1,0x1441
L_8f12c0:
	bl.d L_8c82c0
L_8f12c4:
	mov r3,0x26f
