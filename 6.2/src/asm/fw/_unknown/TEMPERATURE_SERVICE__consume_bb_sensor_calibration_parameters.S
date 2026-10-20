/* TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters @ 0x8c73f0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TEMPERATURE_SERVICE::consume_bb_sensor_calibration_parameters() BB not calibrated!
 *   TEMPERATURE_SERVICE::consume_bb_sensor_calibration_parameters Calibration() values - Tamb=%d, Initial Temp=%d, Delta(floor, Q13)=%d
 * Зовут его: perform_first_measurement_operations
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_divmod_signed, fw_log_emit0, fw_log_emit3
 * Глобалы (через gp): 0x80020e, 0x800210, 0x8002cc, 0x8002d0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters
TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters:
	.global L_8c73f0
L_8c73f0:
	push_s blink
L_8c73f2:
	bl.d L_8c01e4
L_8c73f6:
	mov r0,-0x1
L_8c73fa:
	ldw.x.as r13,[gp,0x45]
L_8c73fe:
	breq r13,r0,L_8c740a
L_8c7402:
	ldw.x.as r14,[gp,0x46]
L_8c7406:
	brne r14,r0,L_8c7418
	.global L_8c740a
L_8c740a:
	mov_s r1,0x1011ec8
L_8c7410:
	bl.d L_8dcba8
L_8c7414:
	mov_s r0,0x16
L_8c7416:
	b_s L_8c7440
	.global L_8c7418
L_8c7418:
	sub r0,r14,r13
L_8c741c:
	bl.d L_8c02dc
L_8c7420:
	mov_s r1,0x64
L_8c7422:
	asl r4,r0,0xd
L_8c7426:
	st.as r4,[gp,0x52]
L_8c742a:
	mov_s r0,0x1
L_8c742c:
	st.as r0,[gp,0x53]
L_8c7430:
	mov_s r1,0x1011f1c
L_8c7436:
	mov_s r0,0x26
L_8c7438:
	mov_s r2,r14
L_8c743a:
	bl.d L_8dcd00
L_8c743e:
	mov_s r3,r13
	.global L_8c7440
L_8c7440:
	b L_8c0254
