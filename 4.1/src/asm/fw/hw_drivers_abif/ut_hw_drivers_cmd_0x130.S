/* ut_hw_drivers_cmd_0x130 @ 0x8cc45c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x130,"ax",@progbits
	.global ut_hw_drivers_cmd_0x130
ut_hw_drivers_cmd_0x130:
	.global L_8cc45c
L_8cc45c:
	push_s blink
L_8cc45e:
	bl L_8c02bc
L_8cc462:
	cmp_s r0,0x40
L_8cc464:
	mov_s r13,r0
L_8cc466:
	mov_s r16,r1
L_8cc468:
	bge_s L_8cc488
	.global L_8cc46a
L_8cc46a:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cc46c:
	/* add_s r13,0x3 */
	.byte 0x03,0xe5
L_8cc46e:
	mov_s r0,0x88a208
L_8cc474:
	add2_s r0,r0,r13
L_8cc476:
	ld_s r1,[r0]
L_8cc478:
	asl r14,r16,0x4
L_8cc47c:
	bic r1,r1,0xf0
L_8cc480:
	or_s r14,r14,r1
L_8cc482:
	st_s r14,[r0]
L_8cc484:
	b L_8c0324
	.global L_8cc488
L_8cc488:
	mov_s r0,blink
L_8cc48a:
	mov_s r2,0x1019954
L_8cc490:
	mov_s r1,0xff
L_8cc492:
	bset_s r1,r1,0xc
L_8cc494:
	bl.d L_8c82c0
L_8cc498:
	mov r3,0x5a9
L_8cc49c:
	b_s L_8cc46a
L_8cc49e:
	nop_s
