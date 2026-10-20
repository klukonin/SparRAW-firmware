/* stream_mgr__prepare_buf30_by_id @ 0x8cccb4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: stream_mgr__ready_for_modify
 * Зовёт сам: buf30__prepare_and_call_8c50f8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__prepare_buf30_by_id
stream_mgr__prepare_buf30_by_id:
	.global L_8cccb4
L_8cccb4:
	b.d L_8dd8ec
L_8cccb8:
	ldb_s r0,[r0,0xa]
L_8cccba:
	nop_s
