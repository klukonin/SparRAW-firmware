/* conn__sm_handle_event @ 0x8d9cc0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__inject_evt3, conn__inject_evt4, conn_disc_sm__disassoc_sent_cb, l2mgr__apply_key_to_prings, mlme_notify, stream__inject_evt1
 * Зовёт сам: basic_sm__handle_event
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__sm_handle_event
conn__sm_handle_event:
	.global L_8d9cc0
L_8d9cc0:
	b.d L_8d9b6c
L_8d9cc4:
	add r0,r0,0x130
