/* TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters @ 0x8ddecc, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TEMPERATURE_SERVICE::read_rf_sensor_calibration_parameters() RF temperature param could not be read from OTP!
 *   TEMPERATURE_SERVICE::read_rf_sensor_calibration_parameters() ambient param could not be read from sensor!
 *   TEMPERATURE_SERVICE::read_sensor_calibration_parameters() RF not calibrated!
 *   TEMPERATURE_SERVICE::read_rf_sensor_calibration_parameters() Calibration values - Tamb=%d, Initial Temp=%d, Delta(mult10)=%d
 * Зовут его: perform_first_measurement_operations
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit3, hwf_rf_xpm_read_block
 * Глобалы (через gp): 0x80043c, 0x800440
 */
	.section .text.TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters,"ax",@progbits
	.global TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters
TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters:
	.global L_8ddecc
L_8ddecc:
	push_s blink
L_8ddece:
	push_s r13
L_8dded0:
	sub_s sp,sp,0x8
L_8dded2:
	mov_s r3,sp
L_8dded4:
	mov_s r13,0x0
L_8dded6:
	mov_s r0,r13
L_8dded8:
	mov r1,0x2f0
L_8ddedc:
	bl.d L_8ec29c
L_8ddee0:
	mov_s r2,0x2
L_8ddee2:
	brne_s r0,0,L_8ddef6
L_8ddee4:
	mov_s r2,0x100fccc
L_8ddeea:
	mov_s r0,0x6
L_8ddeec:
	bl.d L_8edfb0
L_8ddef0:
	mov_s r1,r13
L_8ddef2:
	stw r13,[sp]
	.global L_8ddef6
L_8ddef6:
	add r3,sp,0x2
L_8ddefa:
	mov_s r0,0x0
L_8ddefc:
	mov r1,0x300
L_8ddf00:
	bl.d L_8ec29c
L_8ddf04:
	mov_s r2,0x2
L_8ddf06:
	brne_s r0,0,L_8ddf1a
L_8ddf08:
	mov_s r2,0x100fd3c
L_8ddf0e:
	mov_s r0,0x6
L_8ddf10:
	bl.d L_8edfb0
L_8ddf14:
	mov_s r1,0x0
L_8ddf16:
	stw r13,[sp, 0x2]
	.global L_8ddf1a
L_8ddf1a:
	ldw.x r0,[sp, 0x2]
L_8ddf1e:
	brne_s r0,0,L_8ddf28
L_8ddf20:
	stw 0xbb8,[sp, 0x2]
	.global L_8ddf28
L_8ddf28:
	ldw.x r0,[sp]
L_8ddf2c:
	brne_s r0,0,L_8ddf3c
L_8ddf2e:
	mov_s r2,0x100fda8
L_8ddf34:
	mov_s r0,0x6
L_8ddf36:
	bl.d L_8edfb0
L_8ddf3a:
	mov_s r1,0x1
	.global L_8ddf3c
L_8ddf3c:
	ldw.x r3,[sp, 0x2]
L_8ddf40:
	ldw.x r4,[sp]
L_8ddf44:
	mov_s r2,0x100fdf8
L_8ddf4a:
	sub r0,r3,r4
L_8ddf4e:
	add r5,r0,r0
L_8ddf52:
	add2 r5,r5,r5
L_8ddf56:
	ld_s r0,[gp,0x2d0]
L_8ddf58:
	st.as r5,[gp,0xb3]
L_8ddf5c:
	bset_s r0,r0,0x0
L_8ddf5e:
	st.as r0,[gp,0xb4]
L_8ddf62:
	mov_s r0,0x6
L_8ddf64:
	bl.d L_8ee034
L_8ddf68:
	mov_s r1,0x2
L_8ddf6a:
	b.d L_8c033c
L_8ddf6e:
	add_s sp,sp,0x8
