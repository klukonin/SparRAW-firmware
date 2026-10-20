/* hw_sysapi_channel_estimation @ 0x8cdcdc, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_sysapi_channel_estimation(): channel estimation request:  sta_id=%d, is_omni=%d
 *   hw_sysapi_channel_estimation(): ut_wmi_context, ut_module_id=0x%x, ut_subtype_id=0x%x, host_if_p=0x%x
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, channel_estimation_cmd_start, fw_log_emit2, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_sysapi_channel_estimation
hw_sysapi_channel_estimation:
	.global L_8cdcdc
L_8cdcdc:
	sub_s sp,sp,0x8
L_8cdcde:
	push_s blink
L_8cdce0:
	bl L_8c01cc
L_8cdce4:
	sub_s sp,sp,0x8
L_8cdce6:
	mov_s r13,r6
L_8cdce8:
	st r6,[sp, 0x2c]
L_8cdcec:
	mov r20,r7
L_8cdcf0:
	mov_s r14,r0
L_8cdcf2:
	mov_s r16,r1
L_8cdcf4:
	mov_s r17,r2
L_8cdcf6:
	mov_s r18,r3
L_8cdcf8:
	mov_s r15,r4
L_8cdcfa:
	mov r19,r5
L_8cdcfe:
	mov_s r1,0x101aa34
L_8cdd04:
	mov_s r0,0x25
L_8cdd06:
	mov_s r2,r14
L_8cdd08:
	bl.d L_8dcc80
L_8cdd0c:
	mov_s r3,r4
L_8cdd0e:
	ldw r2,[sp, 0x2c]
L_8cdd12:
	mov_s r1,0x101aa88
L_8cdd18:
	ldw r3,[sp, 0x2e]
L_8cdd1c:
	mov_s r0,0x25
L_8cdd1e:
	bl.d L_8dcd00
L_8cdd22:
	mov r4,r20
L_8cdd26:
	mov_s r1,0x8035dc
L_8cdd2c:
	ld_s r0,[r1,0x14]
L_8cdd2e:
	mov_s r2,r19
L_8cdd30:
	st_s r0,[sp,0x0]
L_8cdd32:
	ldb_s r0,[r1,0x18]
L_8cdd34:
	stb_s r14,[sp,0x0]
L_8cdd36:
	stb_s r0,[sp,0x4]
L_8cdd38:
	stb r16,[sp, 0x1]
L_8cdd3c:
	stb r17,[sp, 0x2]
L_8cdd40:
	stb r18,[sp, 0x3]
L_8cdd44:
	stb_s r15,[sp,0x4]
L_8cdd46:
	mov_s r0,0x805170
L_8cdd4c:
	mov_s r1,sp
L_8cdd4e:
	mov_s r3,r13
L_8cdd50:
	bl.d L_8f17a0
L_8cdd54:
	mov r4,r20
L_8cdd58:
	mov_s r12,0xc
L_8cdd5a:
	b.d L_8c0226
L_8cdd5e:
	add_s sp,sp,0x8
