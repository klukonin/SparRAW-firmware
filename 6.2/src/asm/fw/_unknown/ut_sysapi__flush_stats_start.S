/* ut_sysapi__flush_stats_start @ 0x8ebbbc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: fw_sysapi_mgr__get_flush_statistics_cmd_start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_sysapi__flush_stats_start
ut_sysapi__flush_stats_start:
	.global L_8ebbbc
L_8ebbbc:
	mov_s r1,r0
L_8ebbbe:
	mov_s r0,0x805170
L_8ebbc4:
	b L_8f34fc
