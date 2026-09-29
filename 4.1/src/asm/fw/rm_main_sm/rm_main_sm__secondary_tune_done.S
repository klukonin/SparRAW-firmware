/* rm_main_sm__secondary_tune_done @ 0x8e038c, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   rm_main_sm::secondary_tune_done. channelID=%d, rx_on=%d
 *   rm_main_sm::secondary_tune_done. callback is called for Handle:0x%x
 *   rm_main_sm.cpp
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_sm__store_pending_event, fw_log__emit1, fw_log__emit2, fw_sysassert_fatal, radio_mgr__set_tune_result, u_schd__add
 */
	.section .text.rm_main_sm__secondary_tune_done,"ax",@progbits
	.global rm_main_sm__secondary_tune_done
rm_main_sm__secondary_tune_done:
L_8e038c:
	push_s blink
L_8e038e:
	bl L_8c02b8
L_8e0392:
	mov_s r13,r0
L_8e0394:
	ld_s r0,[r0,0x28]
L_8e0396:
	mov_s r16,r2
L_8e0398:
	mov_s r15,r1
L_8e039a:
	mov_s r17,r3
L_8e039c:
	breq_s r0,0,L_8e03b2
L_8e039e:
	mov_s r2,0x1015d64
L_8e03a4:
	mov_s r0,0x8
L_8e03a6:
	mov_s r1,0x2
L_8e03a8:
	mov_s r3,r15
L_8e03aa:
	bl.d L_8edff8
L_8e03ae:
	mov r4,r16
	.global L_8e03b2
L_8e03b2:
	mov_s r0,r13
L_8e03b4:
	mov_s r1,r16
L_8e03b6:
	mov_s r2,r15
L_8e03b8:
	bl.d L_8e49f8
L_8e03bc:
	mov_s r3,r17
L_8e03be:
	ld r14,[r13, 0xc8]
L_8e03c2:
	breq_s r14,0,L_8e0404
	.global L_8e03c4
L_8e03c4:
	ld_s r0,[r14,0x8]
L_8e03c6:
	breq r0,0x4,L_8e044c
L_8e03ca:
	ld_s r0,[r14,0x1c]
L_8e03cc:
	brne r0,r16,L_8e041c
	.global L_8e03d0
L_8e03d0:
	breq r16,0x0,L_8e03da
L_8e03d4:
	ld_s r0,[r14,0x18]
L_8e03d6:
	brne r15,r0,L_8e0434
	.global L_8e03da
L_8e03da:
	mov_s r0,0x3
L_8e03dc:
	st_s r0,[r14,0x8]
L_8e03de:
	ld_s r0,[r13,0x28]
L_8e03e0:
	breq_s r0,0,L_8e03f2
L_8e03e2:
	mov_s r2,0x1015d9c
L_8e03e8:
	mov_s r0,0x8
L_8e03ea:
	mov_s r1,0x2
L_8e03ec:
	bl.d L_8edfcc
L_8e03f0:
	mov_s r3,r14
	.global L_8e03f2
L_8e03f2:
	mov_s r0,0x1f9f0
L_8e03f8:
	mov_s r1,r14
L_8e03fa:
	mov_s r2,0x0
L_8e03fc:
	bl.d L_8c2ac8
L_8e0400:
	mov_s r3,0x1
L_8e0402:
	b_s L_8e045a
	.global L_8e0404
L_8e0404:
	mov_s r0,blink
L_8e0406:
	mov_s r2,0x1015d54
L_8e040c:
	mov_s r1,0x1172
L_8e0412:
	bl.d L_8c82c0
L_8e0416:
	mov r3,0x146
L_8e041a:
	b_s L_8e03c4
	.global L_8e041c
L_8e041c:
	mov_s r0,blink
L_8e041e:
	mov_s r2,0x1015d54
L_8e0424:
	mov_s r1,0x1173
L_8e042a:
	bl.d L_8c82c0
L_8e042e:
	mov r3,0x14b
L_8e0432:
	b_s L_8e03d0
	.global L_8e0434
L_8e0434:
	mov_s r0,blink
L_8e0436:
	mov_s r2,0x1015d54
L_8e043c:
	mov_s r1,0x1174
L_8e0442:
	bl.d L_8c82c0
L_8e0446:
	mov r3,0x14e
L_8e044a:
	b_s L_8e03da
	.global L_8e044c
L_8e044c:
	mov_s r0,r13
L_8e044e:
	mov_s r1,0x7
L_8e0450:
	mov_s r2,r14
L_8e0452:
	mov_s r3,0x0
L_8e0454:
	bl.d L_8e20c0
L_8e0458:
	mov_s r4,r3
	.global L_8e045a
L_8e045a:
	.byte 0xc5,0x06
