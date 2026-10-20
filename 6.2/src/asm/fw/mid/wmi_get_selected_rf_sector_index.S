/* wmi_get_selected_rf_sector_index @ 0x8e5f44, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_GET_SELECTED_RF_SECTOR_INDEX_DONE_EVENT: Command execution aborted, error_status=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit1, mem_pool__alloc_locked, memcpy_fw, memset0_words, wmi_evt__post, wmi_handler_get_selected_rf_sector_index__check_inputs_valid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_get_selected_rf_sector_index
wmi_get_selected_rf_sector_index:
	.global L_8e5f44
L_8e5f44:
	push_s blink
L_8e5f46:
	bl L_8c01d8
L_8e5f4a:
	sub_s sp,sp,0x4
L_8e5f4c:
	mov_s r13,r0
L_8e5f4e:
	mov_s r17,r1
L_8e5f50:
	bl.d L_8c6160
L_8e5f54:
	mov_s r14,r2
L_8e5f56:
	mov.f r16,r0
L_8e5f5a:
	bne_s L_8e5f6c
L_8e5f5c:
	mov_s r0,r13
L_8e5f5e:
	mov_s r1,r17
L_8e5f60:
	bl.d L_8c0380
L_8e5f64:
	mov_s r2,0x4
L_8e5f66:
	st_s r14,[r13,0x4]
L_8e5f68:
	mov_s r0,0x1
L_8e5f6a:
	b_s L_8e5fac
	.global L_8e5f6c
L_8e5f6c:
	bl.d L_8c33d0
L_8e5f70:
	mov_s r0,r14
L_8e5f72:
	mov_s r15,r0
L_8e5f74:
	bl.d L_8c1cd8
L_8e5f78:
	mov_s r1,0x10
L_8e5f7a:
	stb r16,[r15, 0x2]
L_8e5f7e:
	mov_s r1,0x100878c
L_8e5f84:
	mov_s r13,0x0
L_8e5f86:
	mov_s r0,r13
L_8e5f88:
	bl.d L_8dcc10
L_8e5f8c:
	mov_s r2,r16
L_8e5f8e:
	st_s r13,[sp,0x0]
L_8e5f90:
	mov_s r0,r14
L_8e5f92:
	mov_s r1,r15
L_8e5f94:
	mov_s r2,r13
L_8e5f96:
	mov_s r3,0x19a2
L_8e5f9c:
	mov r4,0x10
L_8e5fa0:
	mov_s r5,r13
L_8e5fa2:
	mov_s r6,r13
L_8e5fa4:
	bl.d L_8e4fc4
L_8e5fa8:
	mov_s r7,r13
L_8e5faa:
	mov_s r0,r13
	.global L_8e5fac
L_8e5fac:
	b.d L_8c023c
L_8e5fb0:
	add_s sp,sp,0x4
L_8e5fb2:
	nop_s
