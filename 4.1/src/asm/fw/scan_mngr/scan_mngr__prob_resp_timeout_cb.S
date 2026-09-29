/* scan_mngr__prob_resp_timeout_cb @ 0x8ef1c4, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::prob_resp_timeout_cb() me=0x%X p_dband_info=0x%X
 *   [NNL]-- scan_mngr=%d  prob_resp_timeout_event_id=%d
 *   scan_mngr::prob_resp_timeout_cb() to:  ADDR-%04X%08X
 *   scan_mngr.cpp
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit2, fw_sysassert_fatal, scan_mngr__prob_done
 */
	.section .text.scan_mngr__prob_resp_timeout_cb,"ax",@progbits
	.global scan_mngr__prob_resp_timeout_cb
scan_mngr__prob_resp_timeout_cb:
L_8ef1c4:
	push_s blink
L_8ef1c6:
	bl L_8c02b8
L_8ef1ca:
	mov_s r17,r0
L_8ef1cc:
	mov_s r16,r1
L_8ef1ce:
	mov_s r2,0x1013bbc
L_8ef1d4:
	mov_s r0,0x9
L_8ef1d6:
	mov_s r1,0x2
L_8ef1d8:
	mov_s r3,r17
L_8ef1da:
	bl.d L_8edff8
L_8ef1de:
	mov r4,r16
L_8ef1e2:
	breq r16,0x0,L_8ef230
	.global L_8ef1e6
L_8ef1e6:
	mov_s r2,0x1013bf8
L_8ef1ec:
	add3 r13,r17,0x10
L_8ef1f0:
	ld r4,[r16, 0x40]
L_8ef1f4:
	mov_s r0,0x9
L_8ef1f6:
	mov_s r1,0x2
L_8ef1f8:
	bl.d L_8edff8
L_8ef1fc:
	ldb_s r3,[r13,0xc]
L_8ef1fe:
	mov_s r0,0x0
L_8ef200:
	st r0,[r16, 0x40]
L_8ef204:
	ldb_s r0,[r13,0xc]
L_8ef206:
	mov_s r2,0x1013c2c
L_8ef20c:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8ef20e:
	extb_s r0,r0
L_8ef210:
	stb_s r0,[r13,0xc]
L_8ef212:
	ld r4,[r16, 0x8]
L_8ef216:
	mov_s r0,0x9
L_8ef218:
	mov_s r1,0x2
L_8ef21a:
	bl.d L_8edff8
L_8ef21e:
	ldw r3,[r16, 0xc]
L_8ef222:
	mov_s r0,r17
L_8ef224:
	mov_s r1,0x3
L_8ef226:
	bl.d L_8ef034
L_8ef22a:
	mov_s r2,r16
L_8ef22c:
	b L_8c031c
	.global L_8ef230
L_8ef230:
	mov_s r0,blink
L_8ef232:
	mov_s r2,0x1012bb8
L_8ef238:
	mov_s r1,0x51
L_8ef23a:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8ef23c:
	bl.d L_8c82c0
L_8ef240:
	mov r3,0x358
