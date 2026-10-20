/* ps_nonassoc__shallow_sleep_enter @ 0x8e15fc, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, ps_sm_801bec__on_ps_disable_in_ps_reenter, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_nonassoc__shallow_sleep_enter
ps_nonassoc__shallow_sleep_enter:
	.global L_8e15fc
L_8e15fc:
	push_s blink
L_8e15fe:
	push_s r13
L_8e1600:
	mov_s r13,r0
L_8e1602:
	ldb_s r0,[r0]
L_8e1604:
	brne r0,0x2,L_8e162a
L_8e1608:
	bl.d L_8e1308
L_8e160c:
	mov_s r0,r13
L_8e160e:
	mov_s r0,0x21544
L_8e1614:
	ld.as r4,[gp,-0x16]
L_8e1618:
	mov_s r1,r13
L_8e161a:
	mov_s r2,0x0
L_8e161c:
	mov_s r3,0x1
L_8e161e:
	mov_s r5,r2
L_8e1620:
	bl.d L_8e0c0c
L_8e1624:
	mov_s r6,r2
L_8e1626:
	st.as r0,[gp,-0x18]
	.global L_8e162a
L_8e162a:
	b L_8c025c
L_8e162e:
	nop_s
L_8e1630:
	ld_s r0,[gp,-0x64]
L_8e1632:
	ld_s r1,[r0,0x8]
L_8e1634:
	ld_s r1,[r1,0x20]
L_8e1636:
	j_s [r1]
L_8e1638:
	push_s blink
L_8e163a:
	ldb_s r1,[r0]
L_8e163c:
	cmp_s r1,0x3
L_8e163e:
	mov.eq r1,0x2
L_8e1642:
	mov.eq r2,r0
L_8e1646:
	mov.eq r3,0x0
L_8e164a:
	bl.eq.d L_8d9b6c
L_8e164e:
	mov.eq r4,r3
L_8e1652:
	pop_s blink
L_8e1654:
	j_s [blink]
L_8e1656:
	nop_s
L_8e1658:
	add_s r0,r0,0xc
L_8e165a:
	ld_s r1,[r0,0x8]
L_8e165c:
	ld_s r1,[r1,0x18]
L_8e165e:
	j_s [r1]
L_8e1660:
	push_s blink
L_8e1662:
	ldb_s r1,[r0]
L_8e1664:
	cmp_s r1,0x2
L_8e1666:
	mov.eq r1,0x2
L_8e166a:
	mov.eq r2,r0
L_8e166e:
	mov.eq r3,0x0
L_8e1672:
	bl.eq.d L_8d9b6c
L_8e1676:
	mov.eq r4,r3
L_8e167a:
	pop_s blink
L_8e167c:
	j_s [blink]
L_8e167e:
	nop_s
L_8e1680:
	add_s r0,r0,0xc
L_8e1682:
	ld_s r1,[r0,0x8]
L_8e1684:
	ld_s r1,[r1,0x18]
L_8e1686:
	j_s [r1]
