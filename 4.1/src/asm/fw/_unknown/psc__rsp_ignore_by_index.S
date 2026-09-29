/* psc__rsp_ignore_by_index @ 0x8ddac8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__rx_action
 * Зовёт сам: ps_connection__psc_rsp_ignore
 */
	.section .text.psc__rsp_ignore_by_index,"ax",@progbits
	.global psc__rsp_ignore_by_index
psc__rsp_ignore_by_index:
	.global L_8ddac8
L_8ddac8:
	mul64 r0,0xf4
L_8ddacc:
	add r0,mlo,0x80361c
L_8ddad4:
	b L_8ddaa8
