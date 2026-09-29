/* ut_hw_drivers_cmd_0x154 @ 0x8cc61c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, lo_power_gc_ctrl
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, ut_hw_drivers_cmd_0x142
 */
	.section .text.ut_hw_drivers_cmd_0x154,"ax",@progbits
	.global ut_hw_drivers_cmd_0x154
ut_hw_drivers_cmd_0x154:
	.global L_8cc61c
L_8cc61c:
	push_s blink
L_8cc61e:
	bl L_8c02c0
L_8cc622:
	brlt.d r1,r0,L_8cc64e
L_8cc626:
	mov_s r15,r2
L_8cc628:
	sub_s r1,r1,r0
L_8cc62a:
	extb_s r1,r1
L_8cc62c:
	add_s r13,r1,0x1
L_8cc62e:
	mov_s r14,r0
	.global L_8cc630
L_8cc630:
	mov_s r0,r14
L_8cc632:
	mov_s r1,0x0
L_8cc634:
	bl.d L_8cc5b0
L_8cc638:
	mov_s r2,r15
L_8cc63a:
	mov_s r0,r14
L_8cc63c:
	mov_s r1,0x1
L_8cc63e:
	bl.d L_8cc5b0
L_8cc642:
	mov_s r2,r15
L_8cc644:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8cc646:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cc648:
	brhs.d r13,0x1,L_8cc630
L_8cc64c:
	extb_s r14,r14
	.global L_8cc64e
L_8cc64e:
	b L_8c032c
L_8cc652:
	nop_s
