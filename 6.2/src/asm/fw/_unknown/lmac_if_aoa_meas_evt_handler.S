/* lmac_if_aoa_meas_evt_handler @ 0x8db1b0, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lmac_if_aoa_meas_evt_handler: wrong cdown =%d
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ftm__ctx_addr, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw, memcpy_fw, tof_mgr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_aoa_meas_evt_handler
lmac_if_aoa_meas_evt_handler:
	.global L_8db1b0
L_8db1b0:
	push_s blink
L_8db1b2:
	bl L_8c01e0
L_8db1b6:
	mov_s r14,r0
L_8db1b8:
	mov_s r13,0x8004bc
L_8db1be:
	ld_s r0,[r13]
L_8db1c0:
	brne_s r0,0,L_8db1c8
L_8db1c2:
	bl L_8c32d8
L_8db1c6:
	st_s r0,[r13]
	.global L_8db1c8
L_8db1c8:
	ldb_s r2,[r14,0xd]
L_8db1ca:
	brlt r2,0x2,L_8db1e2
L_8db1ce:
	mov_s r1,0x10041d0
L_8db1d4:
	bl.d L_8dcc10
L_8db1d8:
	mov_s r0,0x10
L_8db1da:
	mov_s r1,0x2
L_8db1dc:
	ld_s r0,[r13]
L_8db1de:
	stb_s r1,[r0,0xc]
L_8db1e0:
	b_s L_8db1e4
	.global L_8db1e2
L_8db1e2:
	brne_s r2,0,L_8db1e8
	.global L_8db1e4
L_8db1e4:
	mov_s r0,0x1
L_8db1e6:
	b_s L_8db1fa
	.global L_8db1e8
L_8db1e8:
	/* asl_s r2,r2,0x6 */
	.byte 0x06,0xba
L_8db1ea:
	add_s r0,r0,0x10
L_8db1ec:
	add_s r0,r0,r2
L_8db1ee:
	add r1,r14,0x10
L_8db1f2:
	bl.d L_8c0380
L_8db1f6:
	mov_s r2,0x40
L_8db1f8:
	mov_s r0,0x0
	.global L_8db1fa
L_8db1fa:
	breq_s r0,0,L_8db23a
L_8db1fc:
	bl L_8ccf04
L_8db200:
	bl.d L_8c382c
L_8db204:
	mov_s r1,r14
L_8db206:
	ld_s r15,[r13]
L_8db208:
	mov_s r1,r14
L_8db20a:
	mov_s r0,r15
L_8db20c:
	bl.d L_8c0380
L_8db210:
	mov_s r2,0x50
L_8db212:
	ldw_s r0,[r15,0xe]
L_8db214:
	mov_s r12,0x80
L_8db216:
	rsub r1,r0,r12
L_8db21a:
	mov_s r12,0x90
L_8db21c:
	rsub r2,r1,r12
L_8db220:
	extw_s r2,r2
L_8db222:
	mov_s r0,r15
L_8db224:
	mov_s r1,0x1923
L_8db22a:
	mov_s r14,0x0
L_8db22c:
	mov_s r3,r14
L_8db22e:
	mov_s r4,r14
L_8db230:
	mov_s r5,r14
L_8db232:
	bl.d L_8e5474
L_8db236:
	mov_s r6,r14
L_8db238:
	st_s r14,[r13]
	.global L_8db23a
L_8db23a:
	b L_8c024c
L_8db23e:
	nop_s
