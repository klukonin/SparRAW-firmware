/* wmi__set_mac_address_thunk @ 0x8ece1c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: l2mgr__set_mac_address
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi__set_mac_address_thunk
wmi__set_mac_address_thunk:
	.global L_8ece1c
L_8ece1c:
	b L_8fbc64
