/* conn_mgr__start_all_detector_services @ 0x8c40f8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_assoc_mgr__shallow_sleep_enter
 * Зовёт сам: __ld_r13_to_r13_ret, conn__start_detector_services, conn_mgr__by_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__start_all_detector_services
conn_mgr__start_all_detector_services:
	.global L_8c40f8
L_8c40f8:
	push_s blink
L_8c40fa:
	push_s r13
L_8c40fc:
	mov_s r13,0x0
L_8c40fe:
	b_s L_8c4118
	.global L_8c4100
L_8c4100:
	bl.d L_8cbffc
L_8c4104:
	mov_s r0,r13
L_8c4106:
	breq_s r0,0,L_8c4116
L_8c4108:
	ldb r1,[r0, 0xf0]
L_8c410c:
	cmp_s r1,0x2
L_8c410e:
	bl.eq.d L_8e2bfc
L_8c4112:
	mov.eq r1,0x1
	.global L_8c4116
L_8c4116:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c4118
L_8c4118:
	brlo r13,0x8,L_8c4100
L_8c411c:
	b L_8c025c
