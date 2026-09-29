/* wmi_evt__send_command_not_supported @ 0x8e5728, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ---->> [HOST CMD] WMI_COMMAND_NOT_SUPPORTED_EVENT command 0x%x subtype 0x%x
 * Зовут его: UT_HW_DRIVERS_cmd_handler, UT_HW_FLOWS_OPERATIONAL_cmd_handler, UT_HW_MODES_cmd_handler, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler, ut_hw_drivers__reply_not_supported, wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit2, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_evt__send_command_not_supported
wmi_evt__send_command_not_supported:
	.global L_8e5728
L_8e5728:
	push_s blink
L_8e572a:
	bl L_8c01d8
L_8e572e:
	sub_s sp,sp,0x4
L_8e5730:
	mov_s r17,r0
L_8e5732:
	mov_s r13,r1
L_8e5734:
	mov_s r15,r2
L_8e5736:
	mov_s r16,r3
L_8e5738:
	mov_s r1,0x10060cc
L_8e573e:
	mov_s r14,0x0
L_8e5740:
	mov_s r0,r14
L_8e5742:
	mov_s r2,r13
L_8e5744:
	bl.d L_8dcc80
L_8e5748:
	mov_s r3,r15
L_8e574a:
	bl.d L_8c33d0
L_8e574e:
	mov_s r0,r17
L_8e5750:
	mov_s r1,r0
L_8e5752:
	stb r16,[r0]
L_8e5756:
	stw_s r13,[r0,0x2]
L_8e5758:
	stw_s r15,[r0,0x4]
L_8e575a:
	st_s r14,[sp,0x0]
L_8e575c:
	mov_s r0,r17
L_8e575e:
	mov_s r2,r14
L_8e5760:
	mov_s r3,0xffff
L_8e5766:
	mov r4,0x8
L_8e576a:
	mov r5,r16
L_8e576e:
	mov_s r6,r14
L_8e5770:
	bl.d L_8e4fc4
L_8e5774:
	mov_s r7,r14
L_8e5776:
	b.d L_8c023c
L_8e577a:
	add_s sp,sp,0x4
