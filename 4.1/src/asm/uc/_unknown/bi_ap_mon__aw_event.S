/* bi_ap_mon__aw_event @ 0x931078, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BI_AP_MONITOR_SM: AW EVENT
 * Зовёт сам: bi_manager__on_aw
 */
	.section .text.bi_ap_mon__aw_event,"ax",@progbits
	.global bi_ap_mon__aw_event
bi_ap_mon__aw_event:
L_931078:
	st.a r13,[sp,-0xc]
L_93107c:
	st blink,[sp, 0x4]
L_931080:
	st_s r14,[sp,0x8]
L_931082:
	mov r6,0x80209c
L_93108a:
	ldb r4,[r6, 0x4]
L_93108e:
	mov_s r3,0x1002a38
L_931094:
	mov r13,r0
L_931098:
	bbit0.d r4,0x2,L_9310c4
L_93109c:
	mov_s r14,0x0
L_93109e:
	bmsk_s r3,r3,0x13
L_9310a0:
	ld r4,[r6]
L_9310a4:
	or r3,r3,0xa2000000
L_9310ac:
	extb r5,r4
L_9310b0:
	mov_s r0,0x8020b0
L_9310b6:
	add2 r0,r0,r5
L_9310ba:
	st_s r3,[r0]
L_9310bc:
	add r4,r4,0x1
L_9310c0:
	st r4,[r6]
	.global L_9310c4
L_9310c4:
	ldb_s r2,[r13]
L_9310c6:
	bmsk_s r2,r2,0x3
L_9310c8:
	or r2,r2,0xcaf220
L_9310d0:
	mov r32,r2
L_9310d4:
	st.ab r2,[r25,0x4]
L_9310d8:
	bclr r25,r25,0xa
L_9310dc:
	ldb r6,[r13]
L_9310e0:
	mov r5,0x801e14
L_9310e8:
	ldw r1,[r5, 0xa]
L_9310ec:
	stb r6,[r5, 0x12]
L_9310f0:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9310f2:
	stw r1,[r5, 0xa]
L_9310f6:
	mov_s r0,0x801e94
L_9310fc:
	bl.d L_9289a0
L_931100:
	st.as r14,[gp,-0x35]
L_931104:
	ld blink,[sp, 0x4]
L_931108:
	ld_s r14,[sp,0x8]
L_93110a:
	j_s.d [blink]
L_93110c:
	ld.ab r13,[sp,0xc]
