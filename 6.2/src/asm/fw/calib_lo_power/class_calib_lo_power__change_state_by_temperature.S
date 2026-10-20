/* class_calib_lo_power__change_state_by_temperature @ 0x8c5c68, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   class_calib_lo_power::change_state_by_temperature undefined temeperature state: %d
 *   class_calib_lo_power::change_state_by_temperature: TEMPERATURE_ROOM [temperature: %d]>[low_to_room: %d]
 *   class_calib_lo_power::change_state_by_temperature: TEMPERATURE_HIGH [temperature: %d]>[room_to_high: %d]
 *   class_calib_lo_power::change_state_by_temperature: TEMPERATURE_LOW [temperature: %d]<[room_to_low: %d]
 *   class_calib_lo_power::change_state_by_temperature: TEMPERATURE_ROOM [temperature: %d]<[high_to_room: %d]
 * Зовут его: basic_calib_sparrow__estimation_alg
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, fw_log_emit2, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global class_calib_lo_power__change_state_by_temperature
class_calib_lo_power__change_state_by_temperature:
	.global L_8c5c68
L_8c5c68:
	sub_s sp,sp,0x10
L_8c5c6a:
	push_s blink
L_8c5c6c:
	bl.d L_8c01e0
L_8c5c70:
	mov_s r7,r3
L_8c5c72:
	mov_s r15,r5
L_8c5c74:
	mov.f r13,r2
L_8c5c78:
	mov_s r3,r6
L_8c5c7a:
	mov_s r14,r1
L_8c5c7c:
	beq_s L_8c5cb8
L_8c5c7e:
	breq r13,0x1,L_8c5ce0
L_8c5c82:
	breq r13,0x2,L_8c5ca0
L_8c5c86:
	mov_s r1,0x100a428
L_8c5c8c:
	bl.d L_8dcc10
L_8c5c90:
	mov_s r0,0x6
L_8c5c92:
	mov_s r0,blink
L_8c5c94:
	mov_s r1,0x142d
L_8c5c9a:
	bl L_8c9b28
L_8c5c9e:
	b_s L_8c5cf4
	.global L_8c5ca0
L_8c5ca0:
	brge r4,r14,L_8c5cf4
L_8c5ca4:
	mov_s r1,0x100a47c
L_8c5caa:
	mov_s r0,0x26
L_8c5cac:
	mov_s r2,r14
L_8c5cae:
	bl.d L_8dcc80
L_8c5cb2:
	mov_s r3,r4
L_8c5cb4:
	mov_s r13,0x0
L_8c5cb6:
	b_s L_8c5cf4
	.global L_8c5cb8
L_8c5cb8:
	brge r15,r14,L_8c5ccc
L_8c5cbc:
	mov_s r13,0x1
L_8c5cbe:
	mov_s r1,0x100a4e4
L_8c5cc4:
	mov_s r0,0x26
L_8c5cc6:
	mov_s r2,r14
L_8c5cc8:
	mov_s r3,r15
L_8c5cca:
	b_s L_8c5cf0
	.global L_8c5ccc
L_8c5ccc:
	brge r14,r7,L_8c5cf4
L_8c5cd0:
	mov_s r13,0x2
L_8c5cd2:
	mov_s r1,0x100a550
L_8c5cd8:
	mov_s r0,0x26
L_8c5cda:
	mov_s r2,r14
L_8c5cdc:
	mov_s r3,r7
L_8c5cde:
	b_s L_8c5cf0
	.global L_8c5ce0
L_8c5ce0:
	brge r14,r3,L_8c5cf4
L_8c5ce4:
	mov_s r13,0x0
L_8c5ce6:
	mov_s r1,0x100a5b8
L_8c5cec:
	mov_s r0,0x26
L_8c5cee:
	mov_s r2,r14
	.global L_8c5cf0
L_8c5cf0:
	bl L_8dcc80
	.global L_8c5cf4
L_8c5cf4:
	mov_s r0,r13
L_8c5cf6:
	mov_s r12,0x14
L_8c5cf8:
	b L_8c024e
