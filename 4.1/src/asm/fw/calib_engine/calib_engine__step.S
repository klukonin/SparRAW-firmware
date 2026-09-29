/* calib_engine__step @ 0x8c65d8, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_engine.cpp
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_calib__run_step, basic_sm__store_pending_event, calib_engine__links_active, fw_read_timer, fw_sysassert_fatal, sta_ctx__reset, sta_trace__push_record
 * Глобалы (через gp): 0x80018c
 */
	.section .text.calib_engine__step,"ax",@progbits
	.global calib_engine__step
calib_engine__step:
L_8c65d8:
	push_s blink
L_8c65da:
	bl L_8c02c0
L_8c65de:
	bl.d L_8e4694
L_8c65e2:
	mov_s r14,r0
L_8c65e4:
	mov_s r15,r0
L_8c65e6:
	ld_s r0,[r14,0x3c]
L_8c65e8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c65ea:
	st_s r0,[r14,0x3c]
L_8c65ec:
	bl.d L_8e34e4
L_8c65f0:
	mov_s r0,0x6
L_8c65f2:
	mov_s r1,0x2
L_8c65f4:
	stb_s r1,[r0,0xc]
L_8c65f6:
	ld_s r1,[r14,0x30]
L_8c65f8:
	st.as r0,[gp,0x7]
L_8c65fc:
	stb_s r1,[r0,0xd]
L_8c65fe:
	ld_s r1,[r14,0x34]
L_8c6600:
	st_s r1,[r0,0x10]
L_8c6602:
	ld_s r1,[r14,0x3c]
L_8c6604:
	stb_s r1,[r0,0xf]
L_8c6606:
	ld_s r0,[r14,0x2c]
L_8c6608:
	ld_s r1,[r14,0x34]
L_8c660a:
	ld_s r2,[r14,0x3c]
L_8c660c:
	bl.d L_8c66a4
L_8c6610:
	ld_s r3,[r14,0x40]
L_8c6612:
	mov.f r13,r0
L_8c6616:
	beq_s L_8c6638
L_8c6618:
	breq r13,0x1,L_8c664e
L_8c661c:
	breq r13,0x2,L_8c6664
L_8c6620:
	mov_s r0,blink
L_8c6622:
	mov_s r2,0x1008a58
L_8c6628:
	mov_s r1,0x140a
L_8c662e:
	bl.d L_8c82c0
L_8c6632:
	mov r3,0x11e
L_8c6636:
	b_s L_8c667a
	.global L_8c6638
L_8c6638:
	ld_s r0,[r14,0x30]
L_8c663a:
	add_s r0,r0,r0
L_8c663c:
	add2_s r0,r0,r0
L_8c663e:
	add_s r0,r0,0x854880
L_8c6644:
	ldw_s r1,[r0,0x38]
L_8c6646:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c6648:
	extw_s r1,r1
L_8c664a:
	stw_s r1,[r0,0x38]
L_8c664c:
	b_s L_8c667a
	.global L_8c664e
L_8c664e:
	ld_s r0,[r14,0x30]
L_8c6650:
	add_s r0,r0,r0
L_8c6652:
	add2_s r0,r0,r0
L_8c6654:
	add_s r0,r0,0x854880
L_8c665a:
	ldw_s r1,[r0,0x3a]
L_8c665c:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c665e:
	extw_s r1,r1
L_8c6660:
	stw_s r1,[r0,0x3a]
L_8c6662:
	b_s L_8c667a
	.global L_8c6664
L_8c6664:
	ld_s r0,[r14,0x30]
L_8c6666:
	add_s r0,r0,r0
L_8c6668:
	add2_s r0,r0,r0
L_8c666a:
	add r1,r0,0x854880
L_8c6672:
	ldw_s r0,[r1,0x3c]
L_8c6674:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c6676:
	extw_s r0,r0
L_8c6678:
	stw_s r0,[r1,0x3c]
	.global L_8c667a
L_8c667a:
	ld_s r0,[gp,0x1c]
L_8c667c:
	stb_s r13,[r0,0xe]
L_8c667e:
	bl.d L_8e3488
L_8c6682:
	mov_s r0,0x6
L_8c6684:
	bl L_8e4694
L_8c6688:
	sub_s r0,r0,r15
L_8c668a:
	/* bl.d 0x008e566c */
	.byte 0xe6,0x0f,0x60,0x0f
L_8c668e:
	/* _asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c6690:
	mov_s r0,r14
L_8c6692:
	mov_s r1,0x3
L_8c6694:
	mov_s r2,0x0
L_8c6696:
	mov_s r3,r2
L_8c6698:
	bl.d L_8e20c0
L_8c669c:
	mov_s r4,r2
L_8c669e:
	b L_8c032c
L_8c66a2:
	nop_s
