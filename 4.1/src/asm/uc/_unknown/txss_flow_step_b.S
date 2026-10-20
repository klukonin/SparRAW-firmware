/* txss_flow_step_b @ 0x93657c, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_substate__txss_step_by_slot
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_sm__release_sta, bf_substate__set, rate_search__apply_mcs, rx_funcs_step, txss__init_sweep_b, txss_copy_step, txss_func__reorder_sectors, txss_rx_step
 * Глобалы (через gp): 0x8005d8, 0x800604, 0x800608
 */
	.section .text.txss_flow_step_b,"ax",@progbits
	.global txss_flow_step_b
txss_flow_step_b:
	.global L_93657c
L_93657c:
	push_s blink
L_93657e:
	bl L_920214
L_936582:
	mov_s r13,r0
L_936584:
	mov_s r14,0x1
L_936586:
	mov_s r0,r14
L_936588:
	bl.d L_92c330
L_93658c:
	mov_s r1,r13
L_93658e:
	st.as r14,[gp,-0x7]
L_936592:
	mov_s r0,0x40
L_936594:
	st.as r0,[gp,0x37]
L_936598:
	brne r13,0x8,L_9365b4
L_93659c:
	mov_s r2,0x80100c
L_9365a2:
	ldw_s r0,[r2,0x1c]
L_9365a4:
	mov_s r1,0x8013d0
L_9365aa:
	stw_s r0,[r1,0x2c]
L_9365ac:
	ldw_s r0,[r2,0x1e]
L_9365ae:
	stw_s r0,[r1,0x2e]
L_9365b0:
	ldw_s r0,[r2,0x20]
L_9365b2:
	stw_s r0,[r1,0x30]
	.global L_9365b4
L_9365b4:
	st.as 0x200000,[gp,0x38]
L_9365bc:
	bl.d L_93648c
L_9365c0:
	mov_s r0,r13
L_9365c2:
	cmp_s r0,0x1
L_9365c4:
	mov_s r0,r13
L_9365c6:
	bne_s L_9365f2
L_9365c8:
	bl L_9363dc
L_9365cc:
	brne r0,0x1,L_9365e0
L_9365d0:
	mov_s r0,r13
L_9365d2:
	bl.d L_92fc0c
L_9365d6:
	mov_s r1,0x0
L_9365d8:
	mov_s r0,r13
L_9365da:
	bl.d L_930dc4
L_9365de:
	mov_s r1,0x9
	.global L_9365e0
L_9365e0:
	ld_s r0,[gp,-0x78]
L_9365e2:
	cmp_s r0,0x1
L_9365e4:
	bl.eq L_930f44
L_9365e8:
	mov_s r0,r13
L_9365ea:
	bl.d L_937818
L_9365ee:
	mov_s r1,0x0
L_9365f0:
	b_s L_9365f8
	.global L_9365f2
L_9365f2:
	bl.d L_930dc4
L_9365f6:
	mov_s r1,0xb
	.global L_9365f8
L_9365f8:
	bl.d L_9224c4
L_9365fc:
	mov_s r0,r13
L_9365fe:
	ld_s r0,[gp,-0x1c]
L_936600:
	breq_s r0,0,L_936654
L_936602:
	mov_s r1,0x801a08
L_936608:
	ldw_s r0,[gp,0xb0]
L_93660a:
	ldw_s r1,[r1]
L_93660c:
	breq r0,r1,L_936638
L_936610:
	stw.as r1,[gp,0x58]
L_936614:
	or r1,r1,0x1730000
L_93661c:
	mov_s r0,0x886d00
L_936622:
	st_s r1,[r0]
L_936624:
	sync
L_936628:
	mov_s r0,0x38000200
L_93662e:
	mov_s r32,r0
L_936630:
	st.ab r0,[r25,0x4]
L_936634:
	bclr r25,r25,0xa
	.global L_936638
L_936638:
	nop_s
L_93663a:
	nop_s
L_93663c:
	nop_s
L_93663e:
	mov_s r0,0x1f000601
L_936644:
	mov_s r32,r0
L_936646:
	st.ab r0,[r25,0x4]
L_93664a:
	bclr r25,r25,0xa
L_93664e:
	mov_s r0,0x0
L_936650:
	st.as r0,[gp,-0x7]
	.global L_936654
L_936654:
	b L_920284
