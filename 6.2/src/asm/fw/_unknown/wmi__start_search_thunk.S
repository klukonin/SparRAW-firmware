/* wmi__start_search_thunk @ 0x8ec3e8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: l2_mgr__wmi_cmd_handler_start_search
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi__start_search_thunk
wmi__start_search_thunk:
	.global L_8ec3e8
L_8ec3e8:
	b L_8fbd90
