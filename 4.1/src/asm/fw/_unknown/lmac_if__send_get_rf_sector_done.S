/* lmac_if__send_get_rf_sector_done @ 0x8cb220, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_GET_SELECTED_RF_SECTOR_INDEX_DONE_EVENTID, status=%d, sector_idx=%d, tsf=0x%x
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit3, memcpy_fw
 */
	.section .text.lmac_if__send_get_rf_sector_done,"ax",@progbits
	.global lmac_if__send_get_rf_sector_done
lmac_if__send_get_rf_sector_done:
	.global L_8cb220
L_8cb220:
	push_s blink
L_8cb222:
	bl L_8c02c0
L_8cb226:
	mov_s r13,r0
L_8cb228:
	mov_s r15,r1
L_8cb22a:
	bl.d L_8c2c38
L_8cb22e:
	ld_s r0,[r0,0x4]
L_8cb230:
	mov_s r1,r15
L_8cb232:
	mov_s r14,r0
L_8cb234:
	bl.d L_8c0460
L_8cb238:
	mov_s r2,0x10
L_8cb23a:
	ldw r4,[r14]
L_8cb23e:
	mov_s r2,0x1007cbc
L_8cb244:
	ld r5,[r14, 0x8]
L_8cb248:
	mov_s r0,0xb
L_8cb24a:
	mov_s r1,0x2
L_8cb24c:
	bl.d L_8ee034
L_8cb250:
	ldb_s r3,[r14,0x2]
L_8cb252:
	mov_s r1,r14
L_8cb254:
	mov_s r14,0x0
L_8cb256:
	ld_s r0,[r13,0x4]
L_8cb258:
	mov_s r2,r14
L_8cb25a:
	mov_s r3,0x19a2
L_8cb260:
	mov r4,0x10
L_8cb264:
	mov_s r5,r14
L_8cb266:
	mov_s r6,r14
L_8cb268:
	bl.d L_8e0460
L_8cb26c:
	mov_s r7,r14
L_8cb26e:
	b.d L_8c032c
L_8cb272:
	st_s r14,[r13,0x4]
