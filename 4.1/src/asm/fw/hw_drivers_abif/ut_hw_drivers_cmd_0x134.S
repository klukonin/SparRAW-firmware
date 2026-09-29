/* ut_hw_drivers_cmd_0x134 @ 0x8cc7b8, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x134,"ax",@progbits
	.global ut_hw_drivers_cmd_0x134
ut_hw_drivers_cmd_0x134:
	.global L_8cc7b8
L_8cc7b8:
	push_s blink
L_8cc7ba:
	bl L_8c02c4
L_8cc7be:
	cmp_s r0,0x40
L_8cc7c0:
	mov_s r14,r0
L_8cc7c2:
	bge.d L_8cc802
L_8cc7c6:
	mov_s r13,r1
	.global L_8cc7c8
L_8cc7c8:
	brge r13,0x6,L_8cc81a
L_8cc7cc:
	brlt r13,0x1,L_8cc81a
	.global L_8cc7d0
L_8cc7d0:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8cc7d2:
	extb_s r13,r13
L_8cc7d4:
	mov_s r0,0x801818
L_8cc7da:
	ld.as r1,[r0,r13]
L_8cc7de:
	add2_s r1,r1,r14
L_8cc7e0:
	mov_s r0,0x800518
L_8cc7e6:
	sub r0,r0,0x20
L_8cc7ea:
	add_s r0,r0,r13
L_8cc7ec:
	ldb r2,[r0, 0x3c]
L_8cc7f0:
	mov_s r0,0x88a208
L_8cc7f6:
	ld.as r0,[r0,r1]
L_8cc7fa:
	lsr_s r0,r0,r2
L_8cc7fc:
	b.d L_8c0334
L_8cc800:
	bmsk_s r0,r0,0x3
	.global L_8cc802
L_8cc802:
	mov_s r0,blink
L_8cc804:
	mov_s r2,0x1019954
L_8cc80a:
	mov_s r1,0x12e1
L_8cc810:
	bl.d L_8c82c0
L_8cc814:
	mov r3,0x5d6
L_8cc818:
	b_s L_8cc7c8
	.global L_8cc81a
L_8cc81a:
	mov_s r0,blink
L_8cc81c:
	mov_s r2,0x1019954
L_8cc822:
	mov_s r1,0x12e2
L_8cc828:
	bl.d L_8c82c0
L_8cc82c:
	mov r3,0x5d7
L_8cc830:
	b_s L_8cc7d0
L_8cc832:
	nop_s
