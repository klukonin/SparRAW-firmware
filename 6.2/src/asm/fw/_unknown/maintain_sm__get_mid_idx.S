/* maintain_sm__get_mid_idx @ 0x8cc3d4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_sm__action_8ddb58, maintain_sm__action_8f2f0c, maintain_sm__action_8f96c4, maintain_sm__lock_radio
 * Зовёт сам: conn__get_radio_ctx_byte10
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__get_mid_idx
maintain_sm__get_mid_idx:
	.global L_8cc3d4
L_8cc3d4:
	b.d L_8cc414
L_8cc3d8:
	ld_s r0,[r0,0x8]
L_8cc3da:
	nop_s
