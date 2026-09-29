/* ut_hw_drivers_cmd_0x133 @ 0x8cc314, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, ut_hw_drivers_cmd_0x155
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x133,"ax",@progbits
	.global ut_hw_drivers_cmd_0x133
ut_hw_drivers_cmd_0x133:
	.global L_8cc314
L_8cc314:
	push_s blink
L_8cc316:
	bl L_8c02c0
L_8cc31a:
	mov_s r14,r0
L_8cc31c:
	cmp_s r0,0x40
L_8cc31e:
	mov_s r13,r1
L_8cc320:
	bge.d L_8cc368
L_8cc324:
	mov_s r15,r2
	.global L_8cc326
L_8cc326:
	brge r13,0x6,L_8cc37e
L_8cc32a:
	brlt r13,0x1,L_8cc37e
	.global L_8cc32e
L_8cc32e:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8cc330:
	extb_s r13,r13
L_8cc332:
	mov_s r0,0x801804
L_8cc338:
	ld.as r0,[r0,r13]
L_8cc33c:
	mov_s r1,0x800518
L_8cc342:
	add2_s r0,r0,r14
L_8cc344:
	sub r1,r1,0x20
L_8cc348:
	add_s r1,r1,r13
L_8cc34a:
	ldb r2,[r1, 0x34]
L_8cc34e:
	mov_s r1,0x88a208
L_8cc354:
	add2_s r1,r1,r0
L_8cc356:
	ld_s r3,[r1]
L_8cc358:
	mov_s r0,0xf
L_8cc35a:
	asl_s r0,r0,r2
L_8cc35c:
	bic_s r3,r3,r0
L_8cc35e:
	asl_s r15,r15,r2
L_8cc360:
	or_s r15,r15,r3
L_8cc362:
	st_s r15,[r1]
L_8cc364:
	b L_8c032c
	.global L_8cc368
L_8cc368:
	mov_s r0,blink
L_8cc36a:
	mov_s r2,0x1019954
L_8cc370:
	mov_s r1,0x97
L_8cc372:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8cc374:
	bl.d L_8c82c0
L_8cc378:
	mov r3,0x5bc
L_8cc37c:
	b_s L_8cc326
	.global L_8cc37e
L_8cc37e:
	mov_s r0,blink
L_8cc380:
	mov_s r2,0x1019954
L_8cc386:
	mov_s r1,0x12e4
L_8cc38c:
	bl.d L_8c82c0
L_8cc390:
	mov r3,0x5bd
L_8cc394:
	b_s L_8cc32e
L_8cc396:
	nop_s
