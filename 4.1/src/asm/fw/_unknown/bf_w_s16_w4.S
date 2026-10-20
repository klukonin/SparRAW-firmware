/* bf_w_s16_w4 @ 0x8e83cc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_send_cmd_0x11, tx_desc__build, tx_queue__config_by_mode_b, vring_macq_delete_step
 * Зовёт сам: bf_word_set
 */
	.section .text.bf_w_s16_w4,"ax",@progbits
	.global bf_w_s16_w4
bf_w_s16_w4:
	.global L_8e83cc
L_8e83cc:
	mov r10,0x10
L_8e83d0:
	b.d L_8e8910
L_8e83d4:
	mov r11,0x3
