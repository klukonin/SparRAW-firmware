/* hw_modes__program_rf_clocks @ 0x8d519c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, power_halt_seq
 * Зовёт сам: abif__program_rf_clock_and_wait, hwd_abif__program_rf_clk, hwd_abif__rgf_889480_8cbc90, hwd_rfc__program_clocks, obj__get_field_0x424
 */
	.section .text.hw_modes__program_rf_clocks,"ax",@progbits
	.global hw_modes__program_rf_clocks
hw_modes__program_rf_clocks:
	.global L_8d519c
L_8d519c:
	cmp_s r0,0x1
L_8d519e:
	push_s blink
L_8d51a0:
	mov_s r0,0x0
L_8d51a2:
	bne_s L_8d51b4
L_8d51a4:
	bl L_8d0394
L_8d51a8:
	bl L_8cb9dc
L_8d51ac:
	bl.d L_8cbc90
L_8d51b0:
	mov_s r0,0x1
L_8d51b2:
	b_s L_8d51cc
	.global L_8d51b4
L_8d51b4:
	bl L_8cbc90
L_8d51b8:
	mov_s r0,0x803e84
L_8d51be:
	bl L_8c9f98
L_8d51c2:
	bl L_8cba10
L_8d51c6:
	bl.d L_8d0394
L_8d51ca:
	mov_s r0,0x1
	.global L_8d51cc
L_8d51cc:
	pop_s blink
L_8d51ce:
	j_s [blink]
