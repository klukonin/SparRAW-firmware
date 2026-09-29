/* bi_manager__enter_dti @ 0x926858, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bi_manager.cpp
 * Зовут его: bi_manager__kind_switch, tail_bi_manager__enter_dti
 * Зовёт сам: bi_ap_mon_if__trigger, bi_dti__kick_worker, bi_manager_step_a, bi_manager_step_b, uc_sysassert
 * Глобалы (через gp): 0x8005d8
 */
	.section .text.bi_manager__enter_dti,"ax",@progbits
	.global bi_manager__enter_dti
bi_manager__enter_dti:
	.global L_926858
L_926858:
	st.a r13,[sp,-0xc]
L_92685c:
	st_s r14,[sp,0x8]
L_92685e:
	mov_s r14,r0
L_926860:
	ldw.as r0,[gp,0x58]
L_926864:
	cmp r0,0x300
L_926868:
	bne.d L_9268c8
L_92686c:
	st blink,[sp, 0x4]
	.global L_926870
L_926870:
	mov_s r1,0x801e69
L_926876:
	ldb_s r1,[r1]
L_926878:
	breq.d r1,0x0,L_926894
L_92687c:
	add r13,r14,0x8
L_926880:
	mov r0,0x2
L_926884:
	bl.d L_9304c8
L_926888:
	mov r1,0x0
L_92688c:
	bl.d L_931050
L_926890:
	mov r0,r13
	.global L_926894
L_926894:
	bl.d L_922a34
L_926898:
	mov r0,r14
L_92689c:
	bl.d L_922afc
L_9268a0:
	mov r0,r13
L_9268a4:
	ldw.as r3,[gp,0x58]
L_9268a8:
	cmp r3,0x300
L_9268ac:
	bne L_9268e0
	.global L_9268b0
L_9268b0:
	mov r0,0x3
L_9268b4:
	bl.d L_9304c8
L_9268b8:
	mov r1,0x0
L_9268bc:
	ld blink,[sp, 0x4]
L_9268c0:
	ld_s r14,[sp,0x8]
L_9268c2:
	j_s.d [blink]
L_9268c4:
	ld.ab r13,[sp,0xc]
	.global L_9268c8
L_9268c8:
	mov_s r0,blink
L_9268ca:
	mov_s r2,0x1002b80
L_9268d0:
	mov r1,0x59
L_9268d4:
	bl.d L_925548
L_9268d8:
	mov r3,0x30
L_9268dc:
	b L_926870
	.global L_9268e0
L_9268e0:
	mov_s r0,blink
L_9268e2:
	mov_s r2,0x1002b80
L_9268e8:
	mov r1,0x60
L_9268ec:
	bl.d L_925548
L_9268f0:
	mov r3,0x3e
L_9268f4:
	b_s L_9268b0
L_9268f6:
	nop_s
