/* sysapi_mgr__apply_ut_args @ 0x8cdd60, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r13_to_r13_ret, sched__apply_entry
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sysapi_mgr__apply_ut_args
sysapi_mgr__apply_ut_args:
	.global L_8cdd60
L_8cdd60:
	push_s blink
L_8cdd62:
	push_s r13
L_8cdd64:
	mov_s r13,r1
L_8cdd66:
	mov_s r3,r2
L_8cdd68:
	add_s r1,r0,0x4
L_8cdd6a:
	mov_s r0,0x805170
L_8cdd70:
	bl.d L_8f1dc4
L_8cdd74:
	mov_s r2,r13
L_8cdd76:
	b L_8c025c
L_8cdd7a:
	nop_s
