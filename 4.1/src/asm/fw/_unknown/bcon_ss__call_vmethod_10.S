/* bcon_ss__call_vmethod_10 @ 0x8ca8dc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcn_tx_init_ss_params, lmac_if_send_cmd_0x0c
 */
	.section .text.bcon_ss__call_vmethod_10,"ax",@progbits
	.global bcon_ss__call_vmethod_10
bcon_ss__call_vmethod_10:
	.global L_8ca8dc
L_8ca8dc:
	ld_s r0,[r0,0x20]
L_8ca8de:
	ld_s r2,[r0]
L_8ca8e0:
	ld_s r2,[r2,0x10]
L_8ca8e2:
	j_s [r2]
