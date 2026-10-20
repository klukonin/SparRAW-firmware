/* wmi__stop_discovery_thunk @ 0x8ec3ec, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: l2mgr__stop_discovery
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi__stop_discovery_thunk
wmi__stop_discovery_thunk:
	.global L_8ec3ec
L_8ec3ec:
	b L_8fbde4
