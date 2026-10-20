/* queue_deleted_evt @ 0x8dc4a4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: stream_mgr__macq_removed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global queue_deleted_evt
queue_deleted_evt:
	.global L_8dc4a4
L_8dc4a4:
	b.d L_8c8d9c
L_8dc4a8:
	ldb_s r0,[r0]
L_8dc4aa:
	nop_s
