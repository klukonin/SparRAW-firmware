/* conn_sm__inject_event @ 0x8d6b78, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__inject_evt3, conn__inject_evt4, conn_disc_sm__disassoc_sent_cb, l2mgr__apply_key_to_prings, mlme_notify, stream__inject_evt1
 * Зовёт сам: basic_sm__inject_event
 */
	.section .text.conn_sm__inject_event,"ax",@progbits
	.global conn_sm__inject_event
conn_sm__inject_event:
	.global L_8d6b78
L_8d6b78:
	b.d L_8d6a1c
L_8d6b7c:
	add r0,r0,0x12c
