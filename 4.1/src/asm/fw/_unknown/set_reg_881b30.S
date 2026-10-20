/* set_reg_881b30 @ 0x8db318, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_offload__cfg_rx_decap
 */
	.section .text.set_reg_881b30,"ax",@progbits
	.global set_reg_881b30
set_reg_881b30:
	.global L_8db318
L_8db318:
	mov_s r1,0x881b00
L_8db31e:
	st_s r0,[r1,0x30]
L_8db320:
	j_s [blink]
L_8db322:
	nop_s
