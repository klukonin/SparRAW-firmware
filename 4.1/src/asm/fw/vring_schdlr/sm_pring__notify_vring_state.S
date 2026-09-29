/* sm_pring__notify_vring_state @ 0x8e4df4, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schdlr.cpp
 * Зовут его: sm_pring__connectivity_update, sm_pring__slot_optimized
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, pring__is_idle, sm_pring__bind_vring, tail_sm_pring__state_step, vr_obj__update_connected_duration
 */
	.section .text.sm_pring__notify_vring_state,"ax",@progbits
	.global sm_pring__notify_vring_state
sm_pring__notify_vring_state:
	.global L_8e4df4
L_8e4df4:
	push_s blink
L_8e4df6:
	bl L_8c02bc
L_8e4dfa:
	mov.f r15,r1
L_8e4dfe:
	mov_s r13,r0
L_8e4e00:
	beq_s L_8e4e38
	.global L_8e4e02
L_8e4e02:
	mul64 r13,0x38
L_8e4e06:
	mov_s r14,0x804580
L_8e4e0c:
	add r13,r14,0x24
L_8e4e10:
	add.f r13,r13,mlo
L_8e4e14:
	beq_s L_8e4e50
	.global L_8e4e16
L_8e4e16:
	ld r16,[r13, 0x14]
L_8e4e1a:
	brne r15,r16,L_8e4e8a
L_8e4e1e:
	bl.d L_8c30d0
L_8e4e22:
	mov_s r0,r14
L_8e4e24:
	brne r0,0x1,L_8e4e68
L_8e4e28:
	mov_s r0,0x4
L_8e4e2a:
	st r0,[r16, 0x24]
L_8e4e2e:
	mov_s r0,r14
L_8e4e30:
	bl.d L_8e2fec
L_8e4e34:
	mov_s r1,r13
L_8e4e36:
	b_s L_8e4e8a
	.global L_8e4e38
L_8e4e38:
	mov_s r0,blink
L_8e4e3a:
	mov_s r2,0x100a584
L_8e4e40:
	mov_s r1,0x12bb
L_8e4e46:
	bl.d L_8c82c0
L_8e4e4a:
	mov r3,0x1d1
L_8e4e4e:
	b_s L_8e4e02
	.global L_8e4e50
L_8e4e50:
	mov_s r0,blink
L_8e4e52:
	mov_s r2,0x100a584
L_8e4e58:
	mov_s r1,0x12bc
L_8e4e5e:
	bl.d L_8c82c0
L_8e4e62:
	mov r3,0x1d4
L_8e4e66:
	b_s L_8e4e16
	.global L_8e4e68
L_8e4e68:
	ld.as r4,[gp,-0x3e]
L_8e4e6c:
	mov_s r0,r13
L_8e4e6e:
	ldb r1,[r16, 0x9]
L_8e4e72:
	ld.as r2,[gp,-0x3f]
L_8e4e76:
	ld.as r3,[gp,-0x40]
L_8e4e7a:
	bl.d L_8c3fdc
L_8e4e7e:
	mov r5,r16
L_8e4e82:
	mov_s r0,r16
L_8e4e84:
	bl.d L_8e5684
L_8e4e88:
	mov_s r1,0x1
	.global L_8e4e8a
L_8e4e8a:
	.byte 0x9d,0x04
