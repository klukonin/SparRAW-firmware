/* ba_sm__send_delba @ 0x8e530c, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wait_sm__action_8e7cd4
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r17_to_r13_ret, __st_r17_to_r13, frame__build_delba, fw_sysassert_fatal, mgmt_tx__begin_frame, mid_list__by_obj_mid, tx_api__send_mgmt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__send_delba
ba_sm__send_delba:
	.global L_8e530c
L_8e530c:
	push_s blink
L_8e530e:
	bl L_8c01d8
L_8e5312:
	sub_s sp,sp,0x4
L_8e5314:
	mov_s r14,r0
L_8e5316:
	bl.d L_8c3414
L_8e531a:
	mov_s r17,r1
L_8e531c:
	mov_s r13,r0
L_8e531e:
	bl.d L_8cc41c
L_8e5322:
	ld_s r0,[r14,0x40]
L_8e5324:
	mov.f r15,r0
L_8e5328:
	beq_s L_8e537c
	.global L_8e532a
L_8e532a:
	mov_s r0,0x0
L_8e532c:
	mov_s r16,r0
L_8e532e:
	st_s r0,[sp,0x0]
L_8e5330:
	ld_s r3,[r14,0x40]
L_8e5332:
	mov_s r1,sp
L_8e5334:
	ld_s r3,[r3]
L_8e5336:
	mov_s r0,r13
L_8e5338:
	mov_s r2,r15
L_8e533a:
	bl.d L_8e9c7c
L_8e533e:
	mov r4,0xd
L_8e5342:
	ld_s r0,[sp,0x0]
L_8e5344:
	ld_s r2,[r14,0x40]
L_8e5346:
	add_s r0,r0,r13
L_8e5348:
	ldb_s r2,[r2,0x4]
L_8e534a:
	mov_s r1,0x1
L_8e534c:
	bl.d L_8f5004
L_8e5350:
	mov_s r3,r17
L_8e5352:
	ld_s r15,[sp,0x0]
L_8e5354:
	mov r5,L_8c8d14-0x8c0000
L_8e535c:
	add_s r15,r15,r0
L_8e535e:
	st_s r15,[sp,0x0]
L_8e5360:
	ld_s r0,[r14,0x40]
L_8e5362:
	extw r4,r15
L_8e5366:
	ld_s r0,[r0]
L_8e5368:
	mov_s r1,r16
L_8e536a:
	mov_s r2,0x1
L_8e536c:
	mov_s r3,r13
L_8e536e:
	bl.d L_8e5874
L_8e5372:
	mov r6,r16
L_8e5376:
	b.d L_8c023c
L_8e537a:
	add_s sp,sp,0x4
	.global L_8e537c
L_8e537c:
	mov_s r0,blink
L_8e537e:
	mov_s r1,0x1282
L_8e5384:
	bl L_8c9b28
L_8e5388:
	b_s L_8e532a
L_8e538a:
	nop_s
