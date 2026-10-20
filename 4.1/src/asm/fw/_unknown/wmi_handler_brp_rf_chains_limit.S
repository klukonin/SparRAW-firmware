/* wmi_handler_brp_rf_chains_limit @ 0x8e740c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 */
	.section .text.wmi_handler_brp_rf_chains_limit,"ax",@progbits
	.global wmi_handler_brp_rf_chains_limit
wmi_handler_brp_rf_chains_limit:
	.global L_8e740c
L_8e740c:
	ld_s r1,[r0]
L_8e740e:
	mov_s r0,0x857000
L_8e7414:
	j_s.d [blink]
L_8e7416:
	st_s r1,[r0,0x50]
