/* power__enter_halt @ 0x8e4678, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: u_schd__large_task_warn
 * Зовёт сам: power__start_two_timers, power__store_and_program_880200, set_reg_880200_8e4304
 */
	.section .text.power__enter_halt,"ax",@progbits
	.global power__enter_halt
power__enter_halt:
	.global L_8e4678
L_8e4678:
	push_s blink
L_8e467a:
	add_s r0,gp,0x70
L_8e467c:
	mov_s r1,0xa5
L_8e467e:
	/* bl.d 0x008d5bc4 */
	.byte 0x4a,0x0d,0xaf,0xf8
L_8e4682:
	/* _asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8e4684:
	bl L_8e46a0
L_8e4688:
	bl.d L_8e4304
L_8e468c:
	mov_s r0,0x1
L_8e468e:
	pop_s blink
L_8e4690:
	j_s [blink]
L_8e4692:
	nop_s
