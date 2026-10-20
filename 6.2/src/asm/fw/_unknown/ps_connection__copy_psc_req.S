/* ps_connection__copy_psc_req @ 0x8e738c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ps_connection__psc_req_rx
 * Зовёт сам: memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_connection__copy_psc_req
ps_connection__copy_psc_req:
	.global L_8e738c
L_8e738c:
	add_s r0,r0,0x14
L_8e738e:
	b.d L_8c0380
L_8e7392:
	mov_s r2,0x8
