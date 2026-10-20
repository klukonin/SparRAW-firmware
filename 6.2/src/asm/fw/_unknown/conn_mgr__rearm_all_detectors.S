/* conn_mgr__rearm_all_detectors @ 0x8e00a4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__system_state_evt_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn__arm_detectors, conn__check_field_50, conn_mgr__by_cid, lm_if__inject_evt9
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__rearm_all_detectors
conn_mgr__rearm_all_detectors:
	.global L_8e00a4
L_8e00a4:
	push_s blink
L_8e00a6:
	bl L_8c01e4
L_8e00aa:
	mov_s r13,0x0
L_8e00ac:
	b_s L_8e00e0
	.global L_8e00ae
L_8e00ae:
	bl.d L_8cbffc
L_8e00b2:
	mov_s r0,r13
L_8e00b4:
	mov.f r14,r0
L_8e00b8:
	beq_s L_8e00de
L_8e00ba:
	ldb r0,[r14, 0xf0]
L_8e00be:
	brne r0,0x2,L_8e00de
L_8e00c2:
	bl.d L_8e011c
L_8e00c6:
	add3 r0,r14,0xe
L_8e00ca:
	bl.d L_8e007c
L_8e00ce:
	mov_s r0,r14
L_8e00d0:
	mov_s r0,0x854080
L_8e00d6:
	add3_s r0,r0,r13
L_8e00d8:
	bl.d L_8c68d4
L_8e00dc:
	ld_s r0,[r0,0x4]
	.global L_8e00de
L_8e00de:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8e00e0
L_8e00e0:
	brlo r13,0x8,L_8e00ae
L_8e00e4:
	b L_8c0254
