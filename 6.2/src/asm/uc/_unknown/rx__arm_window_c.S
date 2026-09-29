/* rx__arm_window_c @ 0x92c568, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SYSTEM
 * Зовут его: mac_mode_program_c
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x800578
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__arm_window_c
rx__arm_window_c:
	.global L_92c568
L_92c568:
	push_s r13
L_92c56a:
	mov_s r13,blink
L_92c56c:
	mov_s r0,0x0
L_92c56e:
	bset_s r0,r0,0x10
L_92c570:
	bl.d L_9366e8
L_92c574:
	mov r1,0x0
L_92c578:
	ldb r3,[gp, -0xf2]
L_92c57c:
	breq r3,0x0,L_92c5b4
	.global L_92c580
L_92c580:
	ld_s r0,[gp,0x50]
L_92c582:
	mov_s r2,0x8022c8
L_92c588:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92c58a:
	ld_s r1,[r2,0x3c]
L_92c58c:
	st.as r0,[gp,0x14]
L_92c590:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92c592:
	st_s r1,[r2,0x3c]
L_92c594:
	mov_s r3,0x2011000
L_92c59a:
	mov_s r32,r3
L_92c59c:
	st.ab r3,[r25,0x4]
L_92c5a0:
	bclr r25,r25,0xa
L_92c5a4:
	and r0,r37,0x1000000
L_92c5ac:
	mov_s blink,r13
L_92c5ae:
	j_s.d [blink]
L_92c5b0:
	ld.ab r13,[sp,0x4]
	.global L_92c5b4
L_92c5b4:
	ldb r1,[gp, -0xf9]
L_92c5b8:
	bmsk_s r1,r1,0x0
L_92c5ba:
	or r1,r1,0x32000000
L_92c5c2:
	mov_s r32,r1
L_92c5c4:
	st.ab r1,[r25,0x4]
L_92c5c8:
	bclr r25,r25,0xa
L_92c5cc:
	ldb r2,[gp, -0xf9]
L_92c5d0:
	add r2,r2,0x1
L_92c5d4:
	b.d L_92c580
L_92c5d8:
	stb r2,[gp, -0xf9]
