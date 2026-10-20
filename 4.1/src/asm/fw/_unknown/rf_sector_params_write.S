/* rf_sector_params_write @ 0x8d1174, 332 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_set_rf_sector_params__set_rf_sector_params
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, rf_sector_commit_rx, rf_sector_commit_tx, rfc_field_write
 */
	.section .text.rf_sector_params_write,"ax",@progbits
	.global rf_sector_params_write
rf_sector_params_write:
	.global L_8d1174
L_8d1174:
	push_s blink
L_8d1176:
	bl.d L_8c02ac
L_8d117a:
	mov_s r8,r3
L_8d117c:
	mov_s r19,r0
L_8d117e:
	mov_s r14,r1
L_8d1180:
	mov r18,r4
L_8d1184:
	mov r20,r5
L_8d1188:
	mov r16,r6
L_8d118c:
	mov r17,r7
L_8d1190:
	ld_s r15,[sp,0x24]
L_8d1192:
	asl_s r13,r1,0x6
L_8d1194:
	add1_s r13,r13,r13
L_8d1196:
	breq r2,0x0,L_8d122c
L_8d119a:
	add r0,r13,0x8000
L_8d11a2:
	lsr_s r0,r0,0x3
L_8d11a4:
	bic r1,r0,0x3
L_8d11a8:
	mov_s r0,r19
L_8d11aa:
	bl.d L_8d113c
L_8d11ae:
	mov_s r2,r8
L_8d11b0:
	add r0,r13,0x8020
L_8d11b8:
	lsr_s r0,r0,0x3
L_8d11ba:
	bic r1,r0,0x3
L_8d11be:
	mov_s r0,r19
L_8d11c0:
	bl.d L_8d113c
L_8d11c4:
	mov_s r2,r18
L_8d11c6:
	add r0,r13,0x8060
L_8d11ce:
	lsr_s r0,r0,0x3
L_8d11d0:
	bic r1,r0,0x3
L_8d11d4:
	mov_s r0,r19
L_8d11d6:
	bl.d L_8d113c
L_8d11da:
	mov_s r2,r20
L_8d11dc:
	add r0,r13,0x8040
L_8d11e4:
	lsr_s r0,r0,0x3
L_8d11e6:
	bic r1,r0,0x3
L_8d11ea:
	mov_s r0,r19
L_8d11ec:
	bl.d L_8d113c
L_8d11f0:
	mov_s r2,r16
L_8d11f2:
	add r0,r13,0x80a0
L_8d11fa:
	lsr_s r0,r0,0x3
L_8d11fc:
	bic r1,r0,0x3
L_8d1200:
	mov_s r0,r19
L_8d1202:
	bl.d L_8d113c
L_8d1206:
	mov_s r2,r17
L_8d1208:
	add_s r13,r13,0x8080
L_8d120e:
	lsr_s r13,r13,0x3
L_8d1210:
	bic r1,r13,0x3
L_8d1214:
	mov_s r0,r19
L_8d1216:
	bl.d L_8d113c
L_8d121a:
	mov_s r2,r15
L_8d121c:
	ld_s r0,[sp,0x28]
L_8d121e:
	breq r0,0x0,L_8d12ba
L_8d1222:
	extb_s r1,r14
L_8d1224:
	bl.d L_8d0ef4
L_8d1228:
	mov_s r0,r19
L_8d122a:
	b_s L_8d12ba
	.global L_8d122c
L_8d122c:
	add r0,r13,0x10000
L_8d1234:
	lsr_s r0,r0,0x3
L_8d1236:
	bic r1,r0,0x3
L_8d123a:
	mov_s r0,r19
L_8d123c:
	bl.d L_8d113c
L_8d1240:
	mov_s r2,r8
L_8d1242:
	add r0,r13,0x10020
L_8d124a:
	lsr_s r0,r0,0x3
L_8d124c:
	bic r1,r0,0x3
L_8d1250:
	mov_s r0,r19
L_8d1252:
	bl.d L_8d113c
L_8d1256:
	mov_s r2,r18
L_8d1258:
	add r0,r13,0x10060
L_8d1260:
	lsr_s r0,r0,0x3
L_8d1262:
	bic r1,r0,0x3
L_8d1266:
	mov_s r0,r19
L_8d1268:
	bl.d L_8d113c
L_8d126c:
	mov_s r2,r20
L_8d126e:
	add r0,r13,0x10040
L_8d1276:
	lsr_s r0,r0,0x3
L_8d1278:
	bic r1,r0,0x3
L_8d127c:
	mov_s r0,r19
L_8d127e:
	bl.d L_8d113c
L_8d1282:
	mov_s r2,r16
L_8d1284:
	add r0,r13,0x100a0
L_8d128c:
	lsr_s r0,r0,0x3
L_8d128e:
	bic r1,r0,0x3
L_8d1292:
	mov_s r0,r19
L_8d1294:
	bl.d L_8d113c
L_8d1298:
	mov_s r2,r17
L_8d129a:
	add_s r13,r13,0x10080
L_8d12a0:
	lsr_s r13,r13,0x3
L_8d12a2:
	bic r1,r13,0x3
L_8d12a6:
	mov_s r0,r19
L_8d12a8:
	bl.d L_8d113c
L_8d12ac:
	mov_s r2,r15
L_8d12ae:
	ld_s r0,[sp,0x28]
L_8d12b0:
	breq_s r0,0,L_8d12ba
L_8d12b2:
	extb_s r1,r14
L_8d12b4:
	bl.d L_8d073c
L_8d12b8:
	mov_s r0,r19
	.global L_8d12ba
L_8d12ba:
	b L_8c0304
L_8d12be:
	nop_s
