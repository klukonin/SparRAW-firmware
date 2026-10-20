/* bcon_ss__call_vmethod_14 @ 0x8ca8ac, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcn_tx_init_ss_params, lmac_if_send_cmd_0x0c
 */
	.section .text.bcon_ss__call_vmethod_14,"ax",@progbits
	.global bcon_ss__call_vmethod_14
bcon_ss__call_vmethod_14:
	.global L_8ca8ac
L_8ca8ac:
	ld_s r0,[r0,0x20]
L_8ca8ae:
	ld_s r2,[r0]
L_8ca8b0:
	ld_s r2,[r2,0x14]
L_8ca8b2:
	j_s [r2]
