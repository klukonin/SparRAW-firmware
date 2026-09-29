/* ut_hw_drivers_cmd_0x155 @ 0x8cc398, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, lo_power_gc_ctrl
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, ut_hw_drivers_cmd_0x133
 */
	.section .text.ut_hw_drivers_cmd_0x155,"ax",@progbits
	.global ut_hw_drivers_cmd_0x155
ut_hw_drivers_cmd_0x155:
	.global L_8cc398
L_8cc398:
	push_s blink
L_8cc39a:
	bl L_8c02bc
L_8cc39e:
	mov_s r16,r2
L_8cc3a0:
	brlt.d r1,r0,L_8cc3c2
L_8cc3a4:
	mov_s r15,r3
L_8cc3a6:
	sub_s r1,r1,r0
L_8cc3a8:
	extb_s r1,r1
L_8cc3aa:
	add_s r13,r1,0x1
L_8cc3ac:
	mov_s r14,r0
	.global L_8cc3ae
L_8cc3ae:
	mov_s r0,r14
L_8cc3b0:
	mov_s r1,r16
L_8cc3b2:
	bl.d L_8cc314
L_8cc3b6:
	mov_s r2,r15
L_8cc3b8:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8cc3ba:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cc3bc:
	brhs.d r13,0x1,L_8cc3ae
L_8cc3c0:
	extb_s r14,r14
	.global L_8cc3c2
L_8cc3c2:
	b L_8c0324
L_8cc3c6:
	nop_s
