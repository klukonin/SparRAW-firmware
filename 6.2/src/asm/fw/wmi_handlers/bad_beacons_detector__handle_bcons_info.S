/* bad_beacons_detector__handle_bcons_info @ 0x8cd1e8, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bad_beacons_detector::handle_bcons_info(): Link-Loss detected for cid=%d. Initating disconnect flow.
 * Зовут его: bad_beacons__on_bi_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bad_beacons__check_counter, bad_beacons_detector__is_enabled, conn__disconnect, conn_mgr__by_cid, fw_log_emit1
 * Глобалы (через gp): 0x800231
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bad_beacons_detector__handle_bcons_info
bad_beacons_detector__handle_bcons_info:
	.global L_8cd1e8
L_8cd1e8:
	push_s blink
L_8cd1ea:
	bl L_8c01e0
L_8cd1ee:
	bl.d L_8da1cc
L_8cd1f2:
	mov_s r13,r0
L_8cd1f4:
	breq r0,0x0,L_8cd282
L_8cd1f8:
	ld_s r0,[r13,0x8]
L_8cd1fa:
	breq r0,0x0,L_8cd282
L_8cd1fe:
	mov_s r14,0x853940
L_8cd204:
	ldb r15,[r14, 0x2a]
L_8cd208:
	mov_s r1,0x0
L_8cd20a:
	ldb_s r3,[r13]
L_8cd20c:
	ld_s r0,[r13,0x4]
L_8cd20e:
	add r2,r0,0x20
L_8cd212:
	breq_s r15,0,L_8cd228
L_8cd214:
	ldb r15,[r14, 0x20]
L_8cd218:
	breq_s r15,0,L_8cd226
L_8cd21a:
	asl_s r15,r3,0x2
L_8cd21c:
	add3_s r15,r15,r15
L_8cd21e:
	ld_s r15,[r2,r15]
L_8cd220:
	ld_s r2,[r14,0x24]
L_8cd222:
	brge r15,r2,L_8cd228
	.global L_8cd226
L_8cd226:
	mov_s r1,0x1
	.global L_8cd228
L_8cd228:
	add r0,r0,0x1c0
L_8cd22c:
	add1 r2,r0,r3
L_8cd230:
	mov_s r0,0x0
L_8cd232:
	brne_s r1,0,L_8cd23a
L_8cd234:
	ldw_s r0,[r2,0x2c]
L_8cd236:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cd238:
	extw_s r0,r0
	.global L_8cd23a
L_8cd23a:
	stw_s r0,[r2,0x2c]
L_8cd23c:
	ld_s r1,[r13,0x4]
L_8cd23e:
	ldb_s r2,[r13]
L_8cd240:
	mov_s r0,r1
L_8cd242:
	add r0,r0,0x1ec
L_8cd246:
	ldw.as r3,[r0,r2]
L_8cd24a:
	asl_s r0,r2,0x2
L_8cd24c:
	add3_s r0,r0,r0
L_8cd24e:
	add_s r1,r1,0x1c
L_8cd250:
	ld_s r1,[r1,r0]
L_8cd252:
	ldb_s r0,[gp,0xad]
L_8cd254:
	mulu64 r0,r1
L_8cd258:
	mov_s r0,0x1
L_8cd25a:
	cmp_s r3,mlo
L_8cd25c:
	sub.ls r0,r0,r0
L_8cd260:
	breq_s r0,0,L_8cd282
L_8cd262:
	mov_s r1,0x1014dd4
L_8cd268:
	bl.d L_8dcc10
L_8cd26c:
	mov_s r0,0x1b
L_8cd26e:
	bl.d L_8cbffc
L_8cd272:
	ldb_s r0,[r13]
L_8cd274:
	mov_s r1,0x1
L_8cd276:
	bl.d L_8f2540
L_8cd27a:
	mov_s r2,r1
L_8cd27c:
	bl.d L_8c67bc
L_8cd280:
	mov_s r0,r13
	.global L_8cd282
L_8cd282:
	b L_8c024c
L_8cd286:
	nop_s
