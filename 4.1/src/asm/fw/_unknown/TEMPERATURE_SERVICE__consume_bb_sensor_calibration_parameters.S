/* TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters @ 0x8c6464, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TEMPERATURE_SERVICE::consume_bb_sensor_calibration_parameters() BB not calibrated!
 *   TEMPERATURE_SERVICE::consume_bb_sensor_calibration_parameters Calibration() values - Tamb=%d, Initial Temp=%d, Delta(floor, Q13)=%d
 * Зовут его: perform_first_measurement_operations
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_divmod_signed, fw_log__emit0, fw_log__emit3
 * Глобалы (через gp): 0x8001f6, 0x8001f8, 0x8002b8, 0x8002bc
 */
	.section .text.TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters,"ax",@progbits
	.global TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters
TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters:
	.global L_8c6464
L_8c6464:
	push_s blink
L_8c6466:
	bl.d L_8c02c0
L_8c646a:
	mov r0,-0x1
L_8c646e:
	ldw.x.as r15,[gp,0x43]
L_8c6472:
	mov_s r14,0x1
L_8c6474:
	breq r15,r0,L_8c6480
L_8c6478:
	ldw.x.as r13,[gp,0x44]
L_8c647c:
	brne r13,r0,L_8c6490
	.global L_8c6480
L_8c6480:
	mov_s r2,0x100fbf4
L_8c6486:
	mov_s r0,0x6
L_8c6488:
	bl.d L_8edfb0
L_8c648c:
	mov_s r1,0x1
L_8c648e:
	b_s L_8c64b8
	.global L_8c6490
L_8c6490:
	sub r0,r13,r15
L_8c6494:
	bl.d L_8c03bc
L_8c6498:
	mov_s r1,0x64
L_8c649a:
	asl r5,r0,0xd
L_8c649e:
	st.as r5,[gp,0x52]
L_8c64a2:
	st.as r14,[gp,0x53]
L_8c64a6:
	mov_s r2,0x100fc48
L_8c64ac:
	mov_s r0,0x6
L_8c64ae:
	mov_s r1,0x2
L_8c64b0:
	mov_s r3,r13
L_8c64b2:
	bl.d L_8ee034
L_8c64b6:
	mov_s r4,r15
	.global L_8c64b8
L_8c64b8:
	b L_8c032c
