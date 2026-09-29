/* ucode_cmd_keep_alive_trigger @ 0x9296c0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: keep_alive__arm_slot
 */
	.section .text.ucode_cmd_keep_alive_trigger,"ax",@progbits
	.global ucode_cmd_keep_alive_trigger
ucode_cmd_keep_alive_trigger:
	.global L_9296c0
L_9296c0:
	b.d L_933d2c
L_9296c4:
	ldb_s r0,[r0]
L_9296c6:
	nop_s
