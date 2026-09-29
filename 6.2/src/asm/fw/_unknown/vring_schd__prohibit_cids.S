/* vring_schd__prohibit_cids @ 0x8e1218, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   vring_schd::prohibit_cids: V-ring #%d being stop.
 * Зовут его: radio_mgr__enqueue_request
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, basic_sm__handle_event, fw_log_emit1, vring_schd__stop_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__prohibit_cids
vring_schd__prohibit_cids:
	.global L_8e1218
L_8e1218:
	add_s r0,r0,0x28
L_8e121a:
	mov_s r1,0x3
L_8e121c:
	mov_s r2,0x0
L_8e121e:
	mov_s r3,r2
L_8e1220:
	b.d L_8d9b6c
L_8e1224:
	mov_s r4,r2
L_8e1226:
	nop_s
L_8e1228:
	push_s blink
L_8e122a:
	bl.d L_8c01d4
L_8e122e:
	bclr_s r1,r1,0x8
L_8e1230:
	mov_s r15,0x804e3c
L_8e1236:
	ld_s r0,[r15,0x24]
L_8e1238:
	mov r17,0x804dbc
L_8e1240:
	or_s r0,r0,r1
L_8e1242:
	st_s r0,[r15,0x24]
L_8e1244:
	ld_s r0,[r15,0x20]
L_8e1246:
	brlo.d r0,0x1,L_8e1290
L_8e124a:
	mov_s r1,0x0
L_8e124c:
	mov_s r13,r1
	.global L_8e124e
L_8e124e:
	mul64 r13,0x3c
L_8e1252:
	add r0,r17,0x28
L_8e1256:
	add r16,r0,mlo
L_8e125a:
	ld r14,[r16, 0x14]
L_8e125e:
	breq_s r14,0,L_8e1288
L_8e1260:
	ldb_s r2,[r14,0xa]
L_8e1262:
	ld_s r0,[r15,0x24]
L_8e1264:
	mov r18,0x1
L_8e1268:
	bbit0 r0,r2,L_8e1288
L_8e126c:
	mov_s r1,0x100bb94
L_8e1272:
	mov_s r0,0x27
L_8e1274:
	bl.d L_8dcc10
L_8e1278:
	ldb_s r2,[r14,0x9]
L_8e127a:
	mov_s r0,0x4
L_8e127c:
	st_s r0,[r14,0x24]
L_8e127e:
	mov_s r0,r17
L_8e1280:
	bl.d L_8e80cc
L_8e1284:
	mov_s r1,r16
L_8e1286:
	mov_s r1,r18
	.global L_8e1288
L_8e1288:
	ld_s r0,[r15,0x20]
L_8e128a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e128c:
	brlo r13,r0,L_8e124e
	.global L_8e1290
L_8e1290:
	b.d L_8c0234
L_8e1294:
	mov_s r0,r1
L_8e1296:
	nop_s
