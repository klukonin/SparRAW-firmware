/* wmi_set_rf_sector_on_cmd_handler @ 0x8eceb8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_set_rf_sector_on_cmd_handler(): WMI_RF_SECTOR_STATUS_NOT_SUPPORTED_ERROR. This command is only supported in WMI_ONLY_FW (not in operational mode)
 *   wmi_set_rf_sector_on_cmd_handler(): Command execution aborted, error_status=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_log_emit1, mem_pool__alloc_locked, memset0_words, rf_cfg__get_rf_mask_45e, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_set_rf_sector_on_cmd_handler
wmi_set_rf_sector_on_cmd_handler:
	.global L_8eceb8
L_8eceb8:
	push_s blink
L_8eceba:
	bl L_8c01dc
L_8ecebe:
	sub_s sp,sp,0x4
L_8ecec0:
	mov_s r0,0x8042c8
L_8ecec6:
	bl.d L_8ccb3c
L_8ececa:
	mov_s r16,r1
L_8ececc:
	mov_s r1,0x1007c18
L_8eced2:
	bl.d L_8dcba8
L_8eced6:
	mov_s r0,0x5
L_8eced8:
	mov_s r15,0x3
L_8eceda:
	mov_s r1,0x1007cb0
L_8ecee0:
	mov_s r13,0x0
L_8ecee2:
	mov_s r0,r13
L_8ecee4:
	bl.d L_8dcc10
L_8ecee8:
	mov_s r2,r15
L_8eceea:
	bl.d L_8c33d0
L_8eceee:
	mov_s r0,r16
L_8ecef0:
	mov_s r14,r0
L_8ecef2:
	bl.d L_8c1cd8
L_8ecef6:
	mov_s r1,0x4
L_8ecef8:
	stb_s r15,[r14]
L_8ecefa:
	st_s r13,[sp,0x0]
L_8ecefc:
	mov_s r0,r16
L_8ecefe:
	mov_s r1,r14
L_8ecf00:
	mov_s r2,r13
L_8ecf02:
	mov_s r3,0x19a4
L_8ecf08:
	mov r4,0x4
L_8ecf0c:
	mov_s r5,r13
L_8ecf0e:
	mov_s r6,r13
L_8ecf10:
	bl.d L_8e4fc4
L_8ecf14:
	mov_s r7,r13
L_8ecf16:
	b.d L_8c0244
L_8ecf1a:
	add_s sp,sp,0x4
