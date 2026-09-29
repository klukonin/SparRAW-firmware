/* evt_get_selected_rf_sector_index_done @ 0x8cd534, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_GET_SELECTED_RF_SECTOR_INDEX_DONE_EVENTID, status=%d, sector_idx=%d, tsf=0x%x
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit3, mem_pool__alloc_locked, memcpy_fw, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global evt_get_selected_rf_sector_index_done
evt_get_selected_rf_sector_index_done:
	.global L_8cd534
L_8cd534:
	push_s blink
L_8cd536:
	bl L_8c01dc
L_8cd53a:
	sub_s sp,sp,0x4
L_8cd53c:
	mov_s r13,r0
L_8cd53e:
	mov_s r16,r1
L_8cd540:
	bl.d L_8c33d0
L_8cd544:
	ld_s r0,[r0,0x4]
L_8cd546:
	mov_s r1,r16
L_8cd548:
	mov_s r14,r0
L_8cd54a:
	bl.d L_8c0380
L_8cd54e:
	mov_s r2,0x10
L_8cd550:
	ld r4,[r14, 0x8]
L_8cd554:
	mov_s r1,0x10087f8
L_8cd55a:
	ldb_s r2,[r14,0x2]
L_8cd55c:
	mov_s r0,0x2b
L_8cd55e:
	bl.d L_8dcd00
L_8cd562:
	ldw_s r3,[r14]
L_8cd564:
	mov_s r15,0x0
L_8cd566:
	st_s r15,[sp,0x0]
L_8cd568:
	ld_s r0,[r13,0x4]
L_8cd56a:
	mov_s r1,r14
L_8cd56c:
	mov_s r2,r15
L_8cd56e:
	mov_s r3,0x19a2
L_8cd574:
	mov r4,0x10
L_8cd578:
	mov_s r5,r15
L_8cd57a:
	mov_s r6,r15
L_8cd57c:
	bl.d L_8e4fc4
L_8cd580:
	mov_s r7,r15
L_8cd582:
	st_s r15,[r13,0x4]
L_8cd584:
	b.d L_8c0244
L_8cd588:
	add_s sp,sp,0x4
L_8cd58a:
	nop_s
