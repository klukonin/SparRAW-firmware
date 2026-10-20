/* radio_manager__lock_secondary @ 0x8d9314, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   radio_manager::lock_secondary() (m_allocated = %d) (free cellls = %d)
 *   radio_manager.cpp
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit2, fw_sysassert_fatal, mem_pool__allocate, radio_mgr__enqueue_request
 */
	.section .text.radio_manager__lock_secondary,"ax",@progbits
	.global radio_manager__lock_secondary
radio_manager__lock_secondary:
L_8d9314:
	push_s blink
L_8d9316:
	bl L_8c02b0
L_8d931a:
	mov_s r14,r0
L_8d931c:
	mov_s r15,r1
L_8d931e:
	mov_s r17,r2
L_8d9320:
	mov_s r16,r3
L_8d9322:
	mov r19,r4
L_8d9326:
	add_s r13,r0,0x4
L_8d9328:
	ld_s r3,[r13,0xc]
L_8d932a:
	ld_s r0,[r13,0x10]
L_8d932c:
	mov r18,r5
L_8d9330:
	sub r4,r0,r3
L_8d9334:
	mov_s r2,0x1015cd8
L_8d933a:
	mov_s r0,0x8
L_8d933c:
	bl.d L_8edff8
L_8d9340:
	mov_s r1,0x2
L_8d9342:
	bl.d L_8c2dc8
L_8d9346:
	mov_s r0,r13
L_8d9348:
	mov.f r13,r0
L_8d934c:
	beq_s L_8d9376
	.global L_8d934e
L_8d934e:
	mov_s r1,0x1
L_8d9350:
	st_s r1,[r13,0x14]
L_8d9352:
	st r16,[r13, 0x1c]
L_8d9356:
	st r19,[r13, 0x18]
L_8d935a:
	st_s r15,[r13,0xc]
L_8d935c:
	st r17,[r13, 0x10]
L_8d9360:
	st_s r1,[r13,0x8]
L_8d9362:
	stb r18,[r13, 0x20]
L_8d9366:
	add r0,r14,0x18
L_8d936a:
	bl.d L_8ddc28
L_8d936e:
	mov_s r1,r13
L_8d9370:
	b.d L_8c030c
L_8d9374:
	mov_s r0,r13
	.global L_8d9376
L_8d9376:
	mov_s r0,blink
L_8d9378:
	mov_s r2,0x1015cc4
L_8d937e:
	mov_s r1,0x115e
L_8d9384:
	bl.d L_8c82c0
L_8d9388:
	mov_s r3,0x26
L_8d938a:
	b_s L_8d934e
