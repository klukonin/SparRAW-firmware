/* ut_hw_drivers__zero_result @ 0x8f3ed8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hw_personality__read_strap, sdp__read_880b98_bit
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_drivers__zero_result
ut_hw_drivers__zero_result:
	.global L_8f3ed8
L_8f3ed8:
	push_s blink
L_8f3eda:
	bl L_8c01d8
L_8f3ede:
	mov_s r15,r0
L_8f3ee0:
	mov_s r16,r1
L_8f3ee2:
	mov_s r14,0x0
L_8f3ee4:
	st_s r14,[r0]
L_8f3ee6:
	st_s r14,[r1]
L_8f3ee8:
	mov_s r13,0x17
	.global L_8f3eea
L_8f3eea:
	add r17,r14,0x5
L_8f3eee:
	bl.d L_8f4404
L_8f3ef2:
	mov_s r0,r17
L_8f3ef4:
	ld_s r1,[r15]
L_8f3ef6:
	asl_s r0,r0,r14
L_8f3ef8:
	or_s r0,r0,r1
L_8f3efa:
	st_s r0,[r15]
L_8f3efc:
	bl.d L_8f4424
L_8f3f00:
	mov_s r0,r17
L_8f3f02:
	ld r1,[r16]
L_8f3f06:
	asl_s r0,r0,r14
L_8f3f08:
	or_s r0,r0,r1
L_8f3f0a:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8f3f0c:
	st r0,[r16]
L_8f3f10:
	/* brhs.d r13,0x1,0x008f3eea */
	.byte 0xdb,0x0d,0x75,0x90
L_8f3f14:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8f3f16:
	b L_8c023c
L_8f3f1a:
	nop_s
