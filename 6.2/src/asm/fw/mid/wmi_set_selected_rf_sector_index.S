/* wmi_set_selected_rf_sector_index @ 0x8e5fb4, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SET_SELECTED_RF_SECTOR_INDEX_DONE_EVENTID: Command execution aborted, error_status=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit1, mem_pool__alloc_locked, memcpy_fw, memset0_words, wmi_evt__post, wmi_handler_set_selected_rf_sector_index__check_inputs_valid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_set_selected_rf_sector_index
wmi_set_selected_rf_sector_index:
	.global L_8e5fb4
L_8e5fb4:
	push_s blink
L_8e5fb6:
	bl L_8c01d8
L_8e5fba:
	sub_s sp,sp,0x4
L_8e5fbc:
	mov_s r13,r0
L_8e5fbe:
	mov_s r17,r1
L_8e5fc0:
	bl.d L_8c61d4
L_8e5fc4:
	mov_s r14,r2
L_8e5fc6:
	mov.f r16,r0
L_8e5fca:
	bne_s L_8e5fdc
L_8e5fcc:
	mov_s r0,r13
L_8e5fce:
	mov_s r1,r17
L_8e5fd0:
	bl.d L_8c0380
L_8e5fd4:
	mov_s r2,0x4
L_8e5fd6:
	st_s r14,[r13,0x4]
L_8e5fd8:
	mov_s r0,0x1
L_8e5fda:
	b_s L_8e601c
	.global L_8e5fdc
L_8e5fdc:
	bl.d L_8c33d0
L_8e5fe0:
	mov_s r0,r14
L_8e5fe2:
	mov_s r15,r0
L_8e5fe4:
	bl.d L_8c1cd8
L_8e5fe8:
	mov_s r1,0x4
L_8e5fea:
	stb r16,[r15]
L_8e5fee:
	mov_s r1,0x1008b1c
L_8e5ff4:
	mov_s r13,0x0
L_8e5ff6:
	mov_s r0,r13
L_8e5ff8:
	bl.d L_8dcc10
L_8e5ffc:
	mov_s r2,r16
L_8e5ffe:
	st_s r13,[sp,0x0]
L_8e6000:
	mov_s r0,r14
L_8e6002:
	mov_s r1,r15
L_8e6004:
	mov_s r2,r13
L_8e6006:
	mov_s r3,0x19a3
L_8e600c:
	mov r4,0x4
L_8e6010:
	mov_s r5,r13
L_8e6012:
	mov_s r6,r13
L_8e6014:
	bl.d L_8e4fc4
L_8e6018:
	mov_s r7,r13
L_8e601a:
	mov_s r0,r13
	.global L_8e601c
L_8e601c:
	b.d L_8c023c
L_8e6020:
	add_s sp,sp,0x4
L_8e6022:
	nop_s
