/* vring_schd__bind_if_free @ 0x8c6300, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schdlr.cpp
 * Зовут его: vring_schd__disconnect_notify, vring_schd__find_runnable, vring_schd__move_to_ready
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal, sm_pring__bind_vring, vr_obj__update_connected_duration
 */
	.section .text.vring_schd__bind_if_free,"ax",@progbits
	.global vring_schd__bind_if_free
vring_schd__bind_if_free:
	.global L_8c6300
L_8c6300:
	push_s blink
L_8c6302:
	bl L_8c02bc
L_8c6306:
	ld_s r0,[r2,0x14]
L_8c6308:
	mov_s r16,r1
L_8c630a:
	mov_s r13,r2
L_8c630c:
	brne_s r0,0,L_8c633a
	.global L_8c630e
L_8c630e:
	mov_s r0,0x3
L_8c6310:
	st r0,[r16, 0x24]
L_8c6314:
	ld.as r4,[gp,-0x3e]
L_8c6318:
	mov_s r0,r13
L_8c631a:
	ldb r1,[r16, 0x9]
L_8c631e:
	ld.as r2,[gp,-0x3f]
L_8c6322:
	ld.as r3,[gp,-0x40]
L_8c6326:
	bl.d L_8c3fdc
L_8c632a:
	mov r5,r16
L_8c632e:
	mov_s r0,r16
L_8c6330:
	bl.d L_8e5684
L_8c6334:
	mov_s r1,0x1
L_8c6336:
	b L_8c0324
	.global L_8c633a
L_8c633a:
	mov_s r0,blink
L_8c633c:
	mov_s r2,0x100a584
L_8c6342:
	mov_s r1,0x12be
L_8c6348:
	bl.d L_8c82c0
L_8c634c:
	mov r3,0x1fd
L_8c6350:
	b_s L_8c630e
L_8c6352:
	nop_s
