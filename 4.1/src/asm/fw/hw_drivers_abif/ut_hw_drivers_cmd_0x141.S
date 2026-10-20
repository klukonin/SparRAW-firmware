/* ut_hw_drivers_cmd_0x141 @ 0x8cc728, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x141,"ax",@progbits
	.global ut_hw_drivers_cmd_0x141
ut_hw_drivers_cmd_0x141:
	.global L_8cc728
L_8cc728:
	push_s blink
L_8cc72a:
	bl L_8c02c0
L_8cc72e:
	mov_s r15,r0
L_8cc730:
	mov_s r14,r1
L_8cc732:
	brge.d r1,0x5,L_8cc76e
L_8cc736:
	mov_s r13,r2
L_8cc738:
	brlt r14,0x2,L_8cc76e
	.global L_8cc73c
L_8cc73c:
	brge r13,0x2,L_8cc786
	.global L_8cc740
L_8cc740:
	cmp_s r15,0x40
L_8cc742:
	bge L_8cc79e
	.global L_8cc746
L_8cc746:
	rsub r0,r14,0x4
L_8cc74a:
	extb_s r0,r0
L_8cc74c:
	add2_s r0,r0,r13
L_8cc74e:
	add r1,r0,0x8004f8
L_8cc756:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8cc758:
	add2_s r13,r13,r15
L_8cc75a:
	mov_s r0,0x88a208
L_8cc760:
	ld.as r0,[r0,r13]
L_8cc764:
	ldb_s r1,[r1,0xc]
L_8cc766:
	lsr_s r0,r0,r1
L_8cc768:
	b.d L_8c032c
L_8cc76c:
	bmsk_s r0,r0,0x0
	.global L_8cc76e
L_8cc76e:
	mov_s r0,blink
L_8cc770:
	mov_s r2,0x1019954
L_8cc776:
	mov_s r1,0x1303
L_8cc77c:
	bl.d L_8c82c0
L_8cc780:
	mov r3,0x58a
L_8cc784:
	b_s L_8cc73c
	.global L_8cc786
L_8cc786:
	mov_s r0,blink
L_8cc788:
	mov_s r2,0x1019954
L_8cc78e:
	mov_s r1,0x1304
L_8cc794:
	bl.d L_8c82c0
L_8cc798:
	mov r3,0x58b
L_8cc79c:
	b_s L_8cc740
	.global L_8cc79e
L_8cc79e:
	mov_s r0,blink
L_8cc7a0:
	mov_s r2,0x1019954
L_8cc7a6:
	mov_s r1,0x1305
L_8cc7ac:
	bl.d L_8c82c0
L_8cc7b0:
	mov r3,0x58c
L_8cc7b4:
	b_s L_8cc746
L_8cc7b6:
	nop_s
