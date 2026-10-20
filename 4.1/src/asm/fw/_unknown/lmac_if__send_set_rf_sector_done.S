/* lmac_if__send_set_rf_sector_done @ 0x8cb274, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SET_SELECTED_RF_SECTOR_INDEX_DONE_EVENTID, status=%d
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit1, memcpy_fw
 */
	.section .text.lmac_if__send_set_rf_sector_done,"ax",@progbits
	.global lmac_if__send_set_rf_sector_done
lmac_if__send_set_rf_sector_done:
	.global L_8cb274
L_8cb274:
	push_s blink
L_8cb276:
	bl L_8c02c0
L_8cb27a:
	mov_s r13,r0
L_8cb27c:
	mov_s r15,r1
L_8cb27e:
	bl.d L_8c2c38
L_8cb282:
	ld_s r0,[r0,0x4]
L_8cb284:
	mov_s r1,r15
L_8cb286:
	mov_s r14,r0
L_8cb288:
	bl.d L_8c0460
L_8cb28c:
	mov_s r2,0x4
L_8cb28e:
	mov_s r2,0x1008100
L_8cb294:
	mov_s r0,0xb
L_8cb296:
	mov_s r1,0x2
L_8cb298:
	bl.d L_8edfcc
L_8cb29c:
	ldb_s r3,[r14]
L_8cb29e:
	mov_s r1,r14
L_8cb2a0:
	mov_s r14,0x0
L_8cb2a2:
	ld_s r0,[r13,0x4]
L_8cb2a4:
	mov_s r2,r14
L_8cb2a6:
	mov_s r3,0x19a3
L_8cb2ac:
	mov r4,0x4
L_8cb2b0:
	mov_s r5,r14
L_8cb2b2:
	mov_s r6,r14
L_8cb2b4:
	bl.d L_8e0460
L_8cb2b8:
	mov_s r7,r14
L_8cb2ba:
	b.d L_8c032c
L_8cb2be:
	st_s r14,[r13,0x4]
