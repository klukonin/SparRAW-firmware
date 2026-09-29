/* sm_pring__notify_vring_state @ 0x8ea1b4, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__connectivity_update, sm_pring__slot_optimized
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, obj__has_pending_1c_10, sm_pring__bind_vring, sm_pring__by_index, sm_pring__connectivity_update, sm_pring__notify_step, vring_schd__stop_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_pring__notify_vring_state
sm_pring__notify_vring_state:
	.global L_8ea1b4
L_8ea1b4:
	push_s blink
L_8ea1b6:
	bl L_8c01dc
L_8ea1ba:
	mov.f r15,r1
L_8ea1be:
	mov_s r13,r0
L_8ea1c0:
	beq_s L_8ea1f8
	.global L_8ea1c2
L_8ea1c2:
	mul64 r13,0x3c
L_8ea1c6:
	mov_s r14,0x804dbc
L_8ea1cc:
	add r13,r14,0x28
L_8ea1d0:
	add.f r13,r13,mlo
L_8ea1d4:
	beq_s L_8ea206
	.global L_8ea1d6
L_8ea1d6:
	ld r16,[r13, 0x14]
L_8ea1da:
	brne r15,r16,L_8ea236
L_8ea1de:
	bl.d L_8c3800
L_8ea1e2:
	mov_s r0,r14
L_8ea1e4:
	brne r0,0x1,L_8ea214
L_8ea1e8:
	mov_s r0,0x4
L_8ea1ea:
	st r0,[r16, 0x24]
L_8ea1ee:
	mov_s r0,r14
L_8ea1f0:
	bl.d L_8e80cc
L_8ea1f4:
	mov_s r1,r13
L_8ea1f6:
	b_s L_8ea236
	.global L_8ea1f8
L_8ea1f8:
	mov_s r0,blink
L_8ea1fa:
	mov_s r1,0x12bb
L_8ea200:
	bl L_8c9b28
L_8ea204:
	b_s L_8ea1c2
	.global L_8ea206
L_8ea206:
	mov_s r0,blink
L_8ea208:
	mov_s r1,0x12bc
L_8ea20e:
	bl L_8c9b28
L_8ea212:
	b_s L_8ea1d6
	.global L_8ea214
L_8ea214:
	ld.as r4,[gp,-0x43]
L_8ea218:
	mov_s r0,r13
L_8ea21a:
	ldb r1,[r16, 0x9]
L_8ea21e:
	ld.as r2,[gp,-0x44]
L_8ea222:
	ld.as r3,[gp,-0x45]
L_8ea226:
	bl.d L_8c49a0
L_8ea22a:
	mov r5,r16
L_8ea22e:
	mov_s r0,r16
L_8ea230:
	bl.d L_8eaa38
L_8ea234:
	mov_s r1,0x1
	.global L_8ea236
L_8ea236:
	b L_8c0244
L_8ea23a:
	nop_s
L_8ea23c:
	push_s blink
L_8ea23e:
	push_s r13
L_8ea240:
	mov_s r13,r0
L_8ea242:
	bl.d L_8cca20
L_8ea246:
	mov_s r0,r1
L_8ea248:
	bl.d L_8ea254
L_8ea24c:
	mov_s r1,r13
L_8ea24e:
	b L_8c025c
L_8ea252:
	nop_s
