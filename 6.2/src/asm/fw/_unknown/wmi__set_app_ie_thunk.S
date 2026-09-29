/* wmi__set_app_ie_thunk @ 0x8ecdc8, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: l2mgr__set_app_ie
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi__set_app_ie_thunk
wmi__set_app_ie_thunk:
	.global L_8ecdc8
L_8ecdc8:
	b L_8fbb90
