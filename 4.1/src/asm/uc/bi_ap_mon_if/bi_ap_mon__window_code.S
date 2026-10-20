/* bi_ap_mon__window_code @ 0x926490, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bi_ap_mon_if.cpp
 * Зовут его: background_bi_step, bi_manager__on_aw, bi_manager__on_dti, nav_db__update, rx_nav_bi_step, umac_if_cmd_handler
 * Зовёт сам: uc_sysassert
 */
	.section .text.bi_ap_mon__window_code,"ax",@progbits
	.global bi_ap_mon__window_code
bi_ap_mon__window_code:
	.global L_926490
L_926490:
	st.a r13,[sp,-0x8]
L_926494:
	st_s r14,[sp,0x4]
L_926496:
	ldb r0,[0x801de8]
L_92649e:
	mov_s r14,blink
L_9264a0:
	breq.d r0,0x0,L_9264e4
L_9264a4:
	mov_s r13,0x0
L_9264a6:
	breq r0,0x2,L_9264cc
L_9264aa:
	breq r0,0x3,L_9264d8
L_9264ae:
	mov_s r0,blink
L_9264b0:
	mov_s r2,0x1002770
L_9264b6:
	mov_s r1,0x5f
L_9264b8:
	bl.d L_925548
L_9264bc:
	mov r3,0x30
L_9264c0:
	mov_s r0,r13
L_9264c2:
	mov_s blink,r14
L_9264c4:
	ld_s r14,[sp,0x4]
L_9264c6:
	j_s.d [blink]
L_9264c8:
	ld.ab r13,[sp,0x8]
	.global L_9264cc
L_9264cc:
	mov_s r0,0x1
L_9264ce:
	mov_s blink,r14
L_9264d0:
	ld_s r14,[sp,0x4]
L_9264d2:
	j_s.d [blink]
L_9264d4:
	ld.ab r13,[sp,0x8]
	.global L_9264d8
L_9264d8:
	mov_s r0,0x2
L_9264da:
	mov_s blink,r14
L_9264dc:
	ld_s r14,[sp,0x4]
L_9264de:
	j_s.d [blink]
L_9264e0:
	ld.ab r13,[sp,0x8]
	.global L_9264e4
L_9264e4:
	mov_s r0,r13
L_9264e6:
	mov_s blink,r14
L_9264e8:
	ld_s r14,[sp,0x4]
L_9264ea:
	j_s.d [blink]
L_9264ec:
	ld.ab r13,[sp,0x8]
