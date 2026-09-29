/* radio_mgr__free_handle @ 0x8d9c0c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__primary_handle_free, rm_main_sm__secondary_handle_free
 * Зовёт сам: mem_pool__free
 */
	.section .text.radio_mgr__free_handle,"ax",@progbits
	.global radio_mgr__free_handle
radio_mgr__free_handle:
	.global L_8d9c0c
L_8d9c0c:
	mov_s r2,0x0
L_8d9c0e:
	st_s r2,[r1,0x8]
L_8d9c10:
	/* b.d 0x008c9268 */
	.byte 0x59,0x06,0xaf,0xf7
L_8d9c14:
	/* _add_s r0,0x4 */
	.byte 0x04,0xe0
L_8d9c16:
	nop_s
