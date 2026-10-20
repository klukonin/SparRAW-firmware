/* wmi_get_rf_status @ 0x8dd3c8, 240 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_GET_RF_STATUS_EVENTID
 *   rf_type=%d attached_rf_vector=0x%02X enabled_rf_vector=0x%02X
 *   RF STATUS (of enabled RFs):
 *   [NNL] RF[%d]=%d
 *   Board file: RF_type=%d Platform_type=0x%x version=0x%x
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_log_emit0, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, mem_pool__alloc_locked, memset0_words, rf__get_module_info
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_get_rf_status
wmi_get_rf_status:
	.global L_8dd3c8
L_8dd3c8:
	push_s blink
L_8dd3ca:
	bl L_8c01d8
L_8dd3ce:
	sub_s sp,sp,0x8
L_8dd3d0:
	mov_s r16,r0
L_8dd3d2:
	bl.d L_8c33d0
L_8dd3d6:
	mov_s r17,r1
L_8dd3d8:
	mov.f r14,r0
L_8dd3dc:
	add r15,r0,0xc
L_8dd3e0:
	beq_s L_8dd4aa
	.global L_8dd3e2
L_8dd3e2:
	mov_s r0,r14
L_8dd3e4:
	bl.d L_8c1cd8
L_8dd3e8:
	mov_s r1,0x40
L_8dd3ea:
	mov_s r13,0x8042c8
L_8dd3f0:
	add_s r2,r14,0x4
L_8dd3f2:
	add r3,r14,0x8
L_8dd3f6:
	add r4,r14,0x38
L_8dd3fa:
	add r5,r14,0xc
L_8dd3fe:
	mov_s r0,r13
L_8dd400:
	mov_s r1,r14
L_8dd402:
	bl.d L_8f3704
L_8dd406:
	mov r6,0x20
L_8dd40a:
	add r1,r14,0x2c
L_8dd40e:
	add r2,r14,0x30
L_8dd412:
	add r3,r14,0x34
L_8dd416:
	bl.d L_8f3478
L_8dd41a:
	mov_s r0,r13
L_8dd41c:
	mov_s r1,0x100644c
L_8dd422:
	bl.d L_8dcba8
L_8dd426:
	mov_s r0,0x20
L_8dd428:
	ld r4,[r14, 0x8]
L_8dd42c:
	mov_s r1,0x100647c
L_8dd432:
	ld_s r2,[r14]
L_8dd434:
	mov_s r0,0x20
L_8dd436:
	bl.d L_8dcd00
L_8dd43a:
	ld_s r3,[r14,0x4]
L_8dd43c:
	mov_s r1,0x10064bc
L_8dd442:
	bl.d L_8dcba8
L_8dd446:
	mov_s r0,0x20
L_8dd448:
	add_s r13,sp,0x4
L_8dd44a:
	mov_s r0,r13
L_8dd44c:
	bl.d L_8e5dfc
L_8dd450:
	ld_s r1,[r14,0x8]
L_8dd452:
	b_s L_8dd46a
	.global L_8dd454
L_8dd454:
	bl.d L_8df444
L_8dd458:
	mov_s r0,r13
L_8dd45a:
	ldb_s r3,[r15,r0]
L_8dd45c:
	mov_s r2,r0
L_8dd45e:
	mov_s r1,0x10064d8
L_8dd464:
	bl.d L_8dcc80
L_8dd468:
	mov_s r0,0x20
	.global L_8dd46a
L_8dd46a:
	bl.d L_8cdcc4
L_8dd46e:
	mov_s r0,r13
L_8dd470:
	brne_s r0,0,L_8dd454
L_8dd472:
	ld r4,[r14, 0x34]
L_8dd476:
	mov_s r1,0x10064e8
L_8dd47c:
	ld_s r2,[r14,0x2c]
L_8dd47e:
	mov_s r0,0x20
L_8dd480:
	bl.d L_8dcd00
L_8dd484:
	ld_s r3,[r14,0x30]
L_8dd486:
	mov_s r2,0x0
L_8dd488:
	st_s r2,[sp,0x0]
L_8dd48a:
	mov_s r0,r16
L_8dd48c:
	mov_s r1,r14
L_8dd48e:
	mov_s r3,0x1866
L_8dd494:
	mov r4,0x40
L_8dd498:
	mov r5,r17
L_8dd49c:
	mov_s r6,r2
L_8dd49e:
	bl.d L_8e4fc4
L_8dd4a2:
	mov_s r7,r2
L_8dd4a4:
	b.d L_8c023c
L_8dd4a8:
	add_s sp,sp,0x8
	.global L_8dd4aa
L_8dd4aa:
	mov_s r0,blink
L_8dd4ac:
	mov_s r1,0x1455
L_8dd4b2:
	bl L_8c9b28
L_8dd4b6:
	b_s L_8dd3e2
