/* ut_hw_drivers_cmd_0x143 @ 0x8cc9a0, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x143,"ax",@progbits
	.global ut_hw_drivers_cmd_0x143
ut_hw_drivers_cmd_0x143:
	.global L_8cc9a0
L_8cc9a0:
	push_s blink
L_8cc9a2:
	bl L_8c02c4
L_8cc9a6:
	mov_s r14,r0
L_8cc9a8:
	brge.d r1,0x2,L_8cc9d0
L_8cc9ac:
	mov_s r13,r1
	.global L_8cc9ae
L_8cc9ae:
	cmp_s r14,0x40
L_8cc9b0:
	bge_s L_8cc9e8
	.global L_8cc9b2
L_8cc9b2:
	mov_s r0,0x8004f8
L_8cc9b8:
	ldb_s r1,[r0,r13]
L_8cc9ba:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8cc9bc:
	mov_s r0,0x88a208
L_8cc9c2:
	add2_s r13,r13,r14
L_8cc9c4:
	ld.as r0,[r0,r13]
L_8cc9c8:
	lsr_s r0,r0,r1
L_8cc9ca:
	b.d L_8c0334
L_8cc9ce:
	bmsk_s r0,r0,0x3
	.global L_8cc9d0
L_8cc9d0:
	mov_s r0,blink
L_8cc9d2:
	mov_s r2,0x1019954
L_8cc9d8:
	mov_s r1,0x12fe
L_8cc9de:
	bl.d L_8c82c0
L_8cc9e2:
	mov r3,0x549
L_8cc9e6:
	b_s L_8cc9ae
	.global L_8cc9e8
L_8cc9e8:
	mov_s r0,blink
L_8cc9ea:
	mov_s r2,0x1019954
L_8cc9f0:
	mov_s r1,0x12ff
L_8cc9f6:
	bl.d L_8c82c0
L_8cc9fa:
	mov r3,0x54a
L_8cc9fe:
	b_s L_8cc9b2
