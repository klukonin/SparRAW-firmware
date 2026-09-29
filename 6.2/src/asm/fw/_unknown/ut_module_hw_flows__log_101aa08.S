/* ut_module_hw_flows__log_101aa08 @ 0x8cddc8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UT_HW_SYSAPI_FORCE_ASSERT: waiting %d mSec
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_module_hw_flows__log_101aa08
ut_module_hw_flows__log_101aa08:
	.global L_8cddc8
L_8cddc8:
	push_s blink
L_8cddca:
	mov_s r2,r0
L_8cddcc:
	mov_s r1,0x101aa08
L_8cddd2:
	bl.d L_8dcc10
L_8cddd6:
	mov_s r0,0x25
L_8cddd8:
	mov_s r0,blink
L_8cddda:
	mov_s r1,0xb5
L_8cdddc:
	bl.d L_8c9b28
L_8cdde0:
	/* _asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8cdde2:
	pop_s blink
L_8cdde4:
	j_s [blink]
L_8cdde6:
	nop_s
