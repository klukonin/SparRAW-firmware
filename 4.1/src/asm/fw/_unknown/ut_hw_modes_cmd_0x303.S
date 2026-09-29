/* ut_hw_modes_cmd_0x303 @ 0x8d51e4, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: __ld_r13_ret, hw_modes__enable_pll, hwm__reset_analog_block, mac__program_gp_timer
 */
	.section .text.ut_hw_modes_cmd_0x303,"ax",@progbits
	.global ut_hw_modes_cmd_0x303
ut_hw_modes_cmd_0x303:
	.global L_8d51e4
L_8d51e4:
	push_s blink
L_8d51e6:
	push_s r13
L_8d51e8:
	mov_s r13,r1
L_8d51ea:
	brne r0,0x1,L_8d5202
L_8d51ee:
	cmp_s r13,0x0
L_8d51f0:
	mov.ne r0,0x28
L_8d51f4:
	bl.ne.d L_8e4920
L_8d51f8:
	mov.ne r1,0x1
L_8d51fc:
	bl L_8d4c70
L_8d5200:
	b_s L_8d5216
	.global L_8d5202
L_8d5202:
	bl L_8d4ca4
L_8d5206:
	cmp_s r13,0x0
L_8d5208:
	mov.ne r0,0xa5
L_8d5210:
	bl.ne.d L_8e4920
L_8d5214:
	sub_s.ne r1,r1,r1
	.global L_8d5216
L_8d5216:
	b L_8c033c
L_8d521a:
	nop_s
