/* psc__copy_req_params @ 0x8e2270, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_connection__psc_req_rx
 * Зовёт сам: memcpy_fw
 */
	.section .text.psc__copy_req_params,"ax",@progbits
	.global psc__copy_req_params
psc__copy_req_params:
	.global L_8e2270
L_8e2270:
	add_s r0,r0,0x38
L_8e2272:
	b.d L_8c0460
L_8e2276:
	mov_s r2,0x8
