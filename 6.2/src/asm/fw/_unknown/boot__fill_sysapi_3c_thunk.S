/* boot__fill_sysapi_3c_thunk @ 0x8f0000, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot__install_handler_ptrs
 * Зовёт сам: fw_sysapi__fill_at_3c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global boot__fill_sysapi_3c_thunk
boot__fill_sysapi_3c_thunk:
	.global L_8f0000
L_8f0000:
	b L_8f5368
