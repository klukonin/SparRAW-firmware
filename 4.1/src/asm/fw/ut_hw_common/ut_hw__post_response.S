/* ut_hw__post_response @ 0x8e5b94, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ut_hw_common.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, UT_HW_MODES_cmd_handler, UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, basic_if__post_event, fw_sysassert_fatal
 */
	.section .text.ut_hw__post_response,"ax",@progbits
	.global ut_hw__post_response
ut_hw__post_response:
	.global L_8e5b94
L_8e5b94:
	push_s blink
L_8e5b96:
	bl L_8c02b4
L_8e5b9a:
	mov_s r18,r0
L_8e5b9c:
	mov_s r17,r1
L_8e5b9e:
	mov_s r16,r2
L_8e5ba0:
	mov_s r1,0x1
L_8e5ba2:
	b_s L_8e5ba6
	.global L_8e5ba4
L_8e5ba4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8e5ba6
L_8e5ba6:
	sub r0,r16,0x8
L_8e5baa:
	/* asr_s r0,r0,0x2 */
	.byte 0x42,0xb8
L_8e5bac:
	brge r0,r1,L_8e5ba4
L_8e5bb0:
	cmp r16,0x64
L_8e5bb4:
	bhi_s L_8e5bd2
	.global L_8e5bb6
L_8e5bb6:
	mov_s r0,r18
L_8e5bb8:
	mov_s r1,r17
L_8e5bba:
	mov_s r2,0x0
L_8e5bbc:
	mov_s r3,0x19
L_8e5bbe:
	asl_s r3,r3,0x8
L_8e5bc0:
	mov r4,r16
L_8e5bc4:
	mov_s r5,r2
L_8e5bc6:
	mov_s r6,r2
L_8e5bc8:
	bl.d L_8e0460
L_8e5bcc:
	mov_s r7,r2
L_8e5bce:
	b L_8c0314
	.global L_8e5bd2
L_8e5bd2:
	mov_s r0,blink
L_8e5bd4:
	mov_s r2,0x1019f10
L_8e5bda:
	mov_s r1,0xce
L_8e5bdc:
	bset_s r1,r1,0xc
L_8e5bde:
	bl.d L_8c82c0
L_8e5be2:
	mov_s r3,0x25
L_8e5be4:
	b_s L_8e5bb6
L_8e5be6:
	nop_s
