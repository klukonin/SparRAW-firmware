/* bi_ap_mon__dti_event @ 0x931270, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BI_AP_MONITOR_SM: DTI EVENT
 * Зовёт сам: bi_manager__on_dti
 */
	.section .text.bi_ap_mon__dti_event,"ax",@progbits
	.global bi_ap_mon__dti_event
bi_ap_mon__dti_event:
L_931270:
	st.a r13,[sp,-0xc]
L_931274:
	st blink,[sp, 0x4]
L_931278:
	st_s r14,[sp,0x8]
L_93127a:
	mov r6,0x80209c
L_931282:
	ldb r4,[r6, 0x4]
L_931286:
	mov_s r3,0x1002a1c
L_93128c:
	mov r13,r0
L_931290:
	bbit0.d r4,0x2,L_9312bc
L_931294:
	mov_s r14,0x1
L_931296:
	bmsk_s r3,r3,0x13
L_931298:
	ld r4,[r6]
L_93129c:
	or r3,r3,0xa2000000
L_9312a4:
	extb r5,r4
L_9312a8:
	mov_s r0,0x8020b0
L_9312ae:
	add2 r0,r0,r5
L_9312b2:
	st_s r3,[r0]
L_9312b4:
	add r4,r4,0x1
L_9312b8:
	st r4,[r6]
	.global L_9312bc
L_9312bc:
	ldb_s r2,[r13]
L_9312be:
	bmsk_s r2,r2,0x3
L_9312c0:
	or r2,r2,0xcaf110
L_9312c8:
	mov r32,r2
L_9312cc:
	st.ab r2,[r25,0x4]
L_9312d0:
	bclr r25,r25,0xa
L_9312d4:
	ldb r6,[r13]
L_9312d8:
	mov r5,0x801e14
L_9312e0:
	ldw r1,[r5, 0x8]
L_9312e4:
	stb r6,[r5, 0x12]
L_9312e8:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9312ea:
	stw r1,[r5, 0x8]
L_9312ee:
	mov_s r0,0x801e94
L_9312f4:
	bl.d L_928a58
L_9312f8:
	st.as r14,[gp,-0xb]
L_9312fc:
	ld blink,[sp, 0x4]
L_931300:
	ld_s r14,[sp,0x8]
L_931302:
	j_s.d [blink]
L_931304:
	ld.ab r13,[sp,0xc]
