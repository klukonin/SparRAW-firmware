/* hw_sysapi_get_rx_packet_energy_statistics @ 0x8cdf70, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_sysapi_get_rx_packet_energy_statistics(): Energy Statistics request:  sta_id=%d, qid=%d, is_cp=%d
 *   hw_sysapi_get_rx_packet_energy_statistics(): mcs=%d, is_omni=%d, samples_num=%d
 *   hw_sysapi_get_rx_packet_energy_statistics(): timeout_usec=%d
 *   hw_sysapi_get_rx_packet_energy_statistics(): ut_wmi_context, ut_module_id=0x%x, ut_subtype_id=0x%x, host_if_p=0x%x
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, fw_log_emit1, fw_log_emit3, fw_sysapi_mgr__start_energy_statistics
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_sysapi_get_rx_packet_energy_statistics
hw_sysapi_get_rx_packet_energy_statistics:
	.global L_8cdf70
L_8cdf70:
	push_s blink
L_8cdf72:
	bl L_8c01cc
L_8cdf76:
	sub_s sp,sp,0x8
L_8cdf78:
	mov_s r14,r0
L_8cdf7a:
	mov_s r13,r1
L_8cdf7c:
	mov_s r20,r2
L_8cdf7e:
	mov_s r15,r3
L_8cdf80:
	mov r17,r4
L_8cdf84:
	mov r19,r5
L_8cdf88:
	mov r16,r6
L_8cdf8c:
	mov r18,r7
L_8cdf90:
	mov_s r1,0x101a0fc
L_8cdf96:
	mov_s r0,0x25
L_8cdf98:
	mov_s r2,r14
L_8cdf9a:
	mov_s r3,r13
L_8cdf9c:
	bl.d L_8dcd00
L_8cdfa0:
	mov r4,r20
L_8cdfa4:
	mov_s r1,0x101a164
L_8cdfaa:
	mov_s r0,0x25
L_8cdfac:
	mov_s r2,r15
L_8cdfae:
	mov_s r3,r17
L_8cdfb0:
	bl.d L_8dcd00
L_8cdfb4:
	mov r4,r19
L_8cdfb8:
	mov_s r1,0x101a1b4
L_8cdfbe:
	mov_s r0,0x25
L_8cdfc0:
	bl.d L_8dcc10
L_8cdfc4:
	mov_s r2,r16
L_8cdfc6:
	ld r4,[r18, 0x4]
L_8cdfca:
	mov_s r1,0x101a1f4
L_8cdfd0:
	ldw r2,[r18]
L_8cdfd4:
	mov_s r0,0x25
L_8cdfd6:
	bl.d L_8dcd00
L_8cdfda:
	ldw r3,[r18, 0x2]
L_8cdfde:
	mov_s r1,0x80359c
L_8cdfe4:
	ld_s r0,[r1]
L_8cdfe6:
	mov_s r2,r19
L_8cdfe8:
	st_s r0,[sp,0x0]
L_8cdfea:
	ldb_s r0,[r1,0x4]
L_8cdfec:
	stb_s r14,[sp,0x0]
L_8cdfee:
	stb_s r0,[sp,0x4]
L_8cdff0:
	stb r13,[sp, 0x1]
L_8cdff4:
	stb r20,[sp, 0x2]
L_8cdff8:
	stb r15,[sp, 0x3]
L_8cdffc:
	stb r17,[sp, 0x4]
L_8ce000:
	mov_s r0,0x805170
L_8ce006:
	mov_s r1,sp
L_8ce008:
	mov_s r3,r16
L_8ce00a:
	bl.d L_8f2cc0
L_8ce00e:
	mov r4,r18
L_8ce012:
	b.d L_8c0224
L_8ce016:
	add_s sp,sp,0x8
