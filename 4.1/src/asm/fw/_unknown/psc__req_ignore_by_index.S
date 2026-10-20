/* psc__req_ignore_by_index @ 0x8dd830, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__rx_action
 * Зовёт сам: ps_connection__psc_req_ignore
 */
	.section .text.psc__req_ignore_by_index,"ax",@progbits
	.global psc__req_ignore_by_index
psc__req_ignore_by_index:
	.global L_8dd830
L_8dd830:
	mul64 r0,0xf4
L_8dd834:
	add r0,mlo,0x80361c
L_8dd83c:
	b L_8dd810
