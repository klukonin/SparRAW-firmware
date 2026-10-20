/* perform_first_measurement_operations @ 0x8dc6f4, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   perform_first_measurement_operations() Calibrated BB measurement=%d
 *   perform_first_measurement_operations() Calibrated RF measurement=%d
 * Зовут его: TEMPERATURE_SERVICE__radio_locked_cb
 * Зовёт сам: TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters, TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters, fw_log__emit1
 * Глобалы (через gp): 0x8002b8, 0x800368, 0x80043c
 */
	.section .text.perform_first_measurement_operations,"ax",@progbits
	.global perform_first_measurement_operations
perform_first_measurement_operations:
	.global L_8dc6f4
L_8dc6f4:
	push_s blink
L_8dc6f6:
	mov_s r0,0x1
L_8dc6f8:
	bl.d L_8c6464
L_8dc6fc:
	st.as r0,[gp,0x7e]
L_8dc700:
	bl L_8ddecc
L_8dc704:
	ld.as r1,[gp,0x52]
L_8dc708:
	mov_s r0,0x0
L_8dc70a:
	brlt.d r1,0x0,L_8dc716
L_8dc70e:
	bset_s r0,r0,0xc
L_8dc710:
	add_s r0,r0,r1
L_8dc712:
	asr_s r0,r0,0xd
L_8dc714:
	b_s L_8dc71c
	.global L_8dc716
L_8dc716:
	sub_s r0,r0,r1
L_8dc718:
	asr_s r0,r0,0xd
L_8dc71a:
	neg_s r0,r0
	.global L_8dc71c
L_8dc71c:
	mul64 r0,0x3e8
L_8dc720:
	ld_s r0,[gp,-0xd0]
L_8dc722:
	mov_s r2,0x100fe78
L_8dc728:
	add r3,r0,mlo
L_8dc72c:
	st.as r3,[gp,-0x34]
L_8dc730:
	mov_s r0,0x6
L_8dc732:
	bl.d L_8edfcc
L_8dc736:
	mov_s r1,0x2
L_8dc738:
	ld.as r3,[gp,-0xd]
L_8dc73c:
	cmp r3,-0x1
L_8dc740:
	beq_s L_8dc758
L_8dc742:
	ld_s r0,[gp,0x2cc]
L_8dc744:
	mov_s r2,0x100febc
L_8dc74a:
	add_s r3,r3,r0
L_8dc74c:
	st.as r3,[gp,-0xd]
L_8dc750:
	mov_s r0,0x6
L_8dc752:
	bl.d L_8edfcc
L_8dc756:
	mov_s r1,0x2
	.global L_8dc758
L_8dc758:
	pop_s blink
L_8dc75a:
	j_s [blink]
