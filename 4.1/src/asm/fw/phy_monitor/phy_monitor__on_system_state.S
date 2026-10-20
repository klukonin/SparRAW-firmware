/* phy_monitor__on_system_state @ 0x8e3880, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   phy_monitor.cpp
 * Зовут его: L2MGR__system_state_evt_handler
 * Зовёт сам: __ld_r13_ret, detector__arm_timer, fw_sysassert_fatal, periodic_service__start
 */
	.section .text.phy_monitor__on_system_state,"ax",@progbits
	.global phy_monitor__on_system_state
phy_monitor__on_system_state:
	.global L_8e3880
L_8e3880:
	push_s blink
L_8e3882:
	push_s r13
L_8e3884:
	brhs.d r1,0x17,L_8e38e4
L_8e3888:
	mov_s r13,r0
L_8e388a:
	ldb.x r1,[0x802cf8,r1]
L_8e3892:
	add r0,pcl,0xa
L_8e3896:
	add1_s r0,r0,r1
L_8e3898:
	j_s [r0]
L_8e389a:
	breq_s r3,0,L_8e38c0
L_8e389c:
	mov_s r0,blink
L_8e389e:
	mov_s r2,0x101626c
L_8e38a4:
	mov_s r1,0x1437
L_8e38aa:
	bl.d L_8c82c0
L_8e38ae:
	mov_s r3,0x3d
L_8e38b0:
	b_s L_8e38c0
L_8e38b2:
	cmp_s r3,0x0
L_8e38b4:
	cmp.eq r2,0x1
L_8e38b8:
	bne_s L_8e38c0
L_8e38ba:
	mov_s r0,0x0
L_8e38bc:
	st_s r0,[r13,0x30]
L_8e38be:
	b_s L_8e38dc
	.global L_8e38c0
L_8e38c0:
	mov_s r0,0x1
L_8e38c2:
	st_s r0,[r13,0x30]
L_8e38c4:
	mov_s r0,r13
L_8e38c6:
	bl.d L_8e2570
L_8e38ca:
	mov_s r1,0x0
L_8e38cc:
	b_s L_8e38f8
L_8e38ce:
	ld_s r0,[r13,0x30]
L_8e38d0:
	breq_s r0,0,L_8e38dc
L_8e38d2:
	mov_s r0,r13
L_8e38d4:
	bl.d L_8e2570
L_8e38d8:
	mov_s r1,0x2
L_8e38da:
	b_s L_8e38f8
	.global L_8e38dc
L_8e38dc:
	bl.d L_8e2d84
L_8e38e0:
	mov_s r0,r13
L_8e38e2:
	b_s L_8e38f8
	.global L_8e38e4
L_8e38e4:
	mov_s r0,blink
L_8e38e6:
	mov_s r2,0x101626c
L_8e38ec:
	mov_s r1,0x1435
L_8e38f2:
	bl.d L_8c82c0
L_8e38f6:
	mov_s r3,0x6a
	.global L_8e38f8
L_8e38f8:
	b L_8c033c
