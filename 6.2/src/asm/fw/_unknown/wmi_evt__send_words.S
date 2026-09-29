/* wmi_evt__send_words @ 0x8eae78, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, UT_HW_FLOWS_OPERATIONAL_cmd_handler, UT_HW_MODES_cmd_handler, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler, fw_sysapi_mgr__send_evt2host, hw_sysapi_get_beamforming_statistics, hw_sysapi_rfc_read_write_rgf
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_sysassert_fatal, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_evt__send_words
wmi_evt__send_words:
	.global L_8eae78
L_8eae78:
	push_s blink
L_8eae7a:
	bl L_8c01d8
L_8eae7e:
	sub_s sp,sp,0x4
L_8eae80:
	mov_s r13,r0
L_8eae82:
	mov_s r17,r1
L_8eae84:
	mov_s r16,r2
L_8eae86:
	mov_s r1,0x1
L_8eae88:
	b_s L_8eae8c
	.global L_8eae8a
L_8eae8a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8eae8c
L_8eae8c:
	sub r0,r16,0x8
L_8eae90:
	/* asr_s r0,r0,0x2 */
	.byte 0x42,0xb8
L_8eae92:
	brge r0,r1,L_8eae8a
L_8eae96:
	ld_s r0,[r13,0x74]
L_8eae98:
	brlo r0,r16,L_8eaebc
	.global L_8eae9c
L_8eae9c:
	mov_s r2,0x0
L_8eae9e:
	st_s r2,[sp,0x0]
L_8eaea0:
	mov_s r0,r13
L_8eaea2:
	mov_s r1,r17
L_8eaea4:
	mov_s r3,0x19
L_8eaea6:
	asl_s r3,r3,0x8
L_8eaea8:
	mov r4,r16
L_8eaeac:
	mov_s r5,r2
L_8eaeae:
	mov_s r6,r2
L_8eaeb0:
	bl.d L_8e4fc4
L_8eaeb4:
	mov_s r7,r2
L_8eaeb6:
	b.d L_8c023c
L_8eaeba:
	add_s sp,sp,0x4
	.global L_8eaebc
L_8eaebc:
	mov_s r0,blink
L_8eaebe:
	mov_s r1,0xce
L_8eaec0:
	bl.d L_8c9b28
L_8eaec4:
	bset_s r1,r1,0xc
L_8eaec6:
	b_s L_8eae9c
