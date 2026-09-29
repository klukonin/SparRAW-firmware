/* calib_engine_sm__check_correction_needed @ 0x8c5180, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_engine_sm::check_correction_needed() - unlocking radio 0x%x
 *   calib_engine.cpp
 * Зовёт сам: RADIO_MGR__unlock, __ld_r13_ret, basic_sm__store_pending_event, fw_log__emit1, fw_sysassert_fatal, u_schd__schedule
 */
	.section .text.calib_engine_sm__check_correction_needed,"ax",@progbits
	.global calib_engine_sm__check_correction_needed
calib_engine_sm__check_correction_needed:
L_8c5180:
	push_s blink
L_8c5182:
	push_s r13
L_8c5184:
	ld_s r3,[r0,0x48]
L_8c5186:
	mov_s r13,r0
L_8c5188:
	breq_s r3,0,L_8c51a2
L_8c518a:
	mov_s r2,0x1008a6c
L_8c5190:
	mov_s r0,0x6
L_8c5192:
	bl.d L_8edfcc
L_8c5196:
	mov_s r1,0x2
L_8c5198:
	bl.d L_8e54d8
L_8c519c:
	ld_s r0,[r13,0x48]
L_8c519e:
	mov_s r0,0x0
L_8c51a0:
	st_s r0,[r13,0x48]
	.global L_8c51a2
L_8c51a2:
	ld_s r1,[r13,0x3c]
L_8c51a4:
	ld_s r0,[r13,0x40]
L_8c51a6:
	brne r1,r0,L_8c51ce
L_8c51aa:
	ld_s r1,[r13,0x30]
L_8c51ac:
	mov_s r2,0x0
L_8c51ae:
	add_s r1,r1,r1
L_8c51b0:
	add2_s r1,r1,r1
L_8c51b2:
	add_s r1,r1,0x854880
L_8c51b8:
	ldw_s r0,[r1,0x36]
L_8c51ba:
	mov_s r3,r2
L_8c51bc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c51be:
	extw_s r0,r0
L_8c51c0:
	stw_s r0,[r1,0x36]
L_8c51c2:
	mov_s r0,r13
L_8c51c4:
	mov_s r1,0x4
L_8c51c6:
	bl.d L_8e20c0
L_8c51ca:
	mov_s r4,r2
L_8c51cc:
	b_s L_8c523e
	.global L_8c51ce
L_8c51ce:
	ld_s r0,[r13,0x5c]
L_8c51d0:
	brne r0,0x3,L_8c522a
L_8c51d4:
	breq_s r1,0,L_8c51fe
	.global L_8c51d6
L_8c51d6:
	ld_s r0,[r13,0x4c]
L_8c51d8:
	brne_s r0,0,L_8c5214
	.global L_8c51da
L_8c51da:
	ldw r1,[r13, 0x44]
L_8c51de:
	mov_s r0,0x16acc
L_8c51e4:
	mul64 r1,0x3e8
L_8c51e8:
	mov_s r2,0x0
L_8c51ea:
	mov_s r1,r13
L_8c51ec:
	mov_s r3,r2
L_8c51ee:
	mov r4,mlo
L_8c51f2:
	mov_s r5,r2
L_8c51f4:
	bl.d L_8dc92c
L_8c51f8:
	mov_s r6,r2
L_8c51fa:
	st_s r0,[r13,0x4c]
L_8c51fc:
	b_s L_8c523e
	.global L_8c51fe
L_8c51fe:
	mov_s r0,blink
L_8c5200:
	mov_s r2,0x1008a58
L_8c5206:
	mov_s r1,0x1206
L_8c520c:
	bl.d L_8c82c0
L_8c5210:
	mov_s r3,0xec
L_8c5212:
	b_s L_8c51d6
	.global L_8c5214
L_8c5214:
	mov_s r0,blink
L_8c5216:
	mov_s r2,0x1008a58
L_8c521c:
	mov_s r1,0x1209
L_8c5222:
	bl.d L_8c82c0
L_8c5226:
	mov_s r3,0xed
L_8c5228:
	b_s L_8c51da
	.global L_8c522a
L_8c522a:
	mov_s r0,blink
L_8c522c:
	mov_s r2,0x1008a58
L_8c5232:
	mov_s r1,0x12e5
L_8c5238:
	bl.d L_8c82c0
L_8c523c:
	mov_s r3,0xf9
	.global L_8c523e
L_8c523e:
	.byte 0x01,0x01
