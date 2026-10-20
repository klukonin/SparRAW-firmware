/* mac_mode__wait_ppdu_and_kick_e @ 0x92964c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SYSTEM
 * Зовут его: mac_mode_program_c
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x80057c
 */
	.section .text.mac_mode__wait_ppdu_and_kick_e,"ax",@progbits
	.global mac_mode__wait_ppdu_and_kick_e
mac_mode__wait_ppdu_and_kick_e:
	.global L_92964c
L_92964c:
	push_s r13
L_92964e:
	mov_s r13,blink
L_929650:
	mov_s r0,0x0
L_929652:
	bset_s r0,r0,0x10
L_929654:
	bl.d L_931808
L_929658:
	mov r1,0x0
L_92965c:
	ldb r3,[gp, -0xf3]
L_929660:
	breq r3,0x0,L_929698
	.global L_929664
L_929664:
	ld_s r0,[gp,0x54]
L_929666:
	mov_s r2,0x801458
L_92966c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92966e:
	ld_s r1,[r2,0x38]
L_929670:
	st.as r0,[gp,0x15]
L_929674:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_929676:
	st_s r1,[r2,0x38]
L_929678:
	mov_s r3,0x2011000
L_92967e:
	mov_s r32,r3
L_929680:
	st.ab r3,[r25,0x4]
L_929684:
	bclr r25,r25,0xa
L_929688:
	and r0,r37,0x1000000
L_929690:
	mov_s blink,r13
L_929692:
	j_s.d [blink]
L_929694:
	ld.ab r13,[sp,0x4]
	.global L_929698
L_929698:
	ldb r1,[gp, -0xf9]
L_92969c:
	bmsk_s r1,r1,0x0
L_92969e:
	or r1,r1,0x32000000
L_9296a6:
	mov_s r32,r1
L_9296a8:
	st.ab r1,[r25,0x4]
L_9296ac:
	bclr r25,r25,0xa
L_9296b0:
	ldb r2,[gp, -0xf9]
L_9296b4:
	add r2,r2,0x1
L_9296b8:
	b.d L_929664
L_9296bc:
	stb r2,[gp, -0xf9]
