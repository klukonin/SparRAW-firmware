/* class_calib_lo_power__change_state_by_temperature @ 0x8c4e68, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   class_calib_lo_power::change_state_by_temperature undefined temeperature state: %d
 *   calib_lo_power.cpp
 *   class_calib_lo_power::change_state_by_temperature: TEMPERATURE_ROOM [temperature: %d]>[low_to_room: %d]
 *   class_calib_lo_power::change_state_by_temperature: TEMPERATURE_HIGH [temperature: %d]>[room_to_high: %d]
 *   class_calib_lo_power::change_state_by_temperature: TEMPERATURE_LOW [temperature: %d]<[room_to_low: %d]
 *   class_calib_lo_power::change_state_by_temperature: TEMPERATURE_ROOM [temperature: %d]<[high_to_room: %d]
 * Зовут его: class_calib_lo_power__check_online_estimation_condition
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, fw_log__emit2, fw_sysassert_fatal
 */
	.section .text.class_calib_lo_power__change_state_by_temperature,"ax",@progbits
	.global class_calib_lo_power__change_state_by_temperature
class_calib_lo_power__change_state_by_temperature:
	.global L_8c4e68
L_8c4e68:
	sub_s sp,sp,0x10
L_8c4e6a:
	push_s blink
L_8c4e6c:
	push_s r13
L_8c4e6e:
	mov.f r13,r2
L_8c4e72:
	mov_s r7,r3
L_8c4e74:
	mov_s r3,r1
L_8c4e76:
	beq_s L_8c4ebc
L_8c4e78:
	breq r13,0x1,L_8c4ee8
L_8c4e7c:
	breq r13,0x2,L_8c4ea6
L_8c4e80:
	mov_s r2,0x1008e84
L_8c4e86:
	mov_s r0,0x6
L_8c4e88:
	mov_s r1,0x0
L_8c4e8a:
	bl.d L_8edfcc
L_8c4e8e:
	mov_s r3,r13
L_8c4e90:
	mov_s r0,blink
L_8c4e92:
	mov_s r2,0x1008d3c
L_8c4e98:
	mov_s r1,0x142d
L_8c4e9e:
	bl.d L_8c82c0
L_8c4ea2:
	mov_s r3,0xe8
L_8c4ea4:
	b_s L_8c4f00
	.global L_8c4ea6
L_8c4ea6:
	brge r4,r3,L_8c4f00
L_8c4eaa:
	mov_s r2,0x1008ed8
L_8c4eb0:
	mov_s r0,0x6
L_8c4eb2:
	bl.d L_8edff8
L_8c4eb6:
	mov_s r1,0x2
L_8c4eb8:
	mov_s r13,0x0
L_8c4eba:
	b_s L_8c4f00
	.global L_8c4ebc
L_8c4ebc:
	brge r5,r3,L_8c4ed2
L_8c4ec0:
	mov_s r13,0x1
L_8c4ec2:
	mov_s r2,0x1008f40
L_8c4ec8:
	mov_s r0,0x6
L_8c4eca:
	mov_s r1,0x2
L_8c4ecc:
	mov r4,r5
L_8c4ed0:
	b_s L_8c4efc
	.global L_8c4ed2
L_8c4ed2:
	brge r3,r7,L_8c4f00
L_8c4ed6:
	mov_s r1,0x2
L_8c4ed8:
	mov_s r2,0x1008fac
L_8c4ede:
	mov_s r0,0x6
L_8c4ee0:
	mov r4,r7
L_8c4ee4:
	mov_s r13,r1
L_8c4ee6:
	b_s L_8c4efc
	.global L_8c4ee8
L_8c4ee8:
	brge r3,r6,L_8c4f00
L_8c4eec:
	mov_s r13,0x0
L_8c4eee:
	mov_s r2,0x1009014
L_8c4ef4:
	mov_s r0,0x6
L_8c4ef6:
	mov_s r1,0x2
L_8c4ef8:
	mov r4,r6
	.global L_8c4efc
L_8c4efc:
	bl L_8edff8
	.global L_8c4f00
L_8c4f00:
	mov_s r0,r13
L_8c4f02:
	mov_s r12,0x14
L_8c4f04:
	b L_8c033e
