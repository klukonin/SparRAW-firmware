/* brp__set_tx_sector_id @ 0x93e33c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__tx_request, brp_responder_transmission_flow
 * Зовёт сам: bf_rmw_word_unaligned_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__set_tx_sector_id
brp__set_tx_sector_id:
	.global L_93e33c
L_93e33c:
	mov r10,0xb
L_93e340:
	b.d L_93ec10
L_93e344:
	mov r11,0x5
