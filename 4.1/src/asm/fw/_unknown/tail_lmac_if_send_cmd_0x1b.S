/* tail_lmac_if_send_cmd_0x1b @ 0x8c63a4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__publish_assoc_done
 * Зовёт сам: lmac_if_send_cmd_0x1b
 */
	.section .text.tail_lmac_if_send_cmd_0x1b,"ax",@progbits
	.global tail_lmac_if_send_cmd_0x1b
tail_lmac_if_send_cmd_0x1b:
	.global L_8c63a4
L_8c63a4:
	mov_s r3,r0
L_8c63a6:
	mov_s r2,r1
L_8c63a8:
	mov_s r0,0x1
L_8c63aa:
	b.d L_8e0718
L_8c63ae:
	mov_s r1,r3
