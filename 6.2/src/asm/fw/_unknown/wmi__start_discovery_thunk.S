/* wmi__start_discovery_thunk @ 0x8ec3e0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: l2mgr__start_discovery
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi__start_discovery_thunk
wmi__start_discovery_thunk:
	.global L_8ec3e0
L_8ec3e0:
	b L_8fbd1c
