/* l2mgr__init @ 0x8ed398, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [L2MGR] OOB mode
 *   layer2_mgr.cpp
 * Зовут его: l2mgr__on_lmac_ready
 * Зовёт сам: L2MGR__system_state_evt_handler, __ld_r14_to_r13_ret, __st_r14_to_r13, detectors_init_sweep, fw_log__emit0, fw_sysassert_fatal, l2mgr__init_oob_detector, l2mgr__init_oob_pool, l2mgr__init_radio_mgr, l2mgr__mac_bringup, l2mgr__mac_started_log, l2mgr__reset_oob_rings
 */
	.section .text.l2mgr__init,"ax",@progbits
	.global l2mgr__init
l2mgr__init:
	.global L_8ed398
L_8ed398:
	push_s blink
L_8ed39a:
	bl.d L_8c02c4
L_8ed39e:
	mov_s r0,0x0
L_8ed3a0:
	bl.d L_8d7238
L_8ed3a4:
	st.as r0,[gp,-0x31]
L_8ed3a8:
	mov_s r14,0x8033dc
L_8ed3ae:
	st r0,[r14, 0x8c]
L_8ed3b2:
	breq_s r0,0,L_8ed3c6
L_8ed3b4:
	mov_s r2,0x100e22c
L_8ed3ba:
	mov_s r0,0xb
L_8ed3bc:
	bl.d L_8edfb0
L_8ed3c0:
	mov_s r1,0x2
L_8ed3c2:
	bl L_8c7984
	.global L_8ed3c6
L_8ed3c6:
	bl L_8d61a4
L_8ed3ca:
	bl L_8d64a0
L_8ed3ce:
	bl L_8ed4a0
L_8ed3d2:
	bl L_8d5a58
L_8ed3d6:
	mov_s r0,0x84edf4
L_8ed3dc:
	bl L_8d5aac
L_8ed3e0:
	mov_s r13,0x80047c
L_8ed3e6:
	mov_s r0,0x0
L_8ed3e8:
	mov_s r1,r13
L_8ed3ea:
	add_s r2,r14,0x4
L_8ed3ec:
	bl.d L_8f141c
L_8ed3f0:
	ldw_s r3,[r14,0x26]
L_8ed3f2:
	breq_s r0,0,L_8ed41c
	.global L_8ed3f4
L_8ed3f4:
	bl L_8ee6cc
L_8ed3f8:
	bl L_8ed308
L_8ed3fc:
	bl L_8d626c
L_8ed400:
	bl L_8df490
L_8ed404:
	bl L_8f2b38
L_8ed408:
	mov_s r0,r13
L_8ed40a:
	bl.d L_8ed87c
L_8ed40e:
	mov_s r1,0xff
L_8ed410:
	mov_s r0,0x0
L_8ed412:
	bl.d L_8e3a08
L_8ed416:
	mov_s r1,r0
L_8ed418:
	b L_8c0334
	.global L_8ed41c
L_8ed41c:
	mov_s r0,blink
L_8ed41e:
	mov_s r2,0x100c474
L_8ed424:
	mov_s r1,0x11d8
L_8ed42a:
	bl.d L_8c82c0
L_8ed42e:
	mov_s r3,0x6e
L_8ed430:
	b_s L_8ed3f4
L_8ed432:
	nop_s
