/* hw_sysapi_plcp_header @ 0x8ce120, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_sysapi_plcp_header(): PLCP Header request:  sta_id=%d, qid=%d, is_cp=%d
 *   hw_sysapi_plcp_header(): mcs=%d, timeout_usec=%d
 *   hw_sysapi_get_rx_packet_energy_statistics(): ut_wmi_context, ut_module_id=0x%x, ut_subtype_id=0x%x, host_if_p=0x%x
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit2, fw_log_emit3, fw_sysapi_mgr__start_plcp_header
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_sysapi_plcp_header
hw_sysapi_plcp_header:
	.global L_8ce120
L_8ce120:
	push_s blink
L_8ce122:
	bl L_8c01d0
L_8ce126:
	sub_s sp,sp,0x8
L_8ce128:
	mov_s r14,r0
L_8ce12a:
	mov_s r15,r1
L_8ce12c:
	mov_s r19,r2
L_8ce12e:
	mov_s r16,r3
L_8ce130:
	mov r18,r4
L_8ce134:
	mov r17,r5
L_8ce138:
	mov_s r13,r6
L_8ce13a:
	mov_s r1,0x101a41c
L_8ce140:
	mov_s r0,0x25
L_8ce142:
	mov_s r2,r14
L_8ce144:
	mov_s r3,r15
L_8ce146:
	bl.d L_8dcd00
L_8ce14a:
	mov r4,r19
L_8ce14e:
	mov_s r1,0x101a468
L_8ce154:
	mov_s r0,0x25
L_8ce156:
	mov_s r2,r16
L_8ce158:
	bl.d L_8dcc80
L_8ce15c:
	mov_s r3,r17
L_8ce15e:
	ld r4,[r13, 0x4]
L_8ce162:
	mov_s r1,0x101a1f4
L_8ce168:
	ldw_s r2,[r13]
L_8ce16a:
	mov_s r0,0x25
L_8ce16c:
	bl.d L_8dcd00
L_8ce170:
	ldw_s r3,[r13,0x2]
L_8ce172:
	mov_s r1,0x80359c
L_8ce178:
	ld_s r0,[r1,0x8]
L_8ce17a:
	mov_s r2,r17
L_8ce17c:
	st_s r0,[sp,0x0]
L_8ce17e:
	ldb_s r0,[r1,0xc]
L_8ce180:
	stb_s r14,[sp,0x0]
L_8ce182:
	stb_s r0,[sp,0x4]
L_8ce184:
	stb r15,[sp, 0x1]
L_8ce188:
	stb r19,[sp, 0x2]
L_8ce18c:
	stb r16,[sp, 0x3]
L_8ce190:
	stb r18,[sp, 0x4]
L_8ce194:
	mov_s r0,0x805170
L_8ce19a:
	mov_s r1,sp
L_8ce19c:
	bl.d L_8f73b0
L_8ce1a0:
	mov_s r3,r13
L_8ce1a2:
	b.d L_8c022c
L_8ce1a6:
	add_s sp,sp,0x8
