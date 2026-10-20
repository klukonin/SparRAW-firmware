/* fw_vector_06 @ 0x8c1194, 292 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Awake TSF interrupt expired! TSF: 0x%08x:%08x
 *   LMAC CRASH detected !!!
 *   UCODE :: SYSASSERT_CODE_0x%x curr_blink=0x%X
 *   UCODE :: SYSTEM FATAL CRASH1: sp=0x%08X, ilink1=0x%X, ilink2=0x%X
 * Зовёт сам: POWER_MNGR__deep_sleep_exit, fw_log_emit0, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, mac_icr__mask_awake_tsf, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_vector_06
fw_vector_06:
	.global L_8c1194
L_8c1194:
	push_s r12
L_8c1196:
	st.a mhi,[sp,-0x4]
L_8c119a:
	st.a mlo,[sp,-0x4]
L_8c119e:
	push_s r0
L_8c11a0:
	push_s r1
L_8c11a2:
	push_s r2
L_8c11a4:
	push_s r3
L_8c11a6:
	st.a r4,[sp,-0x4]
L_8c11aa:
	st.a r5,[sp,-0x4]
L_8c11ae:
	st.a r6,[sp,-0x4]
L_8c11b2:
	st.a r7,[sp,-0x4]
L_8c11b6:
	st.a r8,[sp,-0x4]
L_8c11ba:
	st.a r9,[sp,-0x4]
L_8c11be:
	st.a r10,[sp,-0x4]
L_8c11c2:
	st.a r11,[sp,-0x4]
L_8c11c6:
	push_s r13
L_8c11c8:
	st.a lp_count,[sp,-0x4]
L_8c11cc:
	lr r12,[0x2]
L_8c11d0:
	push_s r12
L_8c11d2:
	lr r12,[0x3]
L_8c11d6:
	push_s r12
L_8c11d8:
	push_s blink
L_8c11da:
	sub_s sp,sp,0x8
L_8c11dc:
	bl.d L_8c8a34
L_8c11e0:
	mov_s r0,0x4
L_8c11e2:
	mov_s r13,0x886e00
L_8c11e8:
	ld_s r0,[r13,0x44]
L_8c11ea:
	st_s r0,[r13,0x40]
L_8c11ec:
	bbit0 r0,0xf,L_8c1210
L_8c11f0:
	bl L_8e9a90
L_8c11f4:
	mov_s r1,sp
L_8c11f6:
	mov_s r0,0x0
L_8c11f8:
	bl.d L_8e9900
L_8c11fc:
	mov_s r2,r0
L_8c11fe:
	ld_s r2,[sp,0x4]
L_8c1200:
	mov_s r1,0x1000528
L_8c1206:
	mov_s r0,0x20
L_8c1208:
	bl.d L_8dcc80
L_8c120c:
	ld_s r3,[sp,0x0]
L_8c120e:
	b_s L_8c1262
	.global L_8c1210
L_8c1210:
	mov_s r1,0x1000558
L_8c1216:
	bl.d L_8dcba8
L_8c121a:
	mov_s r0,0x0
L_8c121c:
	mov_s r0,0x40
L_8c121e:
	st_s r0,[r13,0x50]
L_8c1220:
	mov_s r3,0x857000
L_8c1226:
	ld_s r2,[r3,0x14]
L_8c1228:
	mov_s r1,0x1000570
L_8c122e:
	mov_s r0,0x0
L_8c1230:
	bl.d L_8dcc80
L_8c1234:
	ld_s r3,[r3,0x18]
L_8c1236:
	mov_s r0,0x886f00
L_8c123c:
	ld_s r2,[r0,0x4c]
L_8c123e:
	mov_s r1,0x10005a0
L_8c1244:
	ld_s r3,[r0,0x50]
L_8c1246:
	ld r4,[r0, 0x54]
L_8c124a:
	bl.d L_8dcd00
L_8c124e:
	mov_s r0,0x0
L_8c1250:
	mov_s r0,0x1
L_8c1252:
	st.as r0,[gp,-0x4d]
L_8c1256:
	mov_s r0,blink
L_8c1258:
	mov_s r1,0x11ac
L_8c125e:
	bl L_8c9b28
	.global L_8c1262
L_8c1262:
	add_s sp,sp,0x8
L_8c1264:
	pop_s blink
L_8c1266:
	pop_s r12
L_8c1268:
	sr r12,[0x3]
L_8c126c:
	pop_s r12
L_8c126e:
	sr r12,[0x2]
L_8c1272:
	pop_s r12
L_8c1274:
	mov_s lp_count,r12
L_8c1276:
	pop_s r13
L_8c1278:
	ld.ab r11,[sp,0x4]
L_8c127c:
	ld.ab r10,[sp,0x4]
L_8c1280:
	ld.ab r9,[sp,0x4]
L_8c1284:
	ld.ab r8,[sp,0x4]
L_8c1288:
	ld.ab r7,[sp,0x4]
L_8c128c:
	ld.ab r6,[sp,0x4]
L_8c1290:
	ld.ab r5,[sp,0x4]
L_8c1294:
	ld.ab r4,[sp,0x4]
L_8c1298:
	pop_s r3
L_8c129a:
	pop_s r2
L_8c129c:
	pop_s r1
L_8c129e:
	pop_s r0
L_8c12a0:
	pop_s r12
L_8c12a2:
	mulu64 r12,0x1
L_8c12a6:
	mov 0x0,mlo
L_8c12aa:
	pop_s r12
L_8c12ac:
	sr r12,[0x12]
L_8c12b0:
	pop_s r12
L_8c12b2:
	j.f [ilink1]
L_8c12b6:
	nop_s
