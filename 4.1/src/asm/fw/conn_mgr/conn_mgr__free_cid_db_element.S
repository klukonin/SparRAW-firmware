/* conn_mgr__free_cid_db_element @ 0x8c9304, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   conn_mgr::free_cid_db_element() CID %d::::: 0x%x status %d.
 *   conn_mgr.cpp
 * Зовут его: conn_mgr__link_down_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit3, fw_sysassert_fatal, mem_pool__free
 */
	.section .text.conn_mgr__free_cid_db_element,"ax",@progbits
	.global conn_mgr__free_cid_db_element
conn_mgr__free_cid_db_element:
	.global L_8c9304
L_8c9304:
	push_s blink
L_8c9306:
	bl.d L_8c02c4
L_8c930a:
	mov_s r3,r0
L_8c930c:
	mov_s r13,0x80469c
L_8c9312:
	add3_s r13,r13,r0
L_8c9314:
	ld r4,[r13, 0x4]
L_8c9318:
	mov_s r2,0x100a83c
L_8c931e:
	ld r5,[r13]
L_8c9322:
	mov_s r0,0xb
L_8c9324:
	bl.d L_8ee034
L_8c9328:
	mov_s r1,0x2
L_8c932a:
	ld_s r0,[r13]
L_8c932c:
	mov_s r14,0x8046dc
L_8c9332:
	breq_s r0,0,L_8c934a
	.global L_8c9334
L_8c9334:
	ld_s r0,[r13,0x4]
L_8c9336:
	breq_s r0,0,L_8c9362
	.global L_8c9338
L_8c9338:
	mov_s r0,r14
L_8c933a:
	bl.d L_8c9268
L_8c933e:
	ld_s r1,[r13,0x4]
L_8c9340:
	mov_s r0,0x0
L_8c9342:
	st_s r0,[r13,0x4]
L_8c9344:
	b.d L_8c0334
L_8c9348:
	st_s r0,[r13]
	.global L_8c934a
L_8c934a:
	mov_s r0,blink
L_8c934c:
	mov_s r2,0x100a878
L_8c9352:
	mov_s r1,0x11cf
L_8c9358:
	bl.d L_8c82c0
L_8c935c:
	mov r3,0x13b
L_8c9360:
	b_s L_8c9334
	.global L_8c9362
L_8c9362:
	mov_s r0,blink
L_8c9364:
	mov_s r2,0x100a878
L_8c936a:
	mov_s r1,0x11d0
L_8c9370:
	bl.d L_8c82c0
L_8c9374:
	mov r3,0x13c
L_8c9378:
	b_s L_8c9338
L_8c937a:
	nop_s
