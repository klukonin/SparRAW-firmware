/* calib_engine__on_start @ 0x8c8510, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_engine.cpp
 * Зовёт сам: __ld_r13_ret, basic_sm__store_pending_event, frag_8c85a0, fw_read_timer, fw_sysassert_fatal, sta_ctx__reset, sta_trace__push_record
 * Глобалы (через gp): 0x80018c
 */
	.section .text.calib_engine__on_start,"ax",@progbits
	.global calib_engine__on_start
calib_engine__on_start:
L_8c8510:
	push_s blink
L_8c8512:
	push_s r13
L_8c8514:
	bl.d L_8e4694
L_8c8518:
	mov_s r13,r0
L_8c851a:
	bl.d L_8e34e4
L_8c851e:
	mov_s r0,0x6
L_8c8520:
	mov_s r1,0x1
L_8c8522:
	stb_s r1,[r0,0xc]
L_8c8524:
	ld_s r1,[r13,0x30]
L_8c8526:
	st.as r0,[gp,0x7]
L_8c852a:
	stb_s r1,[r0,0xd]
L_8c852c:
	ld_s r0,[r13,0x2c]
L_8c852e:
	bl.d L_8c85a0
L_8c8532:
	ld_s r1,[r13,0x34]
L_8c8534:
	st_s r0,[r13,0x5c]
L_8c8536:
	ld_s r0,[r13,0x30]
L_8c8538:
	add_s r0,r0,r0
L_8c853a:
	add2_s r0,r0,r0
L_8c853c:
	add r1,r0,0x854880
L_8c8544:
	ldw_s r0,[r1,0x34]
L_8c8546:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c8548:
	extw_s r0,r0
L_8c854a:
	stw_s r0,[r1,0x34]
L_8c854c:
	ld_s r0,[gp,0x1c]
L_8c854e:
	ld_s r1,[r13,0x5c]
L_8c8550:
	stb_s r1,[r0,0xe]
L_8c8552:
	bl.d L_8e3488
L_8c8556:
	mov_s r0,0x6
L_8c8558:
	ld_s r1,[r13,0x5c]
L_8c855a:
	brne r1,0x1,L_8c856e
L_8c855e:
	mov_s r0,r13
L_8c8560:
	mov_s r1,0x4
	.global L_8c8562
L_8c8562:
	mov_s r2,0x0
L_8c8564:
	mov_s r3,r2
L_8c8566:
	bl.d L_8e20c0
L_8c856a:
	mov_s r4,r2
L_8c856c:
	b_s L_8c859a
	.global L_8c856e
L_8c856e:
	breq r1,0x2,L_8c8576
L_8c8572:
	ld_s r0,[r13,0x38]
L_8c8574:
	brne_s r0,0,L_8c857c
	.global L_8c8576
L_8c8576:
	mov_s r0,r13
L_8c8578:
	mov_s r1,0x1
L_8c857a:
	b_s L_8c8562
	.global L_8c857c
L_8c857c:
	cmp_s r1,0x3
L_8c857e:
	mov.eq r0,r13
L_8c8582:
	mov_s r1,0x2
L_8c8584:
	beq_s L_8c8562
L_8c8586:
	mov_s r0,blink
L_8c8588:
	mov_s r2,0x1008a58
L_8c858e:
	mov_s r1,0x12e6
L_8c8594:
	bl.d L_8c82c0
L_8c8598:
	mov_s r3,0xd3
	.global L_8c859a
L_8c859a:
	b L_8c033c
L_8c859e:
	nop_s
