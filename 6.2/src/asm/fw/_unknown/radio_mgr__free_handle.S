/* radio_mgr__free_handle @ 0x8ddb0c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__primary_handle_free, rm_main_sm__secondary_handle_free
 * Зовёт сам: stream_mgr__check_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio_mgr__free_handle
radio_mgr__free_handle:
	.global L_8ddb0c
L_8ddb0c:
	mov_s r2,0x0
L_8ddb0e:
	st_s r2,[r1,0x8]
L_8ddb10:
	b.d L_8caed0
L_8ddb14:
	/* _add_s r0,0x4 */
	.byte 0x04,0xe0
L_8ddb16:
	nop_s
