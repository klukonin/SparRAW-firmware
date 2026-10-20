/* evt_set_selected_rf_sector_index_done @ 0x8cd58c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SET_SELECTED_RF_SECTOR_INDEX_DONE_EVENTID, status=%d
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, mem_pool__alloc_locked, memcpy_fw, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global evt_set_selected_rf_sector_index_done
evt_set_selected_rf_sector_index_done:
	.global L_8cd58c
L_8cd58c:
	push_s blink
L_8cd58e:
	bl L_8c01dc
L_8cd592:
	sub_s sp,sp,0x4
L_8cd594:
	mov_s r13,r0
L_8cd596:
	mov_s r16,r1
L_8cd598:
	bl.d L_8c33d0
L_8cd59c:
	ld_s r0,[r0,0x4]
L_8cd59e:
	mov_s r1,r16
L_8cd5a0:
	mov_s r15,r0
L_8cd5a2:
	bl.d L_8c0380
L_8cd5a6:
	mov_s r2,0x4
L_8cd5a8:
	mov_s r1,0x1008b8c
L_8cd5ae:
	mov_s r0,0x2b
L_8cd5b0:
	bl.d L_8dcc10
L_8cd5b4:
	ldb_s r2,[r15]
L_8cd5b6:
	mov_s r14,0x0
L_8cd5b8:
	st_s r14,[sp,0x0]
L_8cd5ba:
	ld_s r0,[r13,0x4]
L_8cd5bc:
	mov_s r1,r15
L_8cd5be:
	mov_s r2,r14
L_8cd5c0:
	mov_s r3,0x19a3
L_8cd5c6:
	mov r4,0x4
L_8cd5ca:
	mov_s r5,r14
L_8cd5cc:
	mov_s r6,r14
L_8cd5ce:
	bl.d L_8e4fc4
L_8cd5d2:
	mov_s r7,r14
L_8cd5d4:
	st_s r14,[r13,0x4]
L_8cd5d6:
	b.d L_8c0244
L_8cd5da:
	add_s sp,sp,0x4
