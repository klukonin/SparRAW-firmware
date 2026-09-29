/* ut_hw_drivers_cmd_0x142 @ 0x8cc5b0, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, ut_hw_drivers_cmd_0x154
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x142,"ax",@progbits
	.global ut_hw_drivers_cmd_0x142
ut_hw_drivers_cmd_0x142:
	.global L_8cc5b0
L_8cc5b0:
	push_s blink
L_8cc5b2:
	bl L_8c02c0
L_8cc5b6:
	mov_s r14,r0
L_8cc5b8:
	mov_s r13,r1
L_8cc5ba:
	brge.d r1,0x2,L_8cc5ec
L_8cc5be:
	mov_s r15,r2
	.global L_8cc5c0
L_8cc5c0:
	cmp_s r14,0x40
L_8cc5c2:
	bge L_8cc604
	.global L_8cc5c6
L_8cc5c6:
	mov_s r0,0x8004f8
L_8cc5cc:
	ldb_s r1,[r0,r13]
L_8cc5ce:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8cc5d0:
	add2_s r13,r13,r14
L_8cc5d2:
	mov_s r0,0x88a208
L_8cc5d8:
	add2_s r0,r0,r13
L_8cc5da:
	ld_s r3,[r0]
L_8cc5dc:
	mov_s r2,0xf
L_8cc5de:
	asl_s r2,r2,r1
L_8cc5e0:
	bic_s r3,r3,r2
L_8cc5e2:
	asl_s r15,r15,r1
L_8cc5e4:
	or_s r3,r3,r15
L_8cc5e6:
	st_s r3,[r0]
L_8cc5e8:
	b L_8c032c
	.global L_8cc5ec
L_8cc5ec:
	mov_s r0,blink
L_8cc5ee:
	mov_s r2,0x1019954
L_8cc5f4:
	mov_s r1,0x1307
L_8cc5fa:
	bl.d L_8c82c0
L_8cc5fe:
	mov r3,0x52f
L_8cc602:
	b_s L_8cc5c0
	.global L_8cc604
L_8cc604:
	mov_s r0,blink
L_8cc606:
	mov_s r2,0x1019954
L_8cc60c:
	mov_s r1,0x1308
L_8cc612:
	bl.d L_8c82c0
L_8cc616:
	mov r3,0x530
L_8cc61a:
	b_s L_8cc5c6
